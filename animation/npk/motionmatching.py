import numpy as np

import animation_framework as fw
from animation_framework import modifier
from animation_framework import posquat as pq
from animation_framework import utilities as tr
from animation_framework import modifier_displacement as disp
from animation_framework import skeleton as skl

INITIAL_SCORE = 1
FEATURE_SCORE = 1
TIMING_SCORE = 30

def build_motion_db(animations, skeleton: skl.Skeleton, stride=10):

    db = list()

    def _build_motion(animation):
        animation_len = len(animation[0])
        for r in range(0, animation_len-stride+1, stride):
            anim = animation[0][r:], animation[1][r:]
            anim = disp.reset_displacement_origin(skeleton, anim)

            anim_len = len(anim[0])
            features_keys = list(range(0, anim_len-stride+1, stride))

            hipspos = anim[0][:, skeleton.hipsid, :]
            lfpos = anim[0][:, skeleton.leftfootid, :]
            rfpos = anim[0][:, skeleton.rightfootid, :]
            hipsvec = tr.compute_vector(hipspos)
            lfvec = tr.compute_vector(lfpos)
            rfvec = tr.compute_vector(rfpos)

            frames = anim[0][:stride], anim[1][:stride]
            features = np.zeros((len(features_keys), 6, 3))
            features[:, 0, :] = hipspos[features_keys, :]
            features[:, 1, :] = lfpos[features_keys, :]
            features[:, 2, :] = rfpos[features_keys, :]
            features[:, 3, :] = hipsvec[features_keys, :]
            features[:, 4, :] = lfvec[features_keys, :]
            features[:, 5, :] = rfvec[features_keys, :]

            db.append((features, frames))

    for animation in animations:
        _build_motion(animation)

    return stride, db



def create_motion_transition(db, skeleton, anim_a, anim_b, transition_time, debug_dict=None):
    stride, db = db

    root = np.eye(4)
    rp, rq = np.zeros((2, 3)), np.zeros((2, 4))
    root[0, :3] = np.array([-1, 0, 0])
    root[1, :3] = np.array([0, 0, 1])
    root[2, :3] = np.array([0, 1, 0])
    rp[0, :], rq[0, :] = pq.pose_to_pq(root)
    rp[1, :], rq[1, :] = rp[0, :], rq[0, :]


    def compute_score(feature, query):
        vec = feature - query
        dist = np.sum(vec * vec)
        return dist

    def find_segment(a, b, t):

        # set animations in local space relative to end of a
        ip, iq = np.zeros((2, 3)), np.zeros((2, 4))
        ip[0, :], iq[0, :] = pq.inv(None, a[0][-1, 0, :], a[1][-1, 0, :])
        ip[1, :], iq[1, :] = ip[0, :], iq[0, :]
        a = skeleton.global_to_local(a, (ip, iq))
        a = skeleton.local_to_global(a, (rp, rq))
        b = skeleton.global_to_local(b, (ip, iq))
        b = skeleton.local_to_global(b, (rp, rq))

        if debug_dict != None:
            debug_dict['segment_a_{}'.format(t)] = a
            debug_dict['segment_b_{}'.format(t)] = b

        a_query = np.zeros((6, 3))
        a_query[0, :] = a[0][-1, skeleton.hipsid, :]
        a_query[1, :] = a[0][-1, skeleton.leftfootid, :]
        a_query[2, :] = a[0][-1, skeleton.rightfootid, :]
        a_query[3, :] = tr.compute_vector(a[0][:, skeleton.hipsid, :])[-1, :]
        a_query[4, :] = tr.compute_vector(a[0][:, skeleton.leftfootid, :])[-1, :]
        a_query[5, :] = tr.compute_vector(a[0][:, skeleton.rightfootid, :])[-1, :]

        b_query = np.zeros((6, 3))
        b_query[0, :] = b[0][0, skeleton.hipsid, :]
        b_query[1, :] = b[0][0, skeleton.leftfootid, :]
        b_query[2, :] = b[0][0, skeleton.rightfootid, :]
        b_query[3, :] = tr.compute_vector(b[0][:, skeleton.hipsid, :])[0, :]
        b_query[4, :] = tr.compute_vector(b[0][:, skeleton.leftfootid, :])[0, :]
        b_query[5, :] = tr.compute_vector(b[0][:, skeleton.rightfootid, :])[0, :]

        # check all the clips for matching features
        features_index = int(t / stride)
        best_score = 1e8
        best_frames = None
        best_clip = -1
        best_feature = -1
        for iclip, clip in enumerate(db):
            features, frames = clip
            features_count = len(features)

            # initial state score
            init_score = compute_score(features[0], a_query)

            # features scores
            for f in range(1, features_count):
                feature_distance_score = np.abs(f - features_index)
                feature_score = compute_score(features[f], b_query)
                score = init_score * INITIAL_SCORE + \
                        feature_distance_score * TIMING_SCORE + \
                        feature_score * FEATURE_SCORE
                if best_score > score:
                    best_score = score
                    best_frames = frames
                    best_clip = iclip
                    best_feature = f

        if debug_dict != None:
            debug_dict['frames_{}'.format(t)] = best_frames

        print (best_score, best_clip, best_feature)
        return best_frames

    # combine transition
    p, q = np.zeros((transition_time*2, len(skeleton.bones), 3)), np.zeros((transition_time*2, len(skeleton.bones), 4))
    transition_len = 0
    lastp, lastq = anim_a[0][-2:, :, :], anim_a[1][-2:, :, :]
    endp, endq = anim_b[0][:2, :, :], anim_b[1][:2, :, :]
    t = transition_time
    while t >= stride:
        frames = find_segment((lastp, lastq), (endp, endq), t)
        frames = disp.set_displacement_origin(skeleton, frames, (lastp[-1, 0, :], lastq[-1, 0, :]))

        p[transition_len: transition_len+stride, :, :] = frames[0]
        q[transition_len: transition_len + stride, :, :] = frames[1]

        transition_len += stride
        t -= stride
        lastp, lastq = frames[0][-2:, :, :], frames[1][-2:, :, :]

    return p[:transition_len:, :, :], q[:transition_len:, :, :]




