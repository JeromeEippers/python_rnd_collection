import copy
import numpy as np
import posquat as pq



def compute_speed(positions):
    speed = np.zeros_like(positions[..., 0])

    speed[..., 1:] = np.linalg.norm(positions[..., :-1, :] - positions[..., 1:, :], axis=-1) * 30.0
    speed[..., 0] = speed[..., 1]
    return speed


def compute_distance(positions):
    speed = np.zeros_like(positions[..., 0])

    speed[..., 1:] = np.linalg.norm(positions[..., :-1, :] - positions[..., 1:, :], axis=-1)
    speed[..., 0] = speed[..., 1]
    return speed


def compute_vector(positions):
    disp = np.zeros_like(positions)

    disp[..., 1:, :] = positions[..., :-1, :] - positions[..., 1:, :]
    disp[..., 0, :] = disp[..., 1, :]
    return disp


def compute_bone_speed(skel, anim, bonename):
    id = skel.boneid(bonename)
    pos, _ = anim
    return compute_speed(pos[..., id, :])


def compute_bone_vector(skel, anim, bonename):
    id = skel.boneid(bonename)
    pos, _ = anim
    return compute_vector(pos[..., id, :])


def is_foot_static(footpositions, minimumspeed=10, maximumdistance=6):

    foot_speed = compute_speed(footpositions)
    foot_vector = compute_vector(footpositions)

    is_static = np.zeros_like(footpositions[..., 0])
    animlength = len(footpositions)

    total = np.zeros(3)
    laststartingframe = 0
    frame = 0
    while frame < animlength:
        total += foot_vector[frame]
        if np.linalg.norm(total) < maximumdistance:
            is_static[frame] = 1.0
            frame += 1
        else:
            total = 0
            laststartingframe = frame+1
            frame -= 1
            while frame >= 0:
                if is_static[frame] < 1.0 or foot_speed[frame] < minimumspeed:
                    break
                is_static[frame] = 0.0
                frame -= 1
            frame = laststartingframe
    return is_static


def single_bone_lock(foot_anim, is_static):
    gpos, gquat = copy.deepcopy(foot_anim[0]), copy.deepcopy(foot_anim[1])
    speed = compute_speed(foot_anim[0])
    startframe = 0
    lastendrange = 0
    animlen = len(foot_anim[0])
    for frame in range(animlen):
        if frame == animlen - 1 or (startframe < frame and is_static[frame] < 0.5):
            gpos[startframe:frame, :] = np.mean(gpos[startframe:frame, :], axis=0)
            gquat[startframe:frame, :] = pq.quat_average(gquat[startframe:frame, :])

            # warp trajectory
            totalspeed = np.sum(speed[lastendrange:startframe + 1])
            start_offset = pq.sub(
                (gpos[lastendrange, :], gquat[lastendrange, :]),
                (foot_anim[0][lastendrange, :], foot_anim[1][lastendrange, :])
            )
            end_offset = pq.sub(
                (gpos[startframe, :], gquat[startframe, :]),
                (foot_anim[0][startframe, :], foot_anim[1][startframe, :])
            )
            t = 0
            for i in range(lastendrange, startframe + 1):
                t += speed[i] / totalspeed
                offset = pq.lerp(start_offset, end_offset, t)
                gpos[i, :], gquat[i, :] = pq.add(
                    (foot_anim[0][i, :], foot_anim[1][i, :]),
                    offset
                )

            startframe = frame + 1
            lastendrange = frame - 1
        elif is_static[frame] < 0.5:
            startframe = frame + 1
    return gpos, gquat


def get_foot_phase_mapping(skel, a, b):
    len_a = len(a[0])
    len_b = len(b[0])

    statics = np.zeros([max(len_a, len_b), 4])
    statics[:len_a, 0] = compute_speed(a[0][..., skel.leftfootid, :]) < 30
    statics[:len_a, 1] = compute_speed(a[0][..., skel.rightfootid, :]) < 30
    statics[:len_b, 2] = compute_speed(b[0][..., skel.leftfootid, :]) < 30
    statics[:len_b, 3] = compute_speed(b[0][..., skel.rightfootid, :]) < 30

    current = statics[0, :]
    start_a_range = 0
    start_b_range = 0
    frame_a = 0
    frame_b = 0
    ranges_info = []
    while frame_a < len_a or frame_b < len_b:
        # compute the range when the animations matches
        while frame_a < len_a and statics[frame_a, 0] == current[0] and statics[frame_a, 1] == current[1]:
            frame_a += 1
        while frame_b < len_b and statics[frame_b, 2] == current[2] and statics[frame_b, 3] == current[3]:
            frame_b += 1

        ranges_info.append((
            start_a_range, frame_a,
            start_b_range, frame_b,
            current[0], current[1], current[2], current[3]
        ))

        # update the values for the next range
        start_a_range = frame_a
        start_b_range = frame_b
        if start_a_range >= len_a:
            start_a_range = len_a - 1
        if start_b_range >= len_b:
            start_b_range = len_b - 1
        assert(statics[start_a_range, 0] == statics[start_b_range, 2])
        assert (statics[start_a_range, 1] == statics[start_b_range, 3])
        current = np.array([statics[start_a_range, 0],
                            statics[start_a_range, 1],
                            statics[start_b_range, 2],
                            statics[start_b_range, 3]])

    return ranges_info


def get_projected_feet_on_ground(skel, anim, left_foot_positions=None, right_foot_positions=None):
    pos = np.zeros_like(anim[0][..., :2, :])
    quats = np.zeros_like(anim[1][..., :2, :])
    if left_foot_positions is None:
        left_foot_positions = anim[0][..., skel.leftfootid, :]
    if right_foot_positions is None:
        right_foot_positions = anim[0][..., skel.rightfootid, :]
    quats[..., 0, :] = copy.deepcopy(anim[1][..., 0, :])
    quats[..., 1, :] = copy.deepcopy(anim[1][..., 0, :])
    pos[..., 0, :] = copy.deepcopy(left_foot_positions)
    pos[..., 1, :] = copy.deepcopy(right_foot_positions)
    pos[..., 0, 1] = 0
    pos[..., 1, 1] = 0
    return pos, quats


def offset_bone_to_start_at(anim, start):
    rootpos, rootquat = start
    gpos, gquat = anim

    repeater_pos_anims_frames = np.ones_like(gpos[:, 0, np.newaxis].repeat(3, axis=-1))
    repeater_quat_anims_frames = np.ones_like(gquat[:, 0, np.newaxis].repeat(4, axis=-1))

    rootpos = rootpos * repeater_pos_anims_frames
    rootquat = rootquat * repeater_quat_anims_frames

    original_pos = gpos[0, :] * repeater_pos_anims_frames
    original_quat = gquat[0, :] * repeater_quat_anims_frames
    inverse_original_root = pq.inv(None, original_pos, original_quat)

    relative_root = pq.mult(anim, inverse_original_root)
    return pq.mult(relative_root, (rootpos, rootquat))


def extract_incremental_anim(anim):
    npos, nquat = np.zeros_like(anim[0]), np.zeros_like(anim[1])
    gpos, gquat = anim

    repeater_pos = np.ones_like(gpos[0, ..., 0, np.newaxis].repeat(3, axis=-1))
    repeater_quat = np.ones_like(gquat[0, ..., 0, np.newaxis].repeat(4, axis=-1))

    npos[0, ...] = np.zeros(3) * repeater_pos
    nquat[0, ...] = np.array([1, 0, 0, 0]) * repeater_quat

    npos[1:, ...], nquat[1:, ...] = pq.mult(
        (gpos[1:, ...], gquat[1:, ...]),
        pq.inv((gpos[:-1, ...], gquat[:-1, ...]))
    )

    return npos, nquat


def convert_incremental_anim(anim, start_pose):
    npos, nquat = np.zeros_like(anim[0]), np.zeros_like(anim[1])
    gpos, gquat = anim

    lastpos, lastquat = start_pose

    for f in range(len(gpos)):
        npos[f, ...], nquat[f, ...] = pq.mult(
            (gpos[f, ...], gquat[f, ...]),
            (lastpos, lastquat)
        )
        lastpos, lastquat = npos[f, ...], nquat[f, ...]
    return npos, nquat


def smooth_trajectory(anim, steps=5):
    start_pose = anim[0][0, ...], anim[1][0, ...]
    ipos, iquat = extract_incremental_anim(anim)

    for i in range(steps):
        ipos[1:, ...], iquat[1:, ...] = pq.lerp(
            (ipos[1:, ...], iquat[1:, ...]),
            (ipos[:-1, ...], iquat[:-1, ...]),
            0.5
        )
    return convert_incremental_anim((ipos, iquat), start_pose)