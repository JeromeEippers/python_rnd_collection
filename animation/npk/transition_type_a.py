import copy
import math

import numpy as np

from animation_framework import modifier
from animation_framework import posquat as pq
from animation_framework import utilities as tr
from animation_framework import modifier_displacement as disp
from animation_framework import skeleton


def _build_one_animation_db(skel, anim):
    lfpos = anim[0][:, skel.leftfootid, :]
    rfpos = anim[0][:, skel.rightfootid, :]
    hipsvec = tr.compute_vector(anim[0][:, skel.hipsid, :])
    lfvec = tr.compute_vector(lfpos)
    rfvec = tr.compute_vector(rfpos)

    repeater = np.ones_like(lfpos)
    lastlf = anim[0][-1, skel.leftfootid, :][np.newaxis, ...] * repeater
    lastrf = anim[0][-1, skel.rightfootid, :][np.newaxis, ...] * repeater
    lasthips = pq.transform_point(
        (anim[0][-1, 0, :], anim[1][-1, 0, :]),
        np.array([0, 30, 0])
    ) * repeater

    inverse_root = pq.inv((anim[0][:, 0, :], anim[1][:, 0, :]))
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
        ).reshape(len(anim[0]), 8, 3)

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
    frameid = 0
    for i, mapping in enumerate(mapping_db):
        anim_len = min(len(mapping), 25)
        for frame in range(anim_len):
            vec = mapping[frame, ...] - query
            dist = np.sum(vec*vec*weights)
            if dist < min_error:
                min_error = dist
                animid = i
                frameid = frame
    return animid, frameid


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
    bestanim, bestframe = find_best_frame(mapping_db, query)
    print(('transition found in', bestanim, bestframe))

    # re align to the end of the animation
    gpostr, gquattr = anim_db[bestanim][0][bestframe:, ...], anim_db[bestanim][1][bestframe:, ...]
    gpostr, gquattr = disp.set_displacement_origin(
        skel,
        (gpostr, gquattr),
        (a[0][-1, 0, :], a[1][-1, 0, :])
    )

    # warp
    gpostr, gquattr = modifier.warp(
        skel,
        (gpostr, gquattr),
        (a[0][-1, :, :], a[1][-1, :, :]),
        (b[0][0, :, :], b[1][0, :, :])
    )

    clen = len(gpostr)
    gpos[cframe:cframe + clen, ...] = gpostr
    gquat[cframe:cframe + clen, ...] = gquattr
    cframe = cframe + clen

    clen = len(b[0])
    gpos[cframe:cframe + clen, ...] = b[0][...]
    gquat[cframe:cframe + clen, ...] = b[1][...]
    cframe = cframe + clen

    return gpos[:cframe, ...], gquat[:cframe, ...]
