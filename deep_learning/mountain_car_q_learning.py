import numpy as np
import gym
import matplotlib.pyplot as plt
import random
import time

env = gym.make('MountainCar-v0').env
env.reset()

pos_space = np.linspace(-1.2, 0.6, 20)
vel_space = np.linspace(-0.07, 0.07, 20)

def get_state(observation):
    pos, vel = observation
    return np.digitize(pos, pos_space) * 20 + np.digitize(vel, vel_space)


def train_q_table(env, epoch=10000, lr=0.1, epsilon=0.1, eps_dec=1E-5, eps_end=0.1, gamma=0.9):
    qtable = np.zeros((20*20, 3))

    epoch_scores = np.zeros(epoch)
    for e in range(epoch):
        state = get_state(env.reset())

        done = False
        total_score = 0
        while not done:

            # we check if we want to use the qtable or a random action
            action = 0
            if random.uniform(0, 1) < epsilon:
                action = env.action_space.sample()
            else:
                action = np.argmax(qtable[state, :])

            # we take the action
            observation, reward, done, info = env.step(action)
            state_ = get_state(observation)
            total_score += reward

            # Bell equation
            qtable[state, action] = qtable[state, action] + lr * \
                                    (reward + gamma * np.max(qtable[state_, :]) - qtable[state, action])

            # prepare for next loop
            state = state_

        epsilon -= eps_dec
        epsilon = max(epsilon, eps_end)

        if e % 100 == 0:
            print(e, total_score, epsilon)

        epoch_scores[e] = total_score

    plt.plot(epoch_scores)
    plt.savefig('mountain_car_scores.png')
    return qtable

qtable = train_q_table(env, epoch=300, lr=0.1, gamma=0.99, epsilon=1.0, eps_dec=0.005, eps_end=0.01)


for i in range(10):
    done = False
    total_score = 0
    state = get_state(env.reset())
    while not done:
        action = np.argmax(qtable[state, :])

        # we take the action
        observation, reward, done, info = env.step(action)
        state = get_state(observation)
        total_score += reward

        env.render()