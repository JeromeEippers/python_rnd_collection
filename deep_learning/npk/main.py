from pathlib import Path
import pickle
import numpy as np

from viewer import viewer
import fbxreader
import moderngl

resource_dir = Path(__file__).parent.resolve() / 'resources'

'''
reader = fbxreader.FbxReader(str(resource_dir / 'simplified_man_average.fbx'))
x = pickle.dumps(
    (*reader.vertices_and_indices(),
    *reader.skinning_indices_weights(),
    reader.skeleton())
)
with open(str(resource_dir / 'simplified_man_average.dump'), 'wb') as f:
    f.write(x)
    
vertices, indices, skinningindices, skinningweights, skeleton = pickle.load(open(str(resource_dir / 'simplified_man_average.dump'), 'rb'))
reader = fbxreader.FbxReader(str(resource_dir / 'side_steps.fbx'))
animation = reader.animation_dictionary(skeleton)['Take 001']
x = pickle.dumps(animation)
with open(str(resource_dir / 'side_steps.dump'), 'wb') as f:
    f.write(x)
'''


def cross(a, b):
    """Compute a cross product for a list of vectors"""
    return np.concatenate([
        a[..., 1:2] * b[..., 2:3] - a[..., 2:3] * b[..., 1:2],
        a[..., 2:3] * b[..., 0:1] - a[..., 0:1] * b[..., 2:3],
        a[..., 0:1] * b[..., 1:2] - a[..., 1:2] * b[..., 0:1],
    ], axis=-1)


def project_disp_on_ground(anim):
    """
    project displacement on the ground from the hips
    input animation is in global space already
    it updates the input animation
    """
    anim[:, 0, :, :] = np.array(anim[:, 1, :, :], copy=True)
    anim[:, 0, 3, 1] = 0

    eye = np.eye(4)
    eye = np.repeat(eye[np.newaxis, ...], len(anim[0]), axis=0)
    eye = np.repeat(eye[np.newaxis, ...], len(anim), axis=0)

    y = cross(anim[:, 0, 2, :3], eye[:, 0, 1, :3])
    x = cross(y, eye[:, 0, 1, :3])

    anim[:, 0, 0, :3] = x
    anim[:, 0, 1, :3] = y
    anim[:, 0, 2, :3] = eye[:, 0, 1, :3]


def kill_displacement(skel, anim):
    for f in range(len(anim)):
        anim[f, ...] = skel.localpose(anim[f, ...])
    anim[:, 0, 3, 0] = 0
    anim[:, 0, 3, 2] = 0
    for f in range(len(anim)):
        anim[f, ...] = skel.globalpose(anim[f, ...])


def compute_foot_speed(skel, anim, bonename):
    id = skel.boneid(bonename)
    speed = np.zeros(len(anim))
    for f in range(len(anim) - 1):
        speed[f + 1] = np.linalg.norm(anim[f + 1, id, 3, :3] - anim[f, id, 3, :3]) * 30.0
    return speed

def split_animation_by_foot_ground_contacts(skel, anim):
    #generate foot speed
    leftfootspeed = compute_foot_speed(skel, anim, 'Model:LeftFoot')
    rightfootspeed = compute_foot_speed(skel, anim, 'Model:RightFoot')

    #generate foot speed colors
    leftcontactcolors = np.repeat(np.array([0, 0, 0])[np.newaxis, ...], len(animation), axis=0)
    leftcontactcolors[leftfootspeed < 15] = np.array([1, 0, 0])
    rightcontactcolors = np.repeat(np.array([0, 0, 0])[np.newaxis, ...], len(animation), axis=0)
    rightcontactcolors[rightfootspeed < 15] = np.array([1, 0, 0])

    #splits
    ranges = np.concatenate(np.argwhere((leftfootspeed <= 15) & (rightfootspeed <= 15)))
    splits = []
    currentbegin = ranges[0]
    lastindex = ranges[0]
    for r in ranges[1:]:
        if r > lastindex + 1:
            splits.append(int(currentbegin + (lastindex - currentbegin) / 2))
            currentbegin = r
        lastindex = r

    animations = []
    leftfootcolors = []
    rightfootcolors = []
    for s in range(len(splits) - 1):
        animations.append(anim[splits[s]:splits[s + 1], ...])
        leftfootcolors.append(leftcontactcolors[splits[s]:splits[s + 1], ...])
        rightfootcolors.append(rightcontactcolors[splits[s]:splits[s + 1], ...])

    return animations, leftfootcolors, rightfootcolors



vertices, indices, skinningindices, skinningweights, skeleton = pickle.load(
    open(str(resource_dir / 'simplified_man_average.dump'), 'rb'))
animation = pickle.load(open(str(resource_dir / 'side_steps.dump'), 'rb'))

#project on ground the displacement
project_disp_on_ground(animation)

#split the animations
animations, leftfootcolors, rightfootcolors = split_animation_by_foot_ground_contacts(skeleton, animation)


foot_draw = viewer.FootGroundDraw(skeleton, animations[1], leftfootcolors[1], rightfootcolors[1])
char_draw = viewer.CharacterDraw(True, vertices, indices, skinningindices, skinningweights, skeleton, animations[1])
viewer.Viewer.drawers.append(foot_draw)
viewer.Viewer.drawers.append(char_draw)
viewer.mglw.run_window_config(viewer.Viewer)
