import numpy as np
import sinusoidal_fit


def get_foot_phase_sinusoidal(phase, window_size=20, normalized=False):
    anim_len = len(phase)

    window_size = min(window_size, int(anim_len / 4))

    phase_normal = phase
    if normalized:
        phase_normal = np.zeros(anim_len)
        for t in range(anim_len):
            s = max(0, t - window_size)
            e = min(anim_len, t + window_size)
            mean = np.mean(phase[s:e])
            std = np.std(phase[s:e])
            phase_normal[t] = (phase[t] - mean) / (std + 1e-8)

    fitted = np.zeros((anim_len, 5), dtype=np.float32)
    fitted[:, 0] = phase_normal
    last_solution = None
    for t in range(0, anim_len):
        s = max(0, t - window_size)
        e = min(anim_len, t + window_size)

        lnspace = np.array(range(s, e), dtype=np.float32) / 30.0
        data = phase_normal[s:e]
        solution, fitness = sinusoidal_fit.fast_fit(lnspace, data, original_fit=last_solution)
        #solution, fitness = sinusoidal_fit.fit(lnspace, data)
        last_solution = solution
        print(fitness, float(t)/anim_len)

        #a, f, s, b = solution
        fitted[t, 1:] = solution
        #fitted[t] = a * np.sin(f * t - s) + b
        #fitted[t] = (f * t - s) % (np.pi*2)

    return fitted