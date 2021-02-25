import numpy as np


import animation_framework as fw
from animation_framework import modifier
from animation_framework import posquat as pq
from animation_framework import animation as AN
from animation_framework import utilities as tr
from animation_framework import modifier_displacement as disp
from animation_framework import skeleton as skl

INITIAL_SCORE = 1
FEATURE_SCORE = 1
TIMING_SCORE = 20

class motionDB(object):
    def __init__(self, stride):
        self.stride = stride
        self.clips = []

def build_motion_db(animations, skeleton: skl.Skeleton, stride=10):

    db = motionDB(stride)

    def _build_motion(animation):
        animation_len = len(animation)
        last_clip = None
        for r in range(0, animation_len-stride-2, stride):
            anim = animation[r:]
            anim.pq = disp.reset_displacement_origin(skeleton, anim.pq)

            anim_len = len(anim)
            features_keys = list(range(0, anim_len-stride, stride))

            hipspos = anim.pq[0][:, skeleton.hipsid, :]
            lfpos = anim.pq[0][:, skeleton.leftfootid, :]
            rfpos = anim.pq[0][:, skeleton.rightfootid, :]
            hipsvec = tr.compute_vector(hipspos)
            lfvec = tr.compute_vector(lfpos)
            rfvec = tr.compute_vector(rfpos)

            frames = anim.pq[0][:stride+1], anim.pq[1][:stride+1]
            features = np.zeros((len(features_keys), 6, 3))
            features[:, 0, :] = hipspos[features_keys, :]
            features[:, 1, :] = lfpos[features_keys, :]
            features[:, 2, :] = rfpos[features_keys, :]
            features[:, 3, :] = hipsvec[features_keys, :]
            features[:, 4, :] = lfvec[features_keys, :]
            features[:, 5, :] = rfvec[features_keys, :]

            #create the animation of this clip
            clip = AN.Animation(frames, anim.name)
            clip.attributes.append(AN.Attribute(features, 'mm_features', False))
            if last_clip is not None:
                last_clip.attributes.append(AN.Attribute([clip], 'mm_next', False))

            last_clip = clip
            db.clips.append(clip)

    for animation in animations:
        _build_motion(animation)

    return db


def compute_score(feature, query):
    vec = feature - query
    dist = np.sum(vec * vec, axis=1) * np.array([2, 1, 1, 4, 6, 6])
    return np.sum(dist)


def find_segment(a, b, t, db, skeleton, debug_dict=None):

    # create a temp animation with a end b
    pos, quat = np.zeros((4, len(skeleton.bindpose), 3)), np.zeros((4, len(skeleton.bindpose), 4))
    pos[:2, :, :], quat[:2, :, :] = a[0][-2:, :, :], a[1][-2:, :, :]
    pos[2:, :, :], quat[2:, :, :] = b[0][:2, :, :], b[1][:2, :, :]

    # set in local space
    pos, quat = disp.reset_displacement_origin(skeleton, (pos, quat))

    hipspos = pos[:, skeleton.hipsid, :]
    lfpos = pos[:, skeleton.leftfootid, :]
    rfpos = pos[:, skeleton.rightfootid, :]
    hipsvec = tr.compute_vector(hipspos)
    lfvec = tr.compute_vector(lfpos)
    rfvec = tr.compute_vector(rfpos)

    if debug_dict != None:
        debug_dict['segment_a_{}'.format(t)] = a
        debug_dict['segment_b_{}'.format(t)] = b
        debug_dict['local_{}'.format(t)] = (pos, quat)

    a_query = np.zeros((6, 3))
    a_query[0, :] = hipspos[1, :]
    a_query[1, :] = lfpos[1, :]
    a_query[2, :] = rfpos[1, :]
    a_query[3, :] = hipsvec[0, :]
    a_query[4, :] = lfvec[0, :]
    a_query[5, :] = rfvec[0, :]

    b_query = np.zeros((6, 3))
    b_query[0, :] = hipspos[-2, :]
    b_query[1, :] = lfpos[-2, :]
    b_query[2, :] = rfpos[-2, :]
    b_query[3, :] = hipsvec[-1, :]
    b_query[4, :] = lfvec[-1, :]
    b_query[5, :] = rfvec[-1, :]

    # check all the clips for matching features
    features_index = int(t / db.stride)
    best_score = 1e8
    best_clip = None
    best_feature = -1
    for clip in db.clips:
        features = clip.attribute('mm_features').data
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
                best_clip = clip
                best_feature = f

    if debug_dict != None:
        debug_dict['frames_{}'.format(t)] = best_clip

    return best_clip, best_score


def create_motion_transition(db, skeleton, anim_a, anim_b, transition_time, debug_dict=None):
    '''
    Create a transition using a pure motionmatching implementation that goes from stride to stride
    :param db:
    :param skeleton:
    :param anim_a:
    :param anim_b:
    :param transition_time:
    :param debug_dict:
    :return:
    '''


    # combine transition
    p, q = np.zeros((transition_time*2, len(skeleton.bones), 3)), np.zeros((transition_time*2, len(skeleton.bones), 4))
    transition_len = 0
    lastp, lastq = anim_a.pq[0][-2:, :, :], anim_a.pq[1][-2:, :, :]
    endp, endq = anim_b.pq[0][:2, :, :], anim_b.pq[1][:2, :, :]
    t = transition_time

    last_segment = None
    best_score = 1e8

    while t >= db.stride:
        segment, score = find_segment((lastp, lastq), (endp, endq), t, db, skeleton, debug_dict)
        if last_segment is None or score < best_score:
            segment.pq = disp.set_displacement_origin(skeleton, segment.pq, (lastp[-1, 0, :], lastq[-1, 0, :]))
            last_segment = segment
            best_score = score

        p[transition_len: transition_len+db.stride, :, :] = last_segment.pq[0][:db.stride]
        q[transition_len: transition_len + db.stride, :, :] = last_segment.pq[1][:db.stride]

        transition_len += db.stride
        t -= db.stride
        lastp, lastq = last_segment.pq[0][-2:, :, :], last_segment.pq[1][-2:, :, :]

        next_clip = last_segment.attribute('mm_next')
        if next_clip is None:
            last_segment = None
            best_score = 1e8
        else:
            last_segment = next_clip.data[0]

    return AN.Animation((p[:transition_len:, :, :], q[:transition_len:, :, :]), name='transition')


def create_segment_transition(db, skeleton, anim_a, anim_b, transition_time, debug_dict=None):
    '''
    pick the best segment in the motion database and stick to it for the entire animation length
    :param db:
    :param skeleton:
    :param anim_a:
    :param anim_b:
    :param transition_time:
    :param debug_dict:
    :return:
    '''

    # combine transition
    p, q = np.zeros((transition_time * 2, len(skeleton.bones), 3)), np.zeros(
        (transition_time * 2, len(skeleton.bones), 4))
    transition_len = 0
    lastp, lastq = anim_a.pq[0][-2:, :, :], anim_a.pq[1][-2:, :, :]
    endp, endq = anim_b.pq[0][:2, :, :], anim_b.pq[1][:2, :, :]

    segment, score = find_segment((lastp, lastq), (endp, endq), transition_time, db, skeleton, debug_dict)
    while True:
        segment.pq = disp.set_displacement_origin(skeleton, segment.pq, (lastp[-1, 0, :], lastq[-1, 0, :]))

        p[transition_len: transition_len + db.stride, :, :] = segment.pq[0][:db.stride]
        q[transition_len: transition_len + db.stride, :, :] = segment.pq[1][:db.stride]

        lastp, lastq = segment.pq[0][-2:, :, :], segment.pq[1][-2:, :, :]

        next_clip = segment.attribute('mm_next')
        if next_clip is None:
            break
        segment = next_clip.data[0]
        transition_len += db.stride

    return AN.Animation((p[:transition_len:, :, :], q[:transition_len:, :, :]), name='transition')


