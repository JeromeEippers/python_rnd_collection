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


    return [
        disp.reset_displacement_origin(skel, anim) for anim in
        animations
    ]