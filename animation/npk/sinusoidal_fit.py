import numpy as np
from scipy import optimize


def fit(X,
        y,
        population_count=100,
        elite_count=2,
        velocity_rate=0.001,
        epoch_count=25):

    params_count = 4
    lower_limits = np.array([0, 0, -np.pi, -1])
    upper_limits = np.array([1, np.pi * 2, np.pi, 1])
    bounds = np.array([(l, u) for l, u in zip(lower_limits, upper_limits)])

    def function(afsb, t):
        return afsb[..., 0:1] * np.sin(afsb[..., 1:2] * t - afsb[..., 2:3]) + afsb[..., 3:4]

    def error(params, X, y):
        y_ = function(params, X)
        return np.sqrt(np.sum((y - y_) ** 2, axis=-1) / X.shape[-1])

    def extinctions(fitness):
        return (swarm_fitness + np.min(swarm_fitness) * (
                    ((params_count - 1.0) / (population_count - 1.0)) - 1.0)) / np.max(
            swarm_fitness)

    # initial population
    swarm_positions = np.random.uniform(lower_limits, upper_limits, (population_count, params_count))
    swarm_velocities = np.random.uniform(-0.1, 0.1, population_count * params_count).reshape(
        (population_count, params_count))
    swarm_fitness = error(swarm_positions, X[np.newaxis, :], y)
    swarm_extinction = extinctions(swarm_fitness)
    swarm_sorted_args = np.argsort(swarm_fitness, axis=0)

    # global best
    solution = swarm_positions[swarm_sorted_args[0], ...]
    best_fitness = swarm_fitness[swarm_sorted_args[0]]

    # iterate
    for epoch in range(epoch_count):
        # early exit if close enough
        if best_fitness < 1e-6:
            break

        # pick elites and do a gradient descent using l-bfgs-b algorithm
        for e in range(elite_count):
            x, _, _ = optimize.fmin_l_bfgs_b(
                func=error,
                x0=swarm_positions[swarm_sorted_args[e], ...],
                args=(X[np.newaxis, :], y),
                approx_grad=True,
                bounds=bounds,
                maxiter=100)
            swarm_velocities[swarm_sorted_args[e], ...] = np.random.uniform() * \
                                                          swarm_velocities[swarm_sorted_args[e], ...] + x - \
                                                          swarm_positions[swarm_sorted_args[e], ...]
            swarm_positions[swarm_sorted_args[e], ...] = x

        # create the offsprings
        offspring_positions = np.zeros((population_count, params_count), dtype=np.float32)
        offspring_velocities = np.zeros((population_count, params_count), dtype=np.float32)
        offspring_fitness = np.zeros(population_count, dtype=np.float32)

        # populate offsprings
        for off in range(population_count):
            parents_count = len(swarm_sorted_args)

            # rank based selection
            probabilities = np.array([parents_count - i for i in range(parents_count)], dtype=np.float32)
            probabilities /= np.sum(probabilities)
            a, b, prot = np.random.choice(swarm_sorted_args, 3, p=probabilities, replace=False)

            # combine parents
            mix_values = np.random.uniform(size=params_count)
            offspring_positions[off, :] = swarm_positions[a, :] * mix_values + \
                                          swarm_positions[b, :] * (1.0 - mix_values)

            # add a bit of the velocity from the parents
            offspring_positions[off, :] += velocity_rate * (swarm_velocities[a, :] + swarm_velocities[b, :])

            # use the velocities from the parents
            offspring_velocities[off, :] = np.random.uniform(size=params_count) * swarm_velocities[a, :] + \
                                           np.random.uniform(size=params_count) * swarm_velocities[b, :]

            # mutate
            p = (np.mean(swarm_extinction[[a, b]]) * (params_count - 1.0) + 1.0) / params_count
            if p < np.random.uniform():
                swarm_min = np.min(swarm_positions, axis=0)
                swarm_max = np.max(swarm_positions, axis=0)
                x = np.random.uniform(-1, 1, size=params_count) * np.mean(swarm_extinction[[a, b]]) * (
                        swarm_max - swarm_min)
                offspring_velocities[off, :] += x
                offspring_positions[off, :] += x

            # adoption
            mix_values = np.random.uniform(size=params_count)
            average_parents = np.mean(swarm_positions[[a, b], :], axis=0)
            x = mix_values * (average_parents - offspring_positions[off, :])
            mix_values = np.random.uniform(size=params_count)
            x += mix_values * (offspring_positions[prot, :] - offspring_positions[off, :])
            offspring_velocities[off, :] += x
            offspring_positions[off, :] += x

            # clip
            offspring_positions[off, :] = np.clip(offspring_positions[off, :], a_min=lower_limits, a_max=upper_limits)

            # compute fitness of this offspring
            offspring_fitness[off] = error(offspring_positions[off, :], X, y)

        # assign offsprings to population
        swarm_positions = offspring_positions
        swarm_velocities = offspring_velocities
        swarm_fitness = offspring_fitness

        # sort everyone
        swarm_sorted_args = np.argsort(swarm_fitness, axis=0)
        swarm_extinction = extinctions(swarm_fitness)

        # try update solution
        if swarm_fitness[swarm_sorted_args[0]] < best_fitness:
            best_fitness = swarm_fitness[swarm_sorted_args[0]]
            solution = swarm_positions[swarm_sorted_args[0], ...]

    return solution, best_fitness



def fast_fit(X,
             y,
             population_count=200,
             epoch_count=400,
             original_fit=None):

    weights = np.ones_like(X)
    #weights[:len(X)-2] = np.linspace(0.2, 1.0, len(X) - 2)
    #weights[len(X) - 2:] = np.linspace(1.0, 0.2, len(X) - 2)

    def function(afsb, t):
        return afsb[..., 0:1] * np.sin(afsb[..., 1:2] * t - afsb[..., 2:3]) + afsb[..., 3:4]

    def error(params, X, y):
        y_ = function(params, X)
        return np.sqrt(np.sum(((y - y_) ** 2) * weights, axis=-1) / X.shape[-1])

    params_count = 4
    lower_limits = np.array([0, 0, -np.pi, -.5])
    upper_limits = np.array([1, np.pi * 2, np.pi, .5])
    bounds = np.array([(l, u) for l, u in zip(lower_limits, upper_limits)])

    lower_limits = lower_limits[np.newaxis, :] * np.ones((population_count, 1))
    upper_limits = upper_limits[np.newaxis, :] * np.ones((population_count, 1))
    steps_size = (upper_limits - lower_limits) * 0.1

    population = np.random.uniform(lower_limits, upper_limits, (population_count, params_count))
    if original_fit is not None:
        population = original_fit[np.newaxis, :] * np.ones((population_count, 1))
        population = np.random.normal(population, steps_size)

    fitness = error(population, X[np.newaxis, :], y)

    for epoch in range(epoch_count):
        new_population = np.random.normal(population, steps_size)
        new_population = np.clip(new_population, a_min=lower_limits, a_max=upper_limits)
        new_fitness = error(new_population, X[np.newaxis, :], y)
        is_better = new_fitness < fitness
        population[is_better] = new_population[is_better]
        fitness[is_better] = new_fitness[is_better]
        steps_size *= 0.999

    sorted_args = np.argsort(fitness, axis=0)

    x, f, _ = optimize.fmin_l_bfgs_b(
        func=error,
        x0=population[sorted_args[0], :],
        args=(X[np.newaxis, :], y),
        approx_grad=True,
        bounds=bounds)

    return x, f