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


