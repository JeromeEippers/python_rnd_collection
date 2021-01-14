import numpy as np
import torch as T
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
import gym
import matplotlib.pyplot as plt



class PolicyNetwork(nn.Module):
    def __init__(self, lr, input_dims, n_actions):
        super(PolicyNetwork, self).__init__()

        if T.cuda.is_available() == False:
            raise Exception('no cuda')

        self.fc1 = nn.Linear(*input_dims, 128)
        self.fc2 = nn.Linear(128, 128)
        self.fc3 = nn.Linear(128, n_actions)
        self.optimizer = optim.Adam(self.parameters(), lr=lr)
        self.device = T.device('cuda:0')
        self.to(self.device)

    def forward(self, state):
        x = F.relu(self.fc1(state))
        x = F.relu(self.fc2(x))
        actions = self.fc3(x)
        return actions


class PolicyGradientAgent(object):
    def __init__(self, lr, input_dims, gamma=0.99, n_actions=4):
        self.gamma = gamma
        self.lr = lr
        self.reward_memory = []
        self.action_memory = []

        self.policy = PolicyNetwork(self.lr, input_dims, n_actions)

    def choose_action(self, observation):
        state = T.Tensor([observation]).to(self.policy.device)

        probabilities = F.softmax(self.policy.forward(state), dim=1)
        action_probs = T.distributions.Categorical(probabilities)
        action = action_probs.sample()

        log_probs = action_probs.log_prob(action)
        self.action_memory.append(log_probs)

        return action.item()

    def store_rewards(self, reward):
        self.reward_memory.append(reward)

    def learn(self):
        self.policy.optimizer.zero_grad()

        G = np.zeros_like(self.reward_memory)
        for t in range(len(self.reward_memory)):
            G_sum = 0
            discount = 1
            for k in range(t, len(self.reward_memory)):
                G_sum += self.reward_memory[k] * discount
                discount *= self.gamma
            G[t] = G_sum
        G = T.tensor(G, dtype=T.float).to(self.policy.device)

        loss = 0
        for g, logprob in zip(G, self.action_memory):
            loss += -g * logprob
        loss.backward()
        self.policy.optimizer.step()

        self.action_memory = []
        self.reward_memory = []


def plot_learnin_curve(scores, x, filename):
    running_avg = np.zeros(len(scores))
    for i in range(len(running_avg)):
        running_avg[i] = np.mean(scores[max(0, i-100):(i+1)])
    plt.plot(x, running_avg)
    plt.title('running average of previous 100 scores')
    plt.savefig(filename)


if __name__ == '__main__':
    env = gym.make('LunarLander-v2')
    n_games = 3000
    agent = PolicyGradientAgent(gamma=0.99, lr=0.0005, input_dims=[8], n_actions=4)

    fname = 'plots/{}_{}_{}_lr_{}_games.png'.format('REINFORCE', 'LunarLander', str(agent.lr), str(n_games))

    scores = []
    for i in range(n_games):
        done = False
        observation = env.reset()
        score = 0
        while not done:
            action = agent.choose_action(observation)
            observation_, reward, done, info = env.step(action)
            score += reward
            agent.store_rewards(reward)
            observation = observation_
        agent.learn()
        scores.append(score)

        avg_score = np.mean(scores[-100:])
        print('episode', i, 'score %.2f' % score, 'average score %.2f' % avg_score)

    x = [i+1 for i in range(len(scores))]
    plot_learnin_curve(scores, x, fname)
