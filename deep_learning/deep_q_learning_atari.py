import numpy as np
import gym
import collections
import cv2
import os
import torch as T
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
import matplotlib.pyplot as plt


class RepeatSkipScaleStack(gym.Wrapper):
    def __init__(self, env, repeat=4, output_shape=(4, 84, 84)):
        super(RepeatSkipScaleStack, self).__init__(env)

        self.repeat = repeat
        self.frame_buffer = np.zeros((2, *env.observation_space.low.shape), dtype=np.uint8)
        self.stack = collections.deque(maxlen=output_shape[0])
        self.observation_space = gym.spaces.Box(low=0.0, high=1.0, shape=output_shape, dtype=np.float32)

    def _resize_observation(self, observation):
        new_frame = cv2.cvtColor(observation, cv2.COLOR_BGR2GRAY)
        resize_screen = cv2.resize(new_frame, (84, 84), interpolation=cv2.INTER_AREA)
        new_obs = np.array(resize_screen, dtype=np.float32).reshape(self.observation_space.low.shape[1:])
        new_obs /= 255.0
        return new_obs

    def reset(self, **kwargs):
        self.stack.clear()
        observation = self.env.reset()
        observation = self._resize_observation(observation)
        for _ in range(self.stack.maxlen):
            self.stack.append(observation)

        return np.array(self.stack).reshape(self.observation_space.low.shape)

    def step(self, action):
        t_reward = 0.0
        done = False
        for i in range(self.repeat):
            obs, reward, done, info = self.env.step(action)
            t_reward += reward
            idx = i % 2
            self.frame_buffer[idx] = obs
            if done:
                break

        max_frame = np.maximum(self.frame_buffer[0], self.frame_buffer[1])
        observation = self._resize_observation(max_frame)
        self.stack.append(observation)
        frames = np.array(self.stack).reshape(self.observation_space.low.shape)
        return frames, t_reward, done, info


def make_env(env_name, shape=(4,84,84), repeat=4):
    env = gym.make(env_name)
    env = RepeatSkipScaleStack(env, repeat=repeat, output_shape=shape)
    return env


class ReplayBuffer(object):
    def __init__(self, max_size, input_shapes):
        self.mem_size = max_size
        self.mem_ctr = 0
        self.state = np.zeros((self.mem_size, *input_shapes), dtype=np.float32)
        self.new_state = np.zeros((self.mem_size, *input_shapes), dtype=np.float32)
        self.action = np.zeros(self.mem_size, dtype=np.int64)
        self.reward = np.zeros(self.mem_size, dtype=np.float32)
        self.terminal = np.zeros(self.mem_size, dtype=np.bool)

    def store_transition(self, state, action, reward, state_, done):
        idx = self.mem_ctr % self.mem_size
        self.state[idx] = state
        self.new_state[idx] = state_
        self.action[idx] = action
        self.reward[idx] = reward
        self.terminal[idx] = done
        self.mem_ctr += 1

    def sample_buffer(self, batch_size):
        max_mem = min(self.mem_size, self.mem_ctr)
        batch = np.random.choice(max_mem, batch_size, replace=False)
        return (
            self.state[batch],
            self.action[batch],
            self.reward[batch],
            self.new_state[batch],
            self.terminal[batch]
        )


class DeepQNetwork(nn.Module):
    def __init__(self, lr, n_actions, name, input_dims, chkpt_dir):
        super(DeepQNetwork, self).__init__()
        self.checkpoint_dir = chkpt_dir
        self.checkpoint_file = os.path.join(self.checkpoint_dir, name+'.ckp')

        self.conv1 = nn.Conv2d(input_dims[0], 32, 8, stride=4)
        self.conv2 = nn.Conv2d(32, 64, 4, stride=2)
        self.conv3 = nn.Conv2d(64, 64, 3, stride=1)

        fc_input_dims = self.calculate_conv_output_dims(input_dims)

        self.fc1 = nn.Linear(fc_input_dims, 512)
        self.fc2 = nn.Linear(512, n_actions)

        self.optimizer = optim.RMSprop(self.parameters(), lr=lr)
        self.loss = nn.MSELoss()
        self.device = T.device('cuda:0')
        self.to(self.device)

    def calculate_conv_output_dims(self, input_dims):
        state = T.zeros(1, *input_dims)
        dims = self.conv1(state)
        dims = self.conv2(dims)
        dims = self.conv3(dims)
        return int(np.prod(dims.size()))

    def forward(self, state):
        conv1 = F.relu(self.conv1(state))
        conv2 = F.relu(self.conv2(conv1))
        conv3 = F.relu(self.conv3(conv2))
        # conv3 shape is BS * n_filters * H * W
        conv_state = conv3.view(conv3.size()[0], -1)
        flat1 = F.relu(self.fc1(conv_state))
        actions = self.fc2(flat1)

        return actions

    def save_checkpoint(self):
        print('... saving checkpoint ...')
        T.save(self.state_dict(), self.checkpoint_file)

    def load_checkpoint(self):
        print('... load checkpoint ...')
        self.load_state_dict(T.load(self.checkpoint_file))


class DQNAgent(object):
    def __init__(self, gamma, epsilon, lr, n_actions, input_dims, mem_size, batch_size, eps_min=0.01, eps_dec=5e-7,
                 replace=1000, algo=None, env_name=None, chkpt_dir='tmp/dqn'):
        self.gamma = gamma
        self.epsilon = epsilon
        self.lr = lr
        self.n_actions = n_actions
        self.input_dims = input_dims
        self.mem_size = mem_size
        self.batch_size = batch_size
        self.eps_min = eps_min
        self.eps_dec = eps_dec
        self.replace_target = replace
        self.algo = algo
        self.env_name = env_name
        self.chkpt_dir = chkpt_dir
        self.action_space = [i for i in range(self.n_actions)]
        self.learn_step_counter = 0

        self.memory = ReplayBuffer(mem_size, input_dims)

        self.q_eval = DeepQNetwork(self.lr, self.n_actions,
                                   input_dims=self.input_dims,
                                   name=self.env_name+'_'+self.algo+'_q_eval',
                                   chkpt_dir=self.chkpt_dir)

        self.q_next = DeepQNetwork(self.lr, self.n_actions,
                                   input_dims=self.input_dims,
                                   name=self.env_name + '_' + self.algo + '_q_next',
                                   chkpt_dir=self.chkpt_dir)

    def choose_action(self, observation):
        if np.random.random() > self.epsilon:
            state = T.tensor([observation], dtype=T.float).to(self.q_eval.device)
            actions = self.q_eval.forward(state)
            action = T.argmax(actions).item()
        else:
            action = np.random.choice(self.action_space)
        return action

    def store_transition(self, state, action, reward, state_, done):
        self.memory.store_transition(state, action, reward, state_, done)

    def sample_memory(self):
        state, action, reward, new_state, done = self.memory.sample_buffer(self.batch_size)

        state = T.tensor(state).to(self.q_eval.device)
        action = T.tensor(action).to(self.q_eval.device)
        reward = T.tensor(reward).to(self.q_eval.device)
        new_state = T.tensor(new_state).to(self.q_eval.device)
        done = T.tensor(done).to(self.q_eval.device)

        return state, action, reward, new_state, done

    def replace_target_network(self):
        if self.learn_step_counter % self.replace_target == 0:
            self.q_next.load_state_dict(self.q_eval.state_dict())

    def decrement_epsilon(self):
        self.epsilon = self.epsilon - self.eps_dec
        self.epsilon = max(self.epsilon, self.eps_min)

    def save_models(self):
        self.q_eval.save_checkpoint()
        self.q_next.save_checkpoint()

    def load_models(self):
        self.q_eval.load_checkpoint()
        self.q_next.load_checkpoint()

    def learn(self):
        if self.memory.mem_ctr > self.batch_size:

            self.q_eval.optimizer.zero_grad()
            self.replace_target_network()

            states, actions, rewards, states_, dones = self.sample_memory()

            indices = np.arange(self.batch_size)
            q_pred = self.q_eval.forward(states)[indices, actions]
            q_next = self.q_next.forward(states_).max(dim=1)[0]
            q_next[dones] = 0.0 #if we are done we dont have any reward

            q_target = rewards + self.gamma*q_next

            loss = self.q_eval.loss(q_target, q_pred).to(self.q_eval.device)
            loss.backward()
            self.q_eval.optimizer.step()

            self.learn_step_counter += 1
            self.decrement_epsilon()


def plot_learning_curve(x, scores, epsilons, filename, lines=None):
    fig=plt.figure()
    ax=fig.add_subplot(111, label="1")
    ax2=fig.add_subplot(111, label="2", frame_on=False)

    ax.plot(x, epsilons, color="C0")
    ax.set_xlabel("Training Steps", color="C0")
    ax.set_ylabel("Epsilon", color="C0")
    ax.tick_params(axis='x', colors="C0")
    ax.tick_params(axis='y', colors="C0")

    N = len(scores)
    running_avg = np.empty(N)
    for t in range(N):
	    running_avg[t] = np.mean(scores[max(0, t-20):(t+1)])

    ax2.scatter(x, running_avg, color="C1")
    ax2.axes.get_xaxis().set_visible(False)
    ax2.yaxis.tick_right()
    ax2.set_ylabel('Score', color="C1")
    ax2.yaxis.set_label_position('right')
    ax2.tick_params(axis='y', colors="C1")

    if lines is not None:
        for line in lines:
            plt.axvline(x=line)

    plt.savefig(filename)


if __name__ == '__main__':
    np.seterr(all='raise')
    env = make_env('PongNoFrameskip-v4')
    best_score = -np.inf
    learning_mode = True
    load_checkpoint = False
    n_games = 1000
    agent = DQNAgent(gamma=0.99, epsilon=1.0, lr=0.0001, input_dims=env.observation_space.shape,
                     n_actions=env.action_space.n, mem_size=50000, eps_min=0.1, batch_size=32,
                     replace=1000, eps_dec=1e-5, chkpt_dir='models/', algo='DQNAgent',
                     env_name='PongNoFrameskip-v4')

    if load_checkpoint:
        agent.load_models()

    fname = 'plots/{}_{}_{}_lr_{}_games.png'.format(agent.algo, agent.env_name, str(agent.lr), str(n_games))

    n_steps = 0
    scores, eps_history, steps_array = [], [], []

    for i in range(n_games):
        done = False
        score = 0
        observation = env.reset()

        while not done:
            action = agent.choose_action(observation)
            observation_, reward, done, info = env.step(action)
            score += reward

            if learning_mode:
                agent.store_transition(observation, action, reward, observation_, int(done))
                agent.learn()
            observation = observation_
            n_steps += 1

        scores.append(score)
        steps_array.append(n_steps)

        avg_score = np.mean(scores[-100:])
        print('episode', i, 'score', score,
              'average score {} best score {} epsilon {}'.format(avg_score, best_score, agent.epsilon),
              'steps', n_steps)

        if avg_score > best_score:
            if learning_mode:
                agent.save_models()
            best_score = avg_score

        eps_history.append(agent.epsilon)

    plot_learning_curve(steps_array, scores, eps_history, fname)

