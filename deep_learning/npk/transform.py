import copy
import numpy as np
import posquat as pq
import skeleton


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

    mirror_table = [0,1,2,3,4,5,6,7,12,13,14,15,8,9,10,11,20,21,22,23,16,17,18,19,24]

    matrix_anim = pq.pq_to_pose(anim)
    new_anim = np.zeros_like(matrix_anim)
    for f in range(len(matrix_anim)):
        for i in range(len(matrix_anim[f])):
            new_anim[f, mirror_table[i], ...] = np.dot(local, np.dot(matrix_anim[f, i, ...], root))
    return pq.pose_to_pq(new_anim)


def compute_speed(positions):
    speed = np.zeros_like(positions[..., 0])

    speed[..., 1:] = np.linalg.norm(positions[..., :-1, :] - positions[..., 1:, :], axis=-1) * 30.0
    speed[..., 0] = speed[..., 1]
    return speed


def compute_vector(positions):
    disp = np.zeros_like(positions)

    disp[..., 1:, :] = positions[..., :-1, :] - positions[..., 1:, :]
    disp[..., 0, :] = disp[..., 1, :]
    return disp


def compute_bone_speed(skel:skeleton.Skeleton, anim, bonename):
    id = skel.boneid(bonename)
    pos, _ = anim
    return compute_speed(pos[..., id, :])


def compute_bone_vector(skel:skeleton.Skeleton, anim, bonename):
    id = skel.boneid(bonename)
    pos, _ = anim
    return compute_vector(pos[..., id, :])


def split_animation_by_foot_ground_contacts(skel : skeleton.Skeleton, anim, speedlimit=15):
    # generate foot speed
    leftfootspeed = compute_bone_speed(skel, anim, 'Model:LeftFoot')
    rightfootspeed = compute_bone_speed(skel, anim, 'Model:RightFoot')

    # splits
    ranges = np.concatenate(np.argwhere((leftfootspeed <= speedlimit) & (rightfootspeed <= speedlimit)))
    splits = []
    currentbegin = ranges[0]
    lastindex = ranges[0]
    for r in ranges[1:]:
        if r > lastindex + 1:
            if lastindex - currentbegin > 10:
                splits.append(int(currentbegin + (lastindex - currentbegin) / 2))
            currentbegin = r
        lastindex = r

    ps, qs = anim
    list_of_animations = []
    for s in range(len(splits) - 1):
        list_of_animations.append((
            ps[splits[s]:splits[s + 1], ...],
            qs[splits[s]:splits[s + 1], ...]
        ))
    list_of_animations.append((
        ps[splits[-1]:, ...],
        qs[splits[-1]:, ...]
    ))
    return list_of_animations


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



def lock_feet(skel : skeleton.Skeleton, anim, minimumspeed=12, maximumdistance=8):
    # generate foot speed
    lf_static = is_foot_static(anim[0][..., skel.leftfootid, :], minimumspeed, maximumdistance)
    rf_static = is_foot_static(anim[0][..., skel.rightfootid, :], minimumspeed, maximumdistance)
    animlen = len(anim[0])

    hips = copy.deepcopy(anim[0][..., skel.hipsid, :]), anim[1][..., skel.hipsid, :]
    hips[0][..., 1] -= 1
    lf = single_bone_lock((anim[0][..., skel.leftfootid, :], anim[1][..., skel.leftfootid, :]), lf_static)
    rf = single_bone_lock((anim[0][..., skel.rightfootid, :], anim[1][..., skel.rightfootid, :]), rf_static)

    return skel.foot_ik(hips, lf, rf, anim)


def update_anim_with_cop_from_feet_velocities(skel : skeleton.Skeleton, anim, minimumspeed=12, maximumdistance=8):

    lf_static = is_foot_static(anim[0][..., skel.leftfootid, :], minimumspeed, maximumdistance)
    rf_static = is_foot_static(anim[0][..., skel.rightfootid, :], minimumspeed, maximumdistance)
    animlen = len(anim[0])

    ratio = np.zeros(animlen)
    ratio[np.bitwise_and(lf_static > 0.5, rf_static > 0.5)] = 0.5
    ratio[np.bitwise_and(lf_static < 0.5, rf_static > 0.5)] = 1.0

    lf = copy.deepcopy(anim[0][..., skel.leftfootid, :])
    lf[..., 1] = 0
    rf = copy.deepcopy(anim[0][..., skel.rightfootid, :])
    rf[..., 1] = 0

    for _ in range(30):
        ratio[1:] = (ratio[1:] + ratio[:-1]) * 0.5
        ratio[0] = ratio[1]


    ratio = ratio[..., np.newaxis] * np.ones(3)

    anim[0][..., skel.copid, :], anim[1][..., skel.copid, :] = lf * (1.0-ratio) + rf * ratio, copy.deepcopy(anim[1][..., skel.hipsid, :])

    return anim


