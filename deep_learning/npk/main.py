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
import importanimations as IN



resource_dir = Path(__file__).parent.resolve() / 'resources'

'''
# DUMP CHARACTER

reader = fbxreader.FbxReader(str(resource_dir / 'simplified_man_average.fbx'))
x = pickle.dumps(
    (*reader.vertices_and_indices(),
    *reader.skinning_indices_weights(),
    reader.skeleton())
)
with open(str(resource_dir / 'simplified_man_average.dump'), 'wb') as f:
    f.write(x)
    

# DUMP ANIMATIONS

vertices, indices, skinningindices, skinningweights, skeleton = pickle.load(open(str(resource_dir / 'simplified_man_average.dump'), 'rb'))
reader = fbxreader.FbxReader(str(resource_dir / 'side_steps.fbx'))
animation = reader.animation_dictionary(skeleton)['Take 001']
disp.update_matrix_anim_projecting_disp_on_ground(animation)
x = pickle.dumps(animation)
with open(str(resource_dir / 'side_steps.dump'), 'wb') as f:
    f.write(x)

reader = fbxreader.FbxReader(str(resource_dir / 'turn_steps.fbx'))
animation = reader.animation_dictionary(skeleton)['Take 001']
disp.update_matrix_anim_projecting_disp_on_ground(animation)
x = pickle.dumps(animation)
with open(str(resource_dir / 'turn_steps.dump'), 'wb') as f:
    f.write(x)
'''


def compute_foot_contact_colors(skel:skeleton.Skeleton, anim, bonename):
    # generate foot speed
    is_static = tr.is_foot_static(anim[0][..., skel.boneid(bonename),:])
    contactcolors = np.repeat(np.zeros(3)[np.newaxis, ...], len(anim[0]), axis=0)
    contactcolors[is_static > 0.5] = np.array([1, 0, 0])
    return contactcolors





vertices, indices, skinningindices, skinningweights, skeleton = pickle.load(
    open(str(resource_dir / 'simplified_man_average.dump'), 'rb'))

animations = IN.get_raw_animations(skeleton)

'''
pos, quat = skeleton.global_to_local(animations[0])

pos, quat = augment.warp(
    skeleton,
    animations[4],
    (animations[4][0][0,...], animations[4][1][0,...]),
    (animations[4][0][0,...], animations[4][1][0,...])
)

animations = [(pos, quat)] + animations
'''

# RENDERING ###############
currentAnim = -1
foot_draw = viewer.FootGroundDraw(skeleton)
char_draw = viewer.CharacterDraw(True, vertices, indices, skinningindices, skinningweights, skeleton)


def _keyboard(viewer, keys, key, action, modifiers):
    global currentAnim
    global foot_draw
    global char_draw
    if action == keys.ACTION_PRESS:
        if key == keys.RIGHT:
            currentAnim += 1
        if key == keys.LEFT:
            currentAnim += -1
        currentAnim = currentAnim % len(animations)
        viewer.reset_timer()

        print(('Switch to animation', currentAnim))
        anim = animations[currentAnim]

        # test tweaks
        #rot = pq.quat_from_angle_axis(np.array([20 * 3.1415 / 180]), np.array([[0,0,1]]))
        #anim = augment.offset_displacement_at_end(skeleton, anim, np.array([0, 0, 0]), rot[0])

        #anim = augment.scale_displacement(skeleton, anim, .5, 0.5)

        foot_draw.leftfootcoloranimation = compute_foot_contact_colors(skeleton, anim, 'Model:LeftFoot')
        foot_draw.rightfootcoloranimation = compute_foot_contact_colors(skeleton, anim, 'Model:RightFoot')

        anim = pq.pq_to_pose(anim)
        foot_draw.animation = anim
        char_draw.animation = anim


viewer.Viewer.draw_callbacks.append(foot_draw)
viewer.Viewer.draw_callbacks.append(char_draw)
viewer.Viewer.keyboard_callbacks.append(_keyboard)
viewer.mglw.run_window_config(viewer.Viewer)
