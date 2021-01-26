import numpy as np

import animation_framework as fw
from animation_framework import modifier
from animation_framework import posquat as pq
from animation_framework import utilities as tr
from animation_framework import modifier_displacement as disp
from animation_framework import skeleton as skl


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


class MotionMatchingFeatureDBDebug(fw.viewer.Widget):
    '''
    This is used as sub widget of MotionMatchingDBDebug !
    '''
    def __init__(self, widgets=None):
        super().__init__(widgets=widgets)
        self.line_widget = fw.viewer.LineWidget(color=np.array([1, 0, 0]))
        self.widgets.append(self.line_widget)

    def update_animation(self):
        if self.parent.current_animation in self.parent.animation_dictionary:
            features, frames = self.parent.animation_dictionary[self.parent.current_animation]

            points = np.zeros((4 * len(features), 3))
            for i in range(len(features)):
                points[i * 4, :] = features[i, 0, :]
                points[i * 4 + 1, :] = features[i, 1, :]
                points[i * 4 + 2, :] = features[i, 0, :]
                points[i * 4 + 3, :] = features[i, 2, :]
            self.line_widget.set_points(points)


class MotionMatchingDBDebug(fw.viewer.AnimationDictionaryWidget):
    def animation(self, anim_name):
        if anim_name in self.animation_dictionary:
            return self.animation_dictionary[anim_name][1]
        return []


def db_debug_widget(db):
    widget = MotionMatchingDBDebug(
        animation_dictionary={str(i): anim for i, anim in enumerate(db[1])},
        widgets=[
            MotionMatchingFeatureDBDebug()
        ])
    widget.set_current_animation('0')
    return widget


def create_motion_transition(db, skeleton, anim_a, anim_b, transition_time):
    stride, db = db

    root = np.eye(4)
    root[0, :3] = np.array([-1, 0, 0])
    root[1, :3] = np.array([0, 0, 1])
    root[2, :3] = np.array([0, 1, 0])
    root = pq.pose_to_pq(root)

    def compute_score(feature, query):
        vec = feature - query
        dist = np.sum(vec * vec)
        return 1.0 / (dist + 1e-8)

    def find_segment(a, b, t):

        # set animations in local space relative to end of a
        inverse_root = pq.inv(None, a[0][-1, 0, :], a[1][-1, 0, :])
        a = skeleton.global_to_local(a, inverse_root)
        a = skeleton.local_to_global(a, root)
        b = skeleton.global_to_local(b, inverse_root)
        b = skeleton.local_to_global(b, root)

        a_query = np.zeros((3, 3))
        a_query[0, :] = a[0][-1, skeleton.hipsid, :]
        a_query[1, :] = a[0][-1, skeleton.leftfootid, :]
        a_query[2, :] = a[0][-1, skeleton.rightfootid, :]

        b_query = np.zeros((3, 3))
        b_query[0, :] = b[0][-1, skeleton.hipsid, :]
        b_query[1, :] = b[0][-1, skeleton.leftfootid, :]
        b_query[2, :] = b[0][-1, skeleton.rightfootid, :]

        # check all the clips for matching features
        features_index = int(t / stride)
        best_score = -1
        best_frames = None
        for clip in db:
            features, frames = clip
            features_count = len(features)

            # initial state score
            init_score = compute_score(features[0], a_query)

            # features scores
            for f in range(1, features_count):
                feature_distance_score = 1.0 / np.abs(f - features_index)
                feature_score = compute_score(features[f], b_query)
                score = init_score * 4.0 + feature_distance_score + feature_score * 3.0
                if best_score < score:
                    best_score = score
                    best_frames = frames

        return best_frames

    # TODO use the frames to concatanate animation



