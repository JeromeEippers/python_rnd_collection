import copy
import math

import numpy as np
import posquat as pq
import transform as tr
import skeleton


def update_anim_with_cop(skel: skeleton.Skeleton, anim):

    com = anim[0][..., skel.boneid('Model:Spine2'), :] * 0.5 + \
          anim[0][..., skel.boneid('Model:LeftUpLeg'), :] * 0.25 + \
          anim[0][..., skel.boneid('Model:RightUpLeg'), :] * 0.25
    com_velocities = tr.compute_vector(com) * 30.0
    com_velocities[..., 1] -= 9.81*30
    predicted_com = com + com_velocities / 30.0

    # compute the direction of the force that allows the motion
    inverse_force = pq.vec_normalize(
        predicted_com[:-1] - com[1:]
    )

    # project the force on the ground
    growarray = np.ones(3)
    cop = com[1:] - inverse_force * (com[1:, 1][..., np.newaxis] * growarray) / (inverse_force[:,1][..., np.newaxis] * growarray)

    anim[0][1:, skel.copid, :], anim[1][..., skel.copid, :] = cop, copy.deepcopy(anim[1][..., skel.hipsid, :])
    anim[0][0, skel.copid, :] = copy.deepcopy(anim[0][1, skel.copid, :])
    return anim