from pathlib import Path
import pickle
import numpy as np
import posquat as pq
import copy

from viewer import viewer
import fbxreader
import skeleton
import displacement as disp
import transform as tr
import augmentation as augment
import physic as ph

resource_dir = Path(__file__).parent.resolve() / 'resources'


def get_raw_animations(skel:skeleton.Skeleton):

    animations = []

    animation = pq.pose_to_pq(pickle.load(open(str(resource_dir / 'side_steps.dump'), 'rb')))
    animation = tr.lock_feet(skel, animation, 5, 10)
    ranges = [[185,256], [256,374], [374,463], [463,550], [550,636], [636,735],
              [735,816], [816,900], [900,990], [990,1080], [1080,1165], [1165,1260]]
    animations += [(animation[0][r[0]-185:r[1]-185,...], animation[1][r[0]-185:r[1]-185,...]) for r in ranges]


    animation = pq.pose_to_pq(pickle.load(open(str(resource_dir / 'turn_steps.dump'), 'rb')))
    animation = tr.lock_feet(skel, animation)
    ranges = [[184, 280], [280, 378], [375, 498], [490, 576], [576, 704], [704, 811], [811, 924], [920, 1026]]
    animations += [(animation[0][r[0] - 184:r[1] - 184, ...], animation[1][r[0] - 184:r[1] - 184, ...]) for r in ranges]

    animations = [
        disp.reset_displacement_origin(skel, anim) for anim in
        animations
    ]

    return animations


def is_animation_valid(skel:skeleton.Skeleton, anim):
    x = np.max(
            np.linalg.norm(
                anim[0][..., skel.boneid('Model:LeftFoot'), :] - anim[0][..., skel.boneid('Model:LeftUpLeg'), :],
                axis=-1
            )
    )
    if np.max(
            np.linalg.norm(
                anim[0][..., skel.boneid('Model:LeftFoot'), :] - anim[0][..., skel.boneid('Model:LeftUpLeg'), :],
                axis=-1
            )
    ) > skel.leglength + skel.upleglength + 2:
        return False
    if np.max(
            np.linalg.norm(
                anim[0][..., skel.boneid('Model:RightFoot'), :] - anim[0][..., skel.boneid('Model:RightUpLeg'), :],
                axis=-1
            )
    ) > skel.leglength + skel.upleglength + 2:
        return False
    if np.min(
            np.linalg.norm(
                anim[0][..., skel.boneid('Model:LeftFoot'),:] - anim[0][..., skel.boneid('Model:RightFoot'),:], axis=-1
            )
    ) < 10:
        return False
    if np.min(
            np.linalg.norm(
                anim[0][..., skel.boneid('Model:LeftFootToes'),:] - anim[0][..., skel.boneid('Model:RightFootToes'),:], axis=-1
            )
    ) < 15:
        return False
    if np.min(
            np.linalg.norm(
                anim[0][..., skel.boneid('Model:LeftFootToes'),:] - anim[0][..., skel.boneid('Model:RightFoot'),:], axis=-1
            )
    ) < 20:
        return False
    if np.min(
            np.linalg.norm(
                anim[0][..., skel.boneid('Model:LeftFoot'),:] - anim[0][..., skel.boneid('Model:RightFootToes'),:], axis=-1
            )
    ) < 20:
        return False
    return True



def generate_augmentation(skel:skeleton.Skeleton, animations):

    # 12 first are side steps
    # make small steps
    animcount = 12
    for i in range(animcount):
        print('generate pass {} / {}'.format(i, animcount))
        animations += [augment.scale_displacement(skel, copy.deepcopy(animations[i]), 0.5, 0.5)]
    animations = [anim for anim in animations if is_animation_valid(skel, anim)]

    animcount = len(animations)
    for i in range(animcount):
        print('generate mirrors {} / {}'.format(i, animcount))
        animations += [tr.mirror_animation(animations[i])]

    animcount = len(animations)
    rots = [pq.quat_from_angle_axis(np.array([0 * 3.1415 / 180]), np.array([[0, 0, 1]]))]
    rots += [pq.quat_from_angle_axis(np.array([20 * 3.1415 / 180]), np.array([[0, 0, 1]]))]
    rots += [pq.quat_from_angle_axis(np.array([-20 * 3.1415 / 180]), np.array([[0, 0, 1]]))]
    rots += [pq.quat_from_angle_axis(np.array([40 * 3.1415 / 180]), np.array([[0, 0, 1]]))]
    rots += [pq.quat_from_angle_axis(np.array([-40 * 3.1415 / 180]), np.array([[0, 0, 1]]))]
    movs = [np.array([30, 0, 0])]
    movs += [np.array([0, 0, 30])]
    movs += [np.array([0, 0, -30])]
    movs += [np.array([20, 0, 20])]
    for i in range(animcount):
        print('generate pass {} / {}'.format(i, animcount))
        for rot in rots:
            for mov in movs:
                animations += [augment.offset_displacement_at_end(skel, copy.deepcopy(animations[i]), mov, rot)]

    animations = [anim for anim in animations if is_animation_valid(skel, anim)]
    animcount = len(animations)
    for i in range(animcount):
        print('generate pass {} / {}'.format(i, animcount))
        animations += [augment.scale_displacement(skel, copy.deepcopy(animations[i]), 0.6, 0.8)]
    animations = [anim for anim in animations if is_animation_valid(skel, anim)]

    print('generate {} animations'.format(len(animations)))
    return animations


def save_animation_database(animations):
    x = pickle.dumps(animations)
    with open(str(resource_dir / 'animation_database.dump'), 'wb') as f:
        f.write(x)


def load_animation_database():
    return pickle.load(open(str(resource_dir / 'animation_database.dump'), 'rb'))

