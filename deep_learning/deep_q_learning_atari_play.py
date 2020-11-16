import copy

import numpy as np
import gym
import collections
import cv2
import os
import torch as T
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
import av

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

    def step(self, action, observer=None):
        t_reward = 0.0
        done = False
        for i in range(self.repeat):
            obs, reward, done, info = self.env.step(action)
            if observer is not None:
                observer.observe(obs)
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
    def __init__(self, input_dims, n_actions, algo=None, env_name=None, chkpt_dir='tmp/dqn'):
        self.input_dims = input_dims
        self.n_actions = n_actions
        self.algo = algo
        self.env_name = env_name
        self.chkpt_dir = chkpt_dir
        self.q_eval = DeepQNetwork(0, n_actions,
                                   input_dims=input_dims,
                                   name=env_name+'_'+algo+'_q_eval',
                                   chkpt_dir=chkpt_dir)
        self.q_eval.load_checkpoint()


    def choose_action(self, observation):
        state = T.tensor([observation], dtype=T.float).to(self.q_eval.device)
        actions = self.q_eval.forward(state)
        return T.argmax(actions).item()


    def load_models(self):
        self.q_eval.load_checkpoint()


class AtariOberserver(object):
    def __init__(self, path):
        self.path = path
        self.frames = []


    def observe(self, observation):
        self.frames.append(copy.deepcopy(observation))

    def save(self):
        print ('... saving movie ...', len(self.frames))
        container = av.open(self.path, mode='w')

        stream = container.add_stream('mpeg4', rate=60)
        stream.width = 210
        stream.height = 160

        for input_frame in self.frames:

            img = input_frame.astype(np.uint8)
            img = np.clip(img, 0, 255)

            frame = av.VideoFrame.from_ndarray(img, format='rgb24')
            for packet in stream.encode(frame):
                container.mux(packet)

        # Flush stream
        for packet in stream.encode():
            container.mux(packet)

        # Close the file
        container.close()
        print('... movie saved ...')


if __name__ == '__main__':
    np.seterr(all='raise')
    env = make_env('PongNoFrameskip-v4')
    n_games = 1
    agent = DQNAgent(input_dims=env.observation_space.shape,
                     n_actions=env.action_space.n,
                     chkpt_dir='models/', algo='DQNAgent', env_name='PongNoFrameskip-v4')

    fname = 'plots/{}_{}.mp4'.format(agent.algo, agent.env_name)
    movie = AtariOberserver(fname)

    for i in range(n_games):
        done = False
        score = 0
        observation = env.reset()

        while not done:
            action = agent.choose_action(observation)
            observation_, reward, done, info = env.step(action, movie)
            score += reward
            observation = observation_

    movie.save()