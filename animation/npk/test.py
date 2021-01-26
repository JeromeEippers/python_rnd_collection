import pickle

import numpy as np

import animations as IN
from animation_framework import modifier_displacement as disp
from animation_framework import posquat as pq
from animation_framework import skeleton as sk
import transition_type_b as trn



def create_transition_animation(resource_dir, skel:sk.Skeleton):

    anim_db = IN.load_animation_database()
    mapping_db = pickle.load(open(str(resource_dir / 'mapping.dump'), 'rb'))
    idle = pq.pose_to_pq(pickle.load(open(str(resource_dir / 'idle.dump'), 'rb')))
    idle = disp.reset_displacement_origin(skel, idle)
    relax = pq.pose_to_pq(pickle.load(open(str(resource_dir / 'idle_relax.dump'), 'rb')))
    relax = disp.reset_displacement_origin(skel, relax)
    alert = pq.pose_to_pq(pickle.load(open(str(resource_dir / 'idle_alerted.dump'), 'rb')))
    alert = disp.reset_displacement_origin(skel, alert)
    rootup = pq.quat_from_angle_axis(np.array([90 * 3.1415 / 180]), np.array([[1, 0, 0]]))
    is_transition = np.ones(6000)
    a = trn.create_transition(
        skel,
        anim_db,
        mapping_db,
        (idle[0][260:300, ...], idle[1][260:300, ...]),
        (idle[0][1440:1500, ...], idle[1][1440:1500, ...])
    )
    is_transition[:40] = 0
    is_transition[len(a[0]) - 60:len(a[0])] = 0
    a = trn.create_transition(
        skel,
        anim_db,
        mapping_db,
        a,
        (alert[0][0:40, ...], alert[1][0:40, ...])
    )
    is_transition[len(a[0]) - 40:len(a[0])] = 0
    a = trn.create_transition(
        skel,
        anim_db,
        mapping_db,
        a,
        disp.set_displacement_origin(
            skel,
            (idle[0][500:550, ...], idle[1][500:550, ...]),
            (
                np.array([0, 0, 0]),
                pq.quat_mul(rootup, pq.quat_from_angle_axis(np.array([-120 * 3.1415 / 180]), np.array([[0, 1, 0]])))
            )
        )
    )
    is_transition[len(a[0]) - 50:len(a[0])] = 0
    a = trn.create_transition(
        skel,
        anim_db,
        mapping_db,
        a,
        disp.set_displacement_origin(
            skel,
            (relax[0][00:50, ...], relax[1][00:50, ...]),
            (
                np.array([-5, 0, 0]),
                pq.quat_mul(rootup, pq.quat_from_angle_axis(np.array([-130 * 3.1415 / 180]), np.array([[0, 1, 0]])))
            )
        )
    )
    is_transition[len(a[0]) - 50:len(a[0])] = 0
    a = trn.create_transition(
        skel,
        anim_db,
        mapping_db,
        a,

        (idle[0][250:260, ...], idle[1][250:260, ...])
    )
    is_transition[len(a[0]) - 10:len(a[0])] = 0

    return a, is_transition[:len(a[0])]
