import numpy as np
import posquat as pq


def cross(a, b):
    """Compute a cross product for a list of vectors"""
    return np.concatenate([
        a[..., 1:2] * b[..., 2:3] - a[..., 2:3] * b[..., 1:2],
        a[..., 2:3] * b[..., 0:1] - a[..., 0:1] * b[..., 2:3],
        a[..., 0:1] * b[..., 1:2] - a[..., 1:2] * b[..., 0:1],
    ], axis=-1)


def update_matrix_anim_projecting_disp_on_ground(anim):
    """
    project displacement on the ground from the hips
    input animation is in global space already
    it updates the input animation
    WARNING this expects a matrix animation
    """
    anim[:, 0, :, :] = np.array(anim[:, 1, :, :], copy=True)
    anim[:, 0, 3, 1] = 0

    eye = np.eye(4)
    eye = np.repeat(eye[np.newaxis, ...], len(anim[0]), axis=0)
    eye = np.repeat(eye[np.newaxis, ...], len(anim), axis=0)

    y = cross(anim[:, 0, 2, :3], eye[:, 0, 1, :3])
    x = cross(y, eye[:, 0, 1, :3])

    anim[:, 0, 0, :3] = x
    anim[:, 0, 1, :3] = y
    anim[:, 0, 2, :3] = eye[:, 0, 1, :3]


def remove_positional_displacement(skel, anim):
    local_anim = skel.global_to_local(anim)
    pos, quat = local_anim
    pos[..., 0, 0] = 0
    pos[..., 0, 2] = 0
    return skel.local_to_global((pos, quat))


def reset_displacement_origin(skel, anim):
    root = np.eye(4)
    root[0, :3] = np.array([-1,0,0])
    root[1, :3] = np.array([0, 0, 1])
    root[2, :3] = np.array([0, 1, 0])
    rootpos, rootquat = pq.pose_to_pq(root[np.newaxis, :])

    gpos, gquat = anim

    repeater_pos_anims_frames = np.ones_like(gpos[..., 0, 0, np.newaxis].repeat(3, axis=-1))
    repeater_quat_anims_frames = np.ones_like(gquat[..., 0, 0, np.newaxis].repeat(4, axis=-1))

    rootpos, rootquat = pq.pose_to_pq(root[np.newaxis, :])
    rootpos = rootpos[0, :] * repeater_pos_anims_frames
    rootquat = rootquat[0, :] * repeater_quat_anims_frames

    original_pos = gpos[..., 0, 0, :] * repeater_pos_anims_frames
    original_quat = gquat[..., 0, 0, :] * repeater_quat_anims_frames
    inverse_original_root = pq.inv(None, original_pos, original_quat)

    npos, nquat = skel.global_to_local(anim)
    relative_root = pq.mult(
        (npos[..., 0, :], nquat[..., 0, :]),
        inverse_original_root
        )
    npos[..., 0, :], nquat[..., 0, :] = pq.mult(
        relative_root,
        (rootpos, rootquat)
    )
    return skel.local_to_global((npos, nquat))



