from pathlib import Path
import pickle
import numpy as np

from animation_framework import modifier
from animation_framework import posquat as pq

import animation_framework as fw
from animation_framework.utilities import compute_bone_speed, is_foot_static
from animation_framework import skeleton as sk
from animation_framework import modifier_displacement as disp
from animation_framework import fbxreader

import footphase_extraction as FPE

resource_dir = Path(__file__).parent.resolve() / 'resources'


class Animation(object):
    def __init__(self, pq, features=None, lfphase=None, rfphase=None):
        self.pq = pq
        self.features = [] if features is None else features
        self.lfphase = [] if lfphase is None else lfphase
        self.rfphase = [] if rfphase is None else rfphase

    def extract(self, start, end):
        anim = Animation((self.pq[0][start:end, :, :], self.pq[1][start:end, :, :]))
        if len(self.features) > 0:
            anim.features = self.features[start:end]
        if len(self.lfphase) > 0:
            anim.lfphase = self.lfphase[start:end, ...]
        if len(self.rfphase) > 0:
            anim.rfphase = self.rfphase[start:end, ...]
        return anim


def convert_fbx_animation(name, need_rotation=False):
    skel = fw.get_skeleton()
    reader = fbxreader.FbxReader(str(resource_dir / '{}.fbx'.format(name)))
    animation = reader.animation_dictionary(skel)['Take 001']
    if need_rotation:
        animation = np.dot(animation, np.array([[1, 0, 0, 0], [0, 0, -1, 0], [0, 1, 0, 0], [0, 0, 0, 1]]))
    disp.update_matrix_anim_projecting_disp_on_ground(animation)
    x = pickle.dumps(animation)
    with open(str(resource_dir / '{}.dump'.format(name)), 'wb') as f:
        f.write(x)


def get_raw_animation(name, with_foot_phase=False):
    anm = pq.pose_to_pq(pickle.load(open(str(resource_dir / '{}.dump'.format(name)), 'rb')))
    animation = Animation(anm)
    if with_foot_phase:
        phase_path = resource_dir / '{}_phases.dump'.format(name)
        if phase_path.exists():
            lfphase, rfphase = pickle.load(open(phase_path, 'rb'))
        else:
            skel = fw.get_skeleton()

            lfcontact = is_foot_static(anm[0][:, skel.leftfootid, :])
            lffit = FPE.get_foot_phase_sinusoidal(lfcontact)
            lfphase = np.zeros((len(lfcontact), 6), dtype=np.float)
            lfphase[:, 0] = lfcontact
            lfphase[:, 1:] = lffit

            rfphase = []
            x = pickle.dumps((lfphase, rfphase))

            with open(str(resource_dir / '{}_phases.dump'.format(name)), 'wb') as f:
                f.write(x)

        animation.lfphase = lfphase
        animation.rfphase = rfphase

    return animation


def get_raw_db_animations(with_foot_phase=False):
    skel = fw.get_skeleton()
    animations = []

    animation = get_raw_animation('on_spot', with_foot_phase=with_foot_phase)
    animation.pq = modifier.lock_feet(skel, animation.pq, 5, 10)
    ranges = [[33, 130], [465, 528], [558, 647], [790, 857], [892, 961], [1120, 1190], [1465, 1528]]
    animations += [animation.extract(r[0], r[1]) for r in ranges]

    animation = get_raw_animation('side_steps', with_foot_phase=with_foot_phase)
    animation.pq = modifier.lock_feet(skel, animation.pq, 5, 10)
    ranges = [[185,256], [256,374], [374,463], [463,550], [550,636], [636,735],
              [735,816], [816,900], [900,990], [990,1080], [1080,1165], [1165,1260]]
    animations += [animation.extract(r[0]-185, r[1]-185) for r in ranges]

    animation = get_raw_animation('turn_steps', with_foot_phase=with_foot_phase)
    animation.pq = modifier.lock_feet(skel, animation.pq, 10, 5)
    ranges = [[184, 280], [280, 378], [375, 498], [490, 576], [576, 704], [704, 811], [811, 924], [920, 1026]]
    animations += [animation.extract(r[0]-184, r[1]-184) for r in ranges]

    for anim in animations:
        anim.pq = disp.reset_displacement_origin(skel, anim.pq)

    return animations




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

    '''
    animcount = len(animations)
    rots = [pq.quat_from_angle_axis(np.array([0 * 3.1415 / 180]), np.array([[0, 0, 1]]))]
    rots += [pq.quat_from_angle_axis(np.array([25 * 3.1415 / 180]), np.array([[0, 0, 1]]))]
    rots += [pq.quat_from_angle_axis(np.array([-25 * 3.1415 / 180]), np.array([[0, 0, 1]]))]
    movs = [np.array([15, 0, 0])]
    movs += [np.array([0, 0, 15])]
    movs += [np.array([0, 0, -15])]
    for i in range(animcount):
        print('generate pass {} / {}'.format(i, animcount))
        for rot in rots:
            for mov in movs:
                animations += [displacement.offset_displacement_at_end(skel, copy.deepcopy(animations[i]), mov, rot)]
    '''

    animcount = len(animations)
    print('generate blends {}'.format(animcount * animcount))
    for i in range(animcount):
        for j in range(animcount):
            if i != j:
                try:
                    a = modifier.blend_anim_foot_phase(skel, animations[i], animations[j], 0.5)
                    animations.append(a)
                except Exception:
                    pass

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

