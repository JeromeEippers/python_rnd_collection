import copy
import math

import numpy as np

import modifier
import posquat as pq
import utilities as tr
import displacement as disp
import skeleton
import inertialize as iner


def _build_one_animation_db(skel, anim):

    lfpos = anim[0][:, skel.leftfootid, :]
    rfpos = anim[0][:, skel.rightfootid, :]
    hipsvec = tr.compute_vector(anim[0][:, skel.hipsid, :])
    lfvec = tr.compute_vector(lfpos)
    rfvec = tr.compute_vector(rfpos)

    # using the speed let's find how far we can try to find the best first frame
    # we will say that we can go up to the middle of the first step
    # find which foot moves first
    lfvel = tr.compute_speed(lfpos)
    rfvel = tr.compute_speed(rfpos)
    lfstart = np.argwhere(lfvel > 2)[0][0]
    rfstart = np.argwhere(rfvel > 2)[0][0]
    foot_velocity = lfvel
    foot_start = lfstart
    if rfstart < lfstart:
        foot_velocity = rfvel
        foot_start = rfstart
    # find middle of the foot motion
    max_starting_frame = foot_start + np.argwhere(foot_velocity[foot_start:] < 2)[0][0] // 2

    # now we check how many frames at the end of the animation we can match
    # we will only look for frames where both feet are on the ground
    max_end_frame = np.argwhere(np.bitwise_or(lfvel[::-1] > 2, rfvel[::-1] > 2))[0][0] - 1

    db = []

    # build the matrix of mapping
    for startFrame in range(0, max_starting_frame, 3):
        for endFrame in range(len(lfvel)-max_end_frame, len(lfvel), 3):
            start_anim_frame = startFrame
            end_anim_frame = endFrame
            assert(end_anim_frame > start_anim_frame)

            frame_lfpos = lfpos[start_anim_frame, :]
            frame_rfpos = rfpos[start_anim_frame, :]
            frame_hipsvec = hipsvec[start_anim_frame, :]
            frame_lfvec = lfvec[start_anim_frame, :]
            frame_rfvec = rfvec[start_anim_frame, :]
            frame_lastlf = lfpos[end_anim_frame, :]
            frame_lastrf = rfpos[end_anim_frame, :]
            frame_lasthips = pq.transform_point(
                (anim[0][end_anim_frame, 0, :], anim[1][end_anim_frame, 0, :]),
                np.array([0, 30, 0])
            )

            inverse_root = pq.inv((anim[0][start_anim_frame, 0, :], anim[1][start_anim_frame, 0, :]))
            table = np.concatenate([
                pq.transform_point(inverse_root, frame_lfpos)[np.newaxis, ...],
                pq.transform_point(inverse_root, frame_rfpos)[np.newaxis, ...],
                pq.transform_vector(inverse_root, frame_lfvec)[np.newaxis, ...],
                pq.transform_vector(inverse_root, frame_rfvec)[np.newaxis, ...],
                pq.transform_vector(inverse_root, frame_hipsvec)[np.newaxis, ...],
                pq.transform_point(inverse_root, frame_lastlf)[np.newaxis, ...],
                pq.transform_point(inverse_root, frame_lastrf)[np.newaxis, ...],
                pq.transform_point(inverse_root, frame_lasthips)[np.newaxis, ...]],
                axis=-1
            ).reshape(8, 3)

            # check if it is useful to add this in the list
            if db :
                vec = db[-1][1] - table
                dist = np.sum(vec * vec)
                if dist < 0.05:
                    continue
            db.append(((start_anim_frame, end_anim_frame), table))

    return db


def _build_one_query(skel, a, b):
    lfpos = a[0][-2:, skel.leftfootid, :]
    rfpos = a[0][-2:, skel.rightfootid, :]
    hipsvec = tr.compute_vector(a[0][-2:, skel.hipsid, :])[-1]
    lfvec = tr.compute_vector(lfpos)[-1]
    rfvec = tr.compute_vector(rfpos)[-1]
    lfpos = lfpos[-1]
    rfpos = rfpos[-1]
    lastlf = b[0][0, skel.leftfootid, :]
    lastrf = b[0][0, skel.rightfootid, :]
    lasthips = pq.transform_point(
        (b[0][0, 0, :], b[1][0, 0, :]),
        np.array([0, 30, 0])
    )

    inverse_root = pq.inv((a[0][-1, 0, :], a[1][-1, 0, :]))
    return np.concatenate([
        pq.transform_point(inverse_root, lfpos)[np.newaxis, ...],
        pq.transform_point(inverse_root, rfpos)[np.newaxis, ...],
        pq.transform_vector(inverse_root, lfvec)[np.newaxis, ...],
        pq.transform_vector(inverse_root, rfvec)[np.newaxis, ...],
        pq.transform_vector(inverse_root, hipsvec)[np.newaxis, ...],
        pq.transform_point(inverse_root, lastlf)[np.newaxis, ...],
        pq.transform_point(inverse_root, lastrf)[np.newaxis, ...],
        pq.transform_point(inverse_root, lasthips)[np.newaxis, ...]],
        axis=-1
    ).reshape(8, 3)


def find_best_frame(mapping_db, query):
    weights = np.array([
        [1, 1, 1],
        [1, 1, 1],
        [2, 2, 2],
        [2, 2, 2],
        [5, 5, 5],
        [1, 1, 1],
        [1, 1, 1],
        [2, 2, 2]
    ])
    min_error = 1E+8
    animid = 0
    framesid = 0
    for i, mapping in enumerate(mapping_db):
        for frames, matrix in mapping:
            vec = matrix - query
            dist = np.sum(vec * vec * weights)
            if dist < min_error:
                min_error = dist
                animid = i
                framesid = frames
    return animid, framesid[0], framesid[1]


def build_mapping_table(skel:skeleton.Skeleton, animation_db):

    return [_build_one_animation_db(skel, anim) for anim in animation_db]


def create_transition(skel:skeleton.Skeleton, anim_db, mapping_db, a, b):

    # build animation
    total_len = len(a[0]) + len(b[0]) + 500
    gpos, gquat = np.zeros([total_len, len(skel.bones), 3]), np.zeros([total_len, len(skel.bones), 4])

    # start
    cframe = 0
    clen = len(a[0])
    gpos[cframe:cframe+clen, ...] = a[0][...]
    gquat[cframe:cframe+clen, ...] = a[1][...]
    cframe = cframe+clen


    # build query
    query = _build_one_query(skel, a, b)
    bestanim, beststartframe, bestendframe = find_best_frame(mapping_db, query)
    print(('transition found in', bestanim, beststartframe, bestendframe))

    # re align to the end of the animation
    gpostr, gquattr = anim_db[bestanim][0][beststartframe:bestendframe, ...], anim_db[bestanim][1][beststartframe:bestendframe, ...]
    gpostr, gquattr = disp.set_displacement_origin(
        skel,
        (gpostr, gquattr),
        (a[0][-1, 0, :], a[1][-1, 0, :])
    )

    '''
    # warp
    gpostr, gquattr = modifier.warp(
        skel,
        (gpostr, gquattr),
        (a[0][-1, :, :], a[1][-1, :, :]),
        (b[0][0, :, :], b[1][0, :, :])
    )
    '''

    clen = len(gpostr)
    gpos[cframe:cframe + clen, ...] = gpostr
    gquat[cframe:cframe + clen, ...] = gquattr
    warpframe = cframe
    warpframeend = cframe+clen
    cframe = cframe + clen

    clen = len(b[0])
    gpos[cframe:cframe + clen, ...] = b[0][...]
    gquat[cframe:cframe + clen, ...] = b[1][...]

    modifier.inplace_warp_feet_inertialize_body(
        skel,
        (gpos, gquat),
        warpframe,
        warpframeend,
        int((warpframeend-warpframe) * .8)
    )

    hipsp, hipsq = gpos[cframe:cframe + clen, skel.hipsid, ...], gquat[cframe:cframe + clen, skel.hipsid, ...]
    lfp, lfq = gpos[cframe:cframe + clen, skel.leftfootid, ...], gquat[cframe:cframe + clen, skel.leftfootid, ...]
    rfp, rfq = gpos[cframe:cframe + clen, skel.rightfootid, ...], gquat[cframe:cframe + clen, skel.rightfootid, ...]

    gpos, gquat = skel.local_to_global(
        iner.inplace_inertialize(
            skel.global_to_local((gpos, gquat)),
            cframe, 20
        )
    )

    gpos[cframe:cframe + clen, ...], gquat[cframe:cframe + clen, ...] = skel.foot_ik(
        (hipsp, hipsq),
        (lfp, lfq),
        (rfp, rfq),
        (gpos[cframe:cframe + clen, ...], gquat[cframe:cframe + clen, ...])
    )

    cframe = cframe + clen

    return gpos[:cframe, ...], gquat[:cframe, ...]
