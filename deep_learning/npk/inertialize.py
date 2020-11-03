import numpy as np
import posquat as pq
import copy


def _inertialize(x0, v0, t1, t):
    # check if the velocity is going toward reaching 0 or not

    # adjusted time
    t1adjusted = -5.0 * x0 / (v0 + 0.00001)
    t1adjusted = np.maximum(t1adjusted, 0.00001)
    t1adjusted = np.where(v0 < 0, t1adjusted, t1)
    t1 = np.minimum(t1adjusted, t1)
    t = np.minimum(t, t1)

    # adjusted velocity
    v0 = np.maximum(v0, 0)

    # compute the acceleration
    a0 = np.maximum((-8.0 * v0 * t1 - 20.0 * x0) / (t1 * t1), 0)

    # compute the factors of the polynomial
    A = -(a0 * t1 * t1 + 6.0 * v0 * t1 + 12.0 * x0) / (2.0 * t1 * t1 * t1 * t1 * t1)
    B = (3.0 * a0 * t1 * t1 + 16.0 * v0 * t1 + 30.0 * x0) / (2.0 * t1 * t1 * t1 * t1)
    C = -(3.0 * a0 * t1 * t1 + 12.0 * v0 * t1 + 20.0 * x0) / (2.0 * t1 * t1 * t1)

    xt = A * t * t * t * t * t + B * t * t * t * t + C * t * t * t + a0 * 0.5 * t * t + v0 * t + x0
    return xt


def inertialize_vector(frame_m2, frame_m1, target, current, dt, blendTime, t):
    vx0 = frame_m1 - target
    vxm1 = frame_m2 - target

    x0 = np.sqrt(np.sum(vx0 * vx0, axis=-1, keepdims=True))
    vx0_dir = vx0 / (x0 + 0.00001)

    xm1 = np.einsum('ij,ij->i', vxm1, vx0_dir)[..., np.newaxis]
    #xm1 = np.dot(vxm1, vx0_dir)
    v0 = (x0 - xm1) / dt

    xt = _inertialize(x0, v0, blendTime, t)

    result = np.where(x0 < 0.001, current, current + vx0_dir * xt)
    return result


def inertialize_quaternion(frame_m2, frame_m1, target, current, dt, blendTime, t):
    frame_m1 = np.where((np.sum(frame_m1 * current, axis=-1) < 0)[..., np.newaxis].repeat(4, axis=-1), pq.quat_flip(frame_m1), frame_m1)
    frame_m2 = np.where((np.sum(frame_m2 * current, axis=-1) < 0)[..., np.newaxis].repeat(4, axis=-1), pq.quat_flip(frame_m2), frame_m2)
    target = np.where((np.sum(target * current, axis=-1) < 0)[..., np.newaxis].repeat(4, axis=-1), pq.quat_flip(target), target)

    q0 = pq.vec_normalize(pq.quat_mul(frame_m1, pq.quat_conj(target), False))
    q1 = pq.vec_normalize(pq.quat_mul(frame_m2, pq.quat_conj(target), False))

    x0, vx0 = pq.quat_to_angle_axis(pq.vec_normalize(q0))
    x1, vx1 = q1[..., 0:1], q1[..., 1:]

    xm1 = 2 * np.arctan(np.einsum('ij,ij->i', vx1, vx0)[..., np.newaxis] / (x1 + 1e-6))
    #xm1 = 2 * np.arctan(np.dot(vx1, vx0) / (x1 + 1e-6))

    v0 = (x0 - xm1) / dt

    xt = _inertialize(x0, v0, blendTime, t)
    return pq.vec_normalize(pq.quat_mul(pq.quat_from_angle_axis(xt, vx0), current, False))


def inplace_inertialize(anim, startFrame, inertializeLength):
    pos, quat = anim[0], anim[1]

    m2pos, m2quat = pos[startFrame - 2, ...], quat[startFrame - 2, ...]
    m1pos, m1quat = pos[startFrame - 1, ...], quat[startFrame - 1, ...]

    # maximum the length of the animation
    inertializeLength += min(0, len(pos) - startFrame - inertializeLength)

    startpos = copy.deepcopy(pos[startFrame, ...])
    startquat = copy.deepcopy(quat[startFrame, ...])

    t1 = float(inertializeLength) / 30.0
    for frame in range(startFrame, startFrame+inertializeLength):
        t = float(frame - startFrame + 1) / 30.0
        pos[frame, ...] = inertialize_vector(
            m2pos,
            m1pos,
            startpos,
            pos[frame, ...],
            1.0/30.0, t1, t)
        quat[frame, ...] = inertialize_quaternion(
            m2quat,
            m1quat,
            startquat,
            quat[frame, ...],
            1.0 / 30.0, t1, t)

    return anim