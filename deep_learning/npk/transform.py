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

    mirror_table = [0,1,2,3,4,5,6,7,12,13,14,15,8,9,10,11,20,21,22,23,16,17,18,19]

    matrix_anim = pq.pq_to_pose(anim)
    new_anim = np.zeros_like(matrix_anim)
    for f in range(len(matrix_anim)):
        for i in range(len(matrix_anim[f])):
            new_anim[f, mirror_table[i], ...] = np.dot(local, np.dot(matrix_anim[f, i, ...], root))
    return pq.pose_to_pq(new_anim)


def compute_bone_speed(skel : skeleton.Skeleton, anim, bonename):
    id = skel.boneid(bonename)
    pos, _ = anim
    speed = np.zeros_like(pos[..., 0, 0])

    speed[..., 1:] = np.linalg.norm(pos[..., :-1, id, :] - pos[..., 1:, id, :], axis=-1) * 30.0
    speed[..., 0] = speed[..., 1]
    return speed


def compute_bone_displacement(skel : skeleton.Skeleton, anim, bonename):
    id = skel.boneid(bonename)
    pos, _ = anim
    disp = np.zeros_like(pos[..., 0, ...])

    disp[..., 1:] = (pos[..., :-1, id, :] - pos[..., 1:, id, :])
    disp[..., 0] = disp[..., 1]
    return disp


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


def lock_feet(skel : skeleton.Skeleton, anim, speedlimit=15):
    # generate foot speed
    leftfootspeed = compute_bone_speed(skel, anim, 'Model:LeftFoot')
    rightfootspeed = compute_bone_speed(skel, anim, 'Model:RightFoot')

    gpos, gquat = anim

    hipsp, hipsq = copy.deepcopy(gpos[:, skel.hipsid, :]), gquat[:, skel.hipsid, :]
    hipsp[..., 1] -= 2
    lfpos, lfquat = np.zeros_like(hipsp), np.zeros_like(hipsq)
    rfpos, rfquat = np.zeros_like(hipsp), np.zeros_like(hipsq)

    animlength = len(hipsp)
    lastlf = gpos[0, skel.leftlegids[-1], :], gquat[0, skel.leftlegids[-1], :]
    lastrf = gpos[0, skel.rightlegids[-1], :], gquat[0, skel.rightlegids[-1], :]

    lfpos[0, :], lfquat[0, :] = lastlf
    rfpos[0, :], rfquat[0, :] = lastrf
    for frame in range(1, animlength):
        if leftfootspeed[frame] < speedlimit:
            lfpos[frame, :], lfquat[frame, :] = lastlf
        else:
            lfpos[frame, :], lfquat[frame, :] = gpos[frame, skel.leftlegids[-1], :], gquat[frame, skel.leftlegids[-1], :]
        lastlf = lfpos[frame, :], lfquat[frame, :]

        if rightfootspeed[frame] < speedlimit:
            rfpos[frame, :], rfquat[frame, :] = lastrf
        else:
            rfpos[frame, :], rfquat[frame, :] = gpos[frame, skel.rightlegids[-1], :], gquat[frame, skel.rightlegids[-1], :]
        lastrf = rfpos[frame, :], rfquat[frame, :]

        #smooth
        lfpos[0, :], lfquat[0, :] = pq.lerp((lfpos[frame, :], lfquat[frame, :]),
                                            (lfpos[frame-1, :], lfquat[frame-1, :]),
                                            0.5)
        rfpos[0, :], rfquat[0, :] = pq.lerp((rfpos[frame, :], rfquat[frame, :]),
                                            (rfpos[frame - 1, :], rfquat[frame - 1, :]),
                                            0.5)


    return skel.foot_ik((hipsp, hipsq), (lfpos, lfquat), (rfpos, rfquat), anim)
