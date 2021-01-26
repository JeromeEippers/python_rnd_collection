import numpy as np
from . import posquat as pq
from . import skeleton as sk
from .modifier import warp


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

    y = pq.vec_cross3(anim[:, 0, 2, :3], eye[:, 0, 1, :3])
    x = pq.vec_cross3(y, eye[:, 0, 1, :3])

    anim[:, 0, 0, :3] = x
    anim[:, 0, 1, :3] = y
    anim[:, 0, 2, :3] = eye[:, 0, 1, :3]


def projecting_disp_on_ground(anim):
    a = pq.pq_to_pose(anim)
    update_matrix_anim_projecting_disp_on_ground(a)
    return pq.pose_to_pq(a)


def remove_positional_displacement(skel:sk.Skeleton, anim):
    local_anim = skel.global_to_local(anim)
    pos, quat = local_anim
    pos[..., 0, 0] = 0
    pos[..., 0, 2] = 0
    return skel.local_to_global((pos, quat))


def set_displacement_origin(skel:sk.Skeleton, anim, disp):
    rootpos, rootquat = disp

    gpos, gquat = anim

    repeater_pos_anims_frames = np.ones_like(gpos[..., 0, 0, np.newaxis].repeat(3, axis=-1))
    repeater_quat_anims_frames = np.ones_like(gquat[..., 0, 0, np.newaxis].repeat(4, axis=-1))

    rootpos = rootpos * repeater_pos_anims_frames
    rootquat = rootquat * repeater_quat_anims_frames

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


def reset_displacement_origin(skel:sk.Skeleton, anim):
    root = np.eye(4)
    root[0, :3] = np.array([-1, 0, 0])
    root[1, :3] = np.array([0, 0, 1])
    root[2, :3] = np.array([0, 1, 0])

    return set_displacement_origin(skel, anim, pq.pose_to_pq(root))


def offset_displacement_at_end(skel:sk.Skeleton,
                               anim,
                               dispPositionOffset,
                               dispQuaternionOffset,
                               hipsoffset=np.zeros(3)):

    startpose = anim[0][0, ...], anim[1][0, ...]
    endpose = anim[0][-1, ...], anim[1][-1, ...]

    endpose = skel.global_to_local(endpose)
    endpose[0][0,...] += dispPositionOffset
    endpose[1][0, ...] = pq.quat_mul(dispQuaternionOffset, endpose[1][0, ...])
    endpose = skel.local_to_global(endpose)


    return warp(skel, anim, startpose, endpose, hipsoffset)


def scale_displacement(skel:sk.Skeleton, anim, positionScale=1.0, quaternionScale=1.0):
    startpose = anim[0][0, ...], anim[1][0, ...]
    endpose = anim[0][-1, ...], anim[1][-1, ...]

    endpose = skel.global_to_local(endpose)
    endposeP, _ = pq.lerp(
        (startpose[0][0, ...], startpose[1][0, ...]),
        (endpose[0][0, ...], endpose[1][0, ...]),
        positionScale)
    _, endposeQ = pq.lerp(
        (startpose[0][0, ...], startpose[1][0, ...]),
        (endpose[0][0, ...], endpose[1][0, ...]),
        quaternionScale)

    endpose[0][0, ...] = endposeP
    endpose[1][0, ...] = endposeQ
    endpose = skel.local_to_global(endpose)
    return warp(skel, anim, startpose, endpose)