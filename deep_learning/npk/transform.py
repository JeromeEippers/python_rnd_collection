import numpy as np
import posquat as pq


def mirror_animation(anim):
    """this is slow, it goes from quat to matrix then deal frame by frame"""

    root = np.eye(4)
    root[0, :3] = np.array([-1, 0, 0])
    root[1, :3] = np.array([0, 1, 0])
    root[2, :3] = np.array([0, 0, 1])

    local = np.eye(4)
    local[0, :3] = np.array([1, 0, 0])
    local[1, :3] = np.array([0, 1, 0])
    local[2, :3] = np.array([0, 0, -1])

    mirror_table = [0,1,2,3,4,5,6,7,12,13,14,15,8,9,10,11,20,21,22,23,16,17,18,19]

    matrix_anim = pq.pq_to_pose(anim)
    new_anim = np.zeros_like(matrix_anim)
    for f in range(len(matrix_anim)):
        for i in range(len(matrix_anim[f])):
            new_anim[f, mirror_table[i], ...] = np.dot(local, np.dot(matrix_anim[f, i, ...], root))
    return pq.pose_to_pq(new_anim)


def compute_bone_speed(skel, anim, bonename):
    id = skel.boneid(bonename)
    pos, _ = anim
    speed = np.zeros_like(pos[..., 0, 0])

    speed[..., 1:] = np.linalg.norm(pos[..., :-1, id, :] - pos[..., 1:, id, :], axis=-1) * 30.0
    speed[..., 0] = speed[..., 1]
    return speed
