import copy
import math

import numpy as np
import posquat as pq
import transform as tr
import skeleton


def warp(skel : skeleton.Skeleton, anim, startpose, endpose, hipsoffset=np.zeros(3)):

    gpos, gquat = anim
    lpos, lquat = skel.global_to_local(anim)
    npos, nquat = np.zeros_like(gpos), np.zeros_like(gquat)

    indices = [skel.hipsid, skel.leftlegids[-1], skel.rightlegids[-1]]
    gsp, gsq = pq.sub((startpose[0][indices,...], startpose[1][indices,...]), (gpos[0, indices, ...], gquat[0, indices, ...]))
    gep, geq = pq.sub((endpose[0][indices,...], endpose[1][indices,...]), (gpos[-1, indices, ...], gquat[-1, indices, ...]))

    lstartoffset = pq.sub(skel.global_to_local(startpose), (lpos[0, ...], lquat[0, ...]))
    lendoffset = pq.sub(skel.global_to_local(endpose), (lpos[-1, ...], lquat[-1, ...]))

    lenanim = len(anim[0])

    hipsspeed = tr.compute_bone_speed(skel, anim, 'Model:Hips')
    lfspeed = tr.compute_bone_speed(skel, anim, 'Model:LeftFoot')
    rfspeed = tr.compute_bone_speed(skel, anim, 'Model:RightFoot')

    totalhips, totallf, totlarf = np.sum(hipsspeed), np.sum(lfspeed), np.sum(rfspeed)
    th, tlf, trf = 0, 0, 0

    for f in range(lenanim):
        t = float(f)/(lenanim-1)
        th += hipsspeed[f] / totalhips
        tlf += lfspeed[f] / totallf
        trf += rfspeed[f] / totlarf

        loffset = pq.lerp(lstartoffset, lendoffset, t)
        lpos[f, ...], lquat[f, ...] = pq.add((lpos[f, ...], lquat[f, ...]), loffset)

        goffh = pq.lerp((gsp[0], gsq[0]), (gep[0], geq[0]), th)
        gofflf = pq.lerp((gsp[1], gsq[1]), (gep[1], geq[1]), tlf)
        goffrf = pq.lerp((gsp[2], gsq[2]), (gep[2], geq[2]), trf)

        npos[f, indices[0], ...], nquat[f, indices[0], ...] = pq.add((gpos[f, indices[0], ...], gquat[f, indices[0], ...]), goffh)
        npos[f, indices[1], ...], nquat[f, indices[1], ...] = pq.add((gpos[f, indices[1], ...], gquat[f, indices[1], ...]), gofflf)
        npos[f, indices[2], ...], nquat[f, indices[2], ...] = pq.add((gpos[f, indices[2], ...], gquat[f, indices[2], ...]), goffrf)

        npos[f, indices[0], ...] += hipsoffset

    gpos, gquat = skel.local_to_global((lpos, lquat))
    return skel.foot_ik(
        (npos[..., skel.hipsid, :], nquat[..., skel.hipsid, :]),
        (npos[..., skel.leftlegids[-1], :], nquat[..., skel.leftlegids[-1], :]),
        (npos[..., skel.rightlegids[-1], :], nquat[..., skel.rightlegids[-1], :]),
        (gpos, gquat)
    )


def offset_displacement_at_end(skel:skeleton.Skeleton, anim, dispPositionOffset, dispQuaternionOffset, hipsoffset=np.zeros(3)):
    startpose = anim[0][0, ...], anim[1][0, ...]
    endpose = anim[0][-1, ...], anim[1][-1, ...]

    endpose = skel.global_to_local(endpose)
    endpose[0][0,...] += dispPositionOffset
    endpose[1][0, ...] = pq.quat_mul(dispQuaternionOffset, endpose[1][0, ...])
    endpose = skel.local_to_global(endpose)


    return warp(skel, anim, startpose, endpose, hipsoffset)


def scale_displacement(skel:skeleton.Skeleton, anim, positionScale=1.0, quaternionScale=1.0):
    startpose = anim[0][0, ...], anim[1][0, ...]
    endpose = anim[0][-1, ...], anim[1][-1, ...]

    endpose = skel.global_to_local(endpose)
    endposeP, _ = pq.lerp( (startpose[0][0, ...], startpose[1][0, ...]), (endpose[0][0, ...], endpose[1][0, ...]), positionScale)
    _, endposeQ = pq.lerp((startpose[0][0, ...], startpose[1][0, ...]), (endpose[0][0, ...], endpose[1][0, ...]), quaternionScale)

    endpose[0][0, ...] = endposeP
    endpose[1][0, ...] = endposeQ
    endpose = skel.local_to_global(endpose)
    return warp(skel, anim, startpose, endpose)


def time_stretch(skel:skeleton.Skeleton, anim, desiredtime):
    bonecount = len(skel.bones)
    stretchP, stretchQ = np.zeros([desiredtime, bonecount, 3]), np.zeros([desiredtime, bonecount, 4])

    anim = skel.global_to_local(anim)
    len_anim = len(anim[0])
    ratio = float(len_anim) / float(desiredtime+1)
    for f in range(desiredtime):
        t = float(f) * ratio
        if t > len_anim-1:
            t = float(len_anim) - 1.001
        k = math.floor(t)
        r = t - k
        k = int(k)
        stretchP[f, ...], stretchQ[f, ...] = pq.lerp((anim[0][k, ...], anim[1][k, ...]), (anim[0][k+1, ...], anim[1][k+1, ...]), r)
    return skel.local_to_global((stretchP, stretchQ))


def blend_animations(skel:skeleton.Skeleton, a, b, ratio):
    desired_length = int(len(a[0]) * (1.0-ratio) + len(b[0]) * ratio)

    a = time_stretch(skel, a, desired_length)
    b = time_stretch(skel, b, desired_length)

    return skel.local_to_global(
        pq.lerp(
            skel.global_to_local(a),
            skel.global_to_local(b),
            ratio
        )
    )


def blend_animations_with_cop(skel:skeleton.Skeleton, a, b, ratio):
    desired_length = int(len(a[0]) * (1.0 - ratio) + len(b[0]) * ratio)

    a = time_stretch(skel, a, desired_length)
    b = time_stretch(skel, b, desired_length)

    cop_a = a[0][..., skel.copid, :], a[1][..., skel.copid, :]
    cop_b = b[0][..., skel.copid, :], b[1][..., skel.copid, :]

    a = skel.global_to_local(a, cop_a)
    b = skel.global_to_local(b, cop_b)

    anim = pq.lerp(a, b, ratio)
    cop = pq.lerp(cop_a, cop_b, ratio)

    return skel.local_to_global(anim, cop)


def blend_anim_foot_phase(skel:skeleton.Skeleton, a, b, ratio, minimumspeed=10, maximumdistance=5):
    len_a = len(a[0])
    len_b = len(b[0])

    statics = np.zeros([max(len_a, len_b), 4])
    statics[:len_a, 0] = tr.is_foot_static(a[0][..., skel.leftfootid, :], minimumspeed, maximumdistance)
    statics[:len_a, 1] = tr.is_foot_static(a[0][..., skel.rightfootid, :], minimumspeed, maximumdistance)
    statics[:len_b, 2] = tr.is_foot_static(b[0][..., skel.leftfootid, :], minimumspeed, maximumdistance)
    statics[:len_b, 3] = tr.is_foot_static(b[0][..., skel.rightfootid, :], minimumspeed, maximumdistance)

    gpos, gquat = np.zeros([max(len_a, len_b), len(skel.bones), 3]), np.zeros([max(len_a, len_b), len(skel.bones), 4])
    glfpos, glfquat = np.zeros([max(len_a, len_b), 3]), np.zeros([max(len_a, len_b), 4])
    grfpos, grfquat = np.zeros([max(len_a, len_b), 3]), np.zeros([max(len_a, len_b), 4])

    lfstatics = np.zeros(max(len_a, len_b))
    rfstatics = np.zeros(max(len_a, len_b))

    current = statics[0, :]
    start_a_range = 0
    start_b_range = 0
    frame_a = 0
    frame_b = 0
    currentStart = 0
    while frame_a < len_a or frame_b < len_b:
        # compute the range when the animations matches
        while frame_a < len_a and statics[frame_a, 0] == current[0] and statics[frame_a, 1] == current[1]:
            frame_a += 1
        while frame_b < len_b and statics[frame_b, 2] == current[2] and statics[frame_b, 3] == current[3]:
            frame_b += 1

        # stretch the animations to have the same length during this range
        # lerp between the two animations
        rangelen = int((frame_a - start_a_range -1) * (1.0-ratio) + (frame_b - start_b_range -1) * ratio)
        stretch_a = time_stretch(skel, (a[0][start_a_range:frame_a, ...], a[1][start_a_range:frame_a, ...]), rangelen)
        stretch_b = time_stretch(skel, (b[0][start_b_range:frame_b, ...], b[1][start_b_range:frame_b, ...]), rangelen)
        gpos[currentStart:currentStart+rangelen], gquat[currentStart:currentStart+rangelen] = skel.local_to_global(
            pq.lerp(
                skel.global_to_local(stretch_a),
                skel.global_to_local(stretch_b),
                ratio
            )
        )
        # update foot trajectories for IK
        glfpos[currentStart:currentStart + rangelen, :], glfquat[currentStart:currentStart + rangelen, :] = \
            copy.deepcopy(gpos[currentStart:currentStart + rangelen, skel.leftfootid, :]), \
            copy.deepcopy(gquat[currentStart:currentStart + rangelen, skel.leftfootid, :])

        grfpos[currentStart:currentStart + rangelen, :], grfquat[currentStart:currentStart + rangelen, :] = \
            copy.deepcopy(gpos[currentStart:currentStart + rangelen, skel.rightfootid, :]), \
            copy.deepcopy(gquat[currentStart:currentStart + rangelen, skel.rightfootid, :])

        # if a foot is static, let's lock it
        if current[0] > 0.5:
            lfstatics[currentStart:currentStart + rangelen] = 1.0
        if current[1] > 0.5:
            rfstatics[currentStart:currentStart + rangelen] = 1.0


        # update the values for the next range
        currentStart += rangelen
        start_a_range = frame_a
        start_b_range = frame_b
        if start_a_range >= len_a:
            start_a_range = len_a - 1
        if start_b_range >= len_b:
            start_b_range = len_b - 1
        current = np.array([statics[start_a_range, 0], statics[start_a_range, 1], statics[start_b_range, 2], statics[start_b_range, 3]])

    # clamp animations
    gpos, gquat = gpos[:currentStart, ...], gquat[:currentStart, ...]
    glfpos, glfquat = glfpos[:currentStart, ...], glfquat[:currentStart, ...]
    grfpos, grfquat = grfpos[:currentStart, ...], grfquat[:currentStart, ...]
    lfstatics = lfstatics[:currentStart]
    rfstatics = rfstatics[:currentStart]

    # lock feets
    glfpos, glfquat = tr.single_bone_lock((glfpos, glfquat), lfstatics)
    grfpos, grfquat = tr.single_bone_lock((grfpos, grfquat), rfstatics)

    return skel.foot_ik(
        (gpos[..., skel.hipsid, :], gquat[..., skel.hipsid, :]),
        (glfpos, glfquat),
        (grfpos, grfquat),
        (gpos, gquat)
    )

