import numpy as np
import random
import gym


def train_q_table(env, epoch=10000, explore_ratio=0.1, learning_rate=0.1, future_weight=0.9):
    qtable = np.zeros((env.observation_space.n, env.action_space.n))

    for e in range(epoch):
        state = env.reset()

        done = False
        while not done:

            # we check if we want to use the qtable or a random action
            action = 0
            if random.uniform(0, 1) < explore_ratio:
                action = env.action_space.sample()
            else:
                action = np.argmax(qtable[state, :])

            # we take the action
            state_, reward, done, info = env.step(action)

            # Bell equation
            qtable[state, action] = (1.0 - learning_rate) * qtable[state, action] + \
                learning_rate * (reward + future_weight * np.max(qtable[state_, :]))

            # prepare for next loop
            state = state_

        if e % 1000 == 0:
            print(e)

    return qtable


def play(env, qtable):
    env.render()
    state = env.s
    done = False
    while not done:
        action = np.argmax(qtable[state, :])
        state, reward, done, info = env.step(action)
        env.render()

# create the taxi - v3 environment
env = gym.make("Taxi-v3").env
qtable = train_q_table(env)

env.reset()
play(env, qtable)
