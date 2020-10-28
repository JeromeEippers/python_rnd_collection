import numpy as np
from scipy.spatial.transform import Rotation as R


def vec_cross3(a, b):
    """Compute a cross product for a list of vectors"""
    return np.concatenate([
        a[..., 1:2] * b[..., 2:3] - a[..., 2:3] * b[..., 1:2],
        a[..., 2:3] * b[..., 0:1] - a[..., 0:1] * b[..., 2:3],
        a[..., 0:1] * b[..., 1:2] - a[..., 1:2] * b[..., 0:1],
    ], axis=-1)


def quat_mul(x, y):
    x0, x1, x2, x3 = x[..., 0:1], x[..., 1:2], x[..., 2:3], x[..., 3:4]
    y0, y1, y2, y3 = y[..., 0:1], y[..., 1:2], y[..., 2:3], y[..., 3:4]

    return np.concatenate([
        y0 * x0 - y1 * x1 - y2 * x2 - y3 * x3,
        y0 * x1 + y1 * x0 - y2 * x3 + y3 * x2,
        y0 * x2 + y1 * x3 + y2 * x0 - y3 * x1,
        y0 * x3 - y1 * x2 + y2 * x1 + y3 * x0], axis=-1)


def quat_mul_vec(quaternions, vectors):
    q2 = np.zeros_like(quaternions)
    q2[..., 1:] = vectors

    return (
        (quat_mul(quat_conj(quaternions), quat_mul(q2, quaternions)))[..., 1:]
    )


def quat_conj(x):
    return np.array([1, -1, -1, -1], dtype=np.float32) * x


def quat_flip(x):
    return np.array([-1, -1, -1, -1], dtype=np.float32) * x


def quat_slerp(x, y, a, eps=1e-10):
    # WARNING CANNOT SLERP IDENTITY WITH IDENTITY

    y = np.where((np.sum(x * y, axis=-1) < 0)[..., np.newaxis].repeat(4, axis=-1), quat_flip(y), y)

    l = np.sum(x * y, axis=-1)
    o = np.arccos(np.clip(l, -1.0, 1.0))
    a0 = np.sin((1.0 - a) * o) / (np.sin(o) + eps)
    a1 = np.sin((a) * o) / (np.sin(o) + eps)
    return a0[..., np.newaxis] * x + a1[..., np.newaxis] * y


def quat_from_angle_axis(angle, axis):
    x, y, z = axis[..., 0:1], axis[..., 1:2], axis[..., 2:3]
    theta = angle/2
    sintheta = np.ones_like(x[..., 0])[...,np.newaxis] * np.sin(theta)
    return np.concatenate([
        np.ones_like(x[..., 0])[...,np.newaxis] * np.cos(theta),
        x * sintheta,
        y * sintheta,
        z * sintheta], axis=-1)


def quat_average(Q, weights=None):
        '''
        Averaging Quaternions.

        Arguments:
            Q(ndarray): an Mx4 ndarray of quaternions.
            weights(list): an M elements list, a weight for each quaternion.
        '''

        # TODO does not support multidimension at this point

        # Form the symmetric accumulator matrix
        A = np.zeros((4, 4))
        M = Q.shape[0]
        wSum = 0

        if weights is None:
            weights = np.ones(M)

        for i in range(M):
            q = Q[i, :]
            w_i = weights[i]
            A += w_i * (np.outer(q, q))  # rank 1 update
            wSum += w_i

        # scale
        A /= wSum

        # Get the eigenvector corresponding to largest eigen value
        return np.linalg.eigh(A)[1][:, -1]


def vec_normalize(x, eps=0.0):
    return x / (np.sqrt(np.sum(x * x, axis=-1, keepdims=True)) + eps)


def quat_lerp(a, b, t):
    b = np.where((np.sum(b * a, axis=-1) < 0)[..., np.newaxis].repeat(4, axis=-1), quat_flip(b), b)
    return vec_normalize(a * (1.0 - t) + b * t)


def quat_to_m33(x):
    qw, qx, qy, qz = x[..., 0:1], x[..., 1:2], x[..., 2:3], x[..., 3:4]

    x2, y2, z2 = qx + qx, qy + qy, qz + qz
    xx, yy, wx = qx * x2, qy * y2, qw * x2
    xy, yz, wy = qx * y2, qy * z2, qw * y2
    xz, zz, wz = qx * z2, qz * z2, qw * z2

    return np.concatenate([
        np.concatenate([1.0 - (yy + zz), xy - wz, xz + wy], axis=-1)[..., np.newaxis, :],
        np.concatenate([xy + wz, 1.0 - (xx + zz), yz - wx], axis=-1)[..., np.newaxis, :],
        np.concatenate([xz - wy, yz + wx, 1.0 - (xx + yy)], axis=-1)[..., np.newaxis, :],
    ], axis=-2)


def m33_to_quat(ts, eps=1e-10):
    qs = np.empty_like(ts[..., :1, 0].repeat(4, axis=-1))

    t = ts[..., 0, 0] + ts[..., 1, 1] + ts[..., 2, 2]

    s = 0.5 / np.sqrt(np.maximum(t + 1, eps))
    qs = np.where((t > 0)[..., np.newaxis].repeat(4, axis=-1), np.concatenate([
        (0.25 / s)[..., np.newaxis],
        (s * (ts[..., 2, 1] - ts[..., 1, 2]))[..., np.newaxis],
        (s * (ts[..., 0, 2] - ts[..., 2, 0]))[..., np.newaxis],
        (s * (ts[..., 1, 0] - ts[..., 0, 1]))[..., np.newaxis]
    ], axis=-1), qs)

    c0 = (ts[..., 0, 0] > ts[..., 1, 1]) & (ts[..., 0, 0] > ts[..., 2, 2])
    s0 = 2.0 * np.sqrt(np.maximum(1.0 + ts[..., 0, 0] - ts[..., 1, 1] - ts[..., 2, 2], eps))
    qs = np.where(((t <= 0) & c0)[..., np.newaxis].repeat(4, axis=-1), np.concatenate([
        ((ts[..., 2, 1] - ts[..., 1, 2]) / s0)[..., np.newaxis],
        (s0 * 0.25)[..., np.newaxis],
        ((ts[..., 0, 1] + ts[..., 1, 0]) / s0)[..., np.newaxis],
        ((ts[..., 0, 2] + ts[..., 2, 0]) / s0)[..., np.newaxis]
    ], axis=-1), qs)

    c1 = (~c0) & (ts[..., 1, 1] > ts[..., 2, 2])
    s1 = 2.0 * np.sqrt(np.maximum(1.0 + ts[..., 1, 1] - ts[..., 0, 0] - ts[..., 2, 2], eps))
    qs = np.where(((t <= 0) & c1)[..., np.newaxis].repeat(4, axis=-1), np.concatenate([
        ((ts[..., 0, 2] - ts[..., 2, 0]) / s1)[..., np.newaxis],
        ((ts[..., 0, 1] + ts[..., 1, 0]) / s1)[..., np.newaxis],
        (s1 * 0.25)[..., np.newaxis],
        ((ts[..., 1, 2] + ts[..., 2, 1]) / s1)[..., np.newaxis]
    ], axis=-1), qs)

    c2 = (~c0) & (~c1)
    s2 = 2.0 * np.sqrt(np.maximum(1.0 + ts[..., 2, 2] - ts[..., 0, 0] - ts[..., 1, 1], eps))
    qs = np.where(((t <= 0) & c2)[..., np.newaxis].repeat(4, axis=-1), np.concatenate([
        ((ts[..., 1, 0] - ts[..., 0, 1]) / s2)[..., np.newaxis],
        ((ts[..., 0, 2] + ts[..., 2, 0]) / s2)[..., np.newaxis],
        ((ts[..., 1, 2] + ts[..., 2, 1]) / s2)[..., np.newaxis],
        (s2 * 0.25)[..., np.newaxis]
    ], axis=-1), qs)

    return qs


def quat_from_lookat(aim, up):
    matrices = np.zeros([3, 3]) * np.ones_like(aim[..., :1, np.newaxis].repeat(3, axis=-1))
    x = vec_normalize(aim)
    z = vec_normalize(vec_cross3(x, up))
    y = vec_normalize(vec_cross3(z, x))
    matrices[..., 0, :] = x
    matrices[..., 1, :] = y
    matrices[..., 2, :] = z
    return m33_to_quat(matrices)


def vec3_flip(x):
    return np.array([-1, -1, -1], dtype=np.float32) * x


def pose_to_pq(pose):
    quaternions = m33_to_quat(pose[..., :3, :3])
    positions = pose[..., 3, :3]
    return positions, quaternions


def pq_to_pose(pqs=None, positions=None, quaternions=None):
    if pqs is not None:
        positions, quaternions = pqs
    matrices = np.eye(4, dtype=np.float32) * np.ones_like(positions[..., :1, np.newaxis].repeat(4, axis=-1))
    matrices[..., :3, :3] = quat_to_m33(quaternions)
    matrices[..., 3, :3] = positions
    return matrices


def inv(pqs=None, positions=None, quaternions=None):
    if pqs is not None:
        positions, quaternions = pqs
    qs = quat_conj(quaternions)
    ps = vec3_flip(positions)
    return quat_mul_vec(qs, ps), qs


def mult(a, b):
    positions = quat_mul_vec(b[1], a[0])
    positions += b[0]
    quaternions = quat_mul(a[1], b[1])
    return positions, quaternions

def sub(a, b):
    positions = a[0] - b[0]
    quaternions = quat_mul(quat_conj(b[1]), a[1])
    return positions, quaternions

def add(a, b):
    positions = a[0] + b[0]
    quaternions = quat_mul(a[1], b[1])
    return positions, quaternions

def lerp(a, b, t):
    positions = a[0] * (1.0 - t) + b[0] * t
    quaternions = quat_lerp(a[1], b[1], t)
    return positions, quaternions


def transform_point(pqs, positions):
    pos = quat_mul_vec(pqs[1], positions)
    return pos + pqs[0]


def transform_vector(pqs, vector):
    return quat_mul_vec(pqs[1], vector)


def __take_one_pq(pqs, index, as_array=True):
    positions, quaternions = pqs
    if as_array:
        return positions[index][np.newaxis, ...], quaternions[index][np.newaxis, ...]
    return positions[index], quaternions[index]


def _tests_():
    a = np.array([
        [5.05513623e-04, 9.98390697e-01, 5.67055689e-02, 0.00000000e+00],
        [4.59858199e-02, -5.66687993e-02, 9.97333361e-01, 0.00000000e+00],
        [9.98941905e-01, 2.10348673e-03, -4.59404671e-02, 0.00000000e+00],
        [2.34800407e+01, 1.03402939e+02, -2.17692762e+01, 1.00000000e+00]])
    b = np.array([
        [9.71705084e-01, -2.32879069e-01, -3.94458240e-02, 0.00000000e+00],
        [-2.06373974e-02, 8.26563821e-02, -9.96364162e-01, 0.00000000e+00],
        [2.35292892e-01, 9.68986527e-01, 7.55116358e-02, 0.00000000e+00],
        [2.81058541e+01, 1.51051439e+02, -2.08025977e+01, 1.00000000e+00]])

    a_b = np.concatenate([a[np.newaxis, ...], b[np.newaxis, ...]], axis=0)

    # test conversion back and forth
    pq = pose_to_pq(a_b)
    na_b = pq_to_pose(pq)
    assert (np.allclose(a_b, na_b, rtol=1e-04, atol=1e-06))

    # test inverse
    inv_a = np.linalg.inv(a)
    inv_pq = inv(pq)
    inv_a_b = pq_to_pose(inv_pq)
    assert (np.allclose(inv_a, inv_a_b[0, ...], rtol=1e-04, atol=1e-06))

    # dot product
    a_dot_b = np.dot(a, b)
    p_a_dot_b = mult(__take_one_pq(pq, 0), __take_one_pq(pq, 1))
    n_a_dot_b = pq_to_pose(p_a_dot_b)[0, ...]
    assert (np.allclose(a_dot_b, n_a_dot_b, rtol=1e-04, atol=1e-06))

    # more dimensions
    pq = pose_to_pq(a_b[np.newaxis, ...])
    identities = pq_to_pose(mult(pq, inv(pq)))
    assert (np.allclose(identities, np.eye(4, dtype=np.float32) * np.ones([1, 2, 1, 1])))
