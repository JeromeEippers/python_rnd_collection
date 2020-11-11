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


def train_q_table(env, epoch=10000, explore_ratio=0.1, learning_rate=0.1, future_weight=0.9):
    qtable = np.zeros((20*20, 3))

    epoch_scores = np.zeros(epoch)
    for e in range(epoch):
        state = get_state(env.reset())

        done = False
        total_score = 0
        while not done:

            # we check if we want to use the qtable or a random action
            action = 0
            if random.uniform(0, 1) < explore_ratio:
                action = env.action_space.sample()
            else:
                action = np.argmax(qtable[state, :])

            # we take the action
            observation, reward, done, info = env.step(action)
            state_ = get_state(observation)
            total_score += reward

            # Bell equation
            qtable[state, action] = (1.0 - learning_rate) * qtable[state, action] + \
                learning_rate * (reward + future_weight * np.max(qtable[state_, :]))

            # prepare for next loop
            state = state_

        if e % 100 == 0:
            print(e, total_score)

        epoch_scores[e] = total_score

    plt.plot(epoch_scores)
    plt.savefig('mountain_car_scores.png')
    return qtable

qtable = train_q_table(env, epoch=1000, learning_rate=0.15, future_weight=0.99)



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
    time.sleep(1.0/30.0)