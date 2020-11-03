from pathlib import Path
import pickle
import numpy as np

import displacement
import modifier
import posquat as pq
import copy

from utilities import compute_bone_speed
import skeleton as sk
import displacement as disp

resource_dir = Path(__file__).parent.resolve() / 'resources'


def get_raw_animation(name):
    return pq.pose_to_pq(pickle.load(open(str(resource_dir / '{}.dump'.format(name)), 'rb')))


def get_raw_db_animations(skel:sk.Skeleton):

    animations = []

    animation = get_raw_animation('on_spot')
    animation = modifier.lock_feet(skel, animation, 5, 10)
    ranges = [[33, 130], [465, 528], [558, 647], [790, 857], [892, 961], [1120, 1190], [1465, 1528]]
    animations += [(animation[0][r[0]:r[1], ...], animation[1][r[0]:r[1], ...]) for r in ranges]


    animation = get_raw_animation('side_steps')
    animation = modifier.lock_feet(skel, animation, 5, 10)
    ranges = [[185,256], [256,374], [374,463], [463,550], [550,636], [636,735],
              [735,816], [816,900], [900,990], [990,1080], [1080,1165], [1165,1260]]
    animations += [(animation[0][r[0]-185:r[1]-185,...], animation[1][r[0]-185:r[1]-185,...]) for r in ranges]


    animation = get_raw_animation('turn_steps')
    animation = modifier.lock_feet(skel, animation)
    ranges = [[184, 280], [280, 378], [375, 498], [490, 576], [576, 704], [704, 811], [811, 924], [920, 1026]]
    animations += [(animation[0][r[0] - 184:r[1] - 184, ...], animation[1][r[0] - 184:r[1] - 184, ...]) for r in ranges]

    animations = [
        disp.reset_displacement_origin(skel, anim) for anim in
        animations
    ]

    return animations



def split_animation_by_foot_ground_contacts(skel : sk.Skeleton, anim, speedlimit=15):
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


def is_animation_valid(skel:sk.Skeleton, anim):
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
    ) > skel.leglength + skel.upleglength + 1:
        return False
    if np.max(
            np.linalg.norm(
                anim[0][..., skel.boneid('Model:RightFoot'), :] - anim[0][..., skel.boneid('Model:RightUpLeg'), :],
                axis=-1
            )
    ) > skel.leglength + skel.upleglength + 1:
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


def generate_augmentation(skel:sk.Skeleton, animations):

    # 7 first are on spot

    # 12 next are side steps
    # make small steps
    '''
    animcount = 12
    for i in range(7, 7+animcount):
        print('generate pass {} / {}'.format(i, animcount))
        animations += [displacement.scale_displacement(skel, copy.deepcopy(animations[i]), 0.6, 0.6)]
    animations = [anim for anim in animations if is_animation_valid(skel, anim)]
    '''

    animcount = len(animations)
    for i in range(animcount):
        print('generate mirrors {} / {}'.format(i, animcount))
        animations += [modifier.mirror_animation(animations[i])]

    animcount = len(animations)
    rots = [pq.quat_from_angle_axis(np.array([0 * 3.1415 / 180]), np.array([[0, 0, 1]]))]
    rots += [pq.quat_from_angle_axis(np.array([25 * 3.1415 / 180]), np.array([[0, 0, 1]]))]
    rots += [pq.quat_from_angle_axis(np.array([-25 * 3.1415 / 180]), np.array([[0, 0, 1]]))]
    movs = [np.array([15, 0, 0])]
    movs += [np.array([0, 0, 15])]
    movs += [np.array([0, 0, -15])]
    movs += [np.array([15, 0, 15])]
    movs += [np.array([15, 0, -15])]
    for i in range(animcount):
        print('generate pass {} / {}'.format(i, animcount))
        for rot in rots:
            for mov in movs:
                animations += [displacement.offset_displacement_at_end(skel, copy.deepcopy(animations[i]), mov, rot)]

    '''
    animations = [anim for anim in animations if is_animation_valid(skel, anim)]
    animcount = len(animations)
    for i in range(animcount):
        print('generate pass {} / {}'.format(i, animcount))
        animations += [displacement.scale_displacement(skel, copy.deepcopy(animations[i]), 0.6, 0.8)]
    animations = [anim for anim in animations if is_animation_valid(skel, anim)]
    '''

    print('generate {} animations'.format(len(animations)))
    return animations

def save_animation_database(animations):
    x = pickle.dumps(animations)
    with open(str(resource_dir / 'animation_database.dump'), 'wb') as f:
        f.write(x)


def load_animation_database():
    return pickle.load(open(str(resource_dir / 'animation_database.dump'), 'rb'))

