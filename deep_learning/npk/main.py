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


# DUMP CHARACTER
'''
reader = fbxreader.FbxReader(str(resource_dir / 'simplified_man_average.fbx'))
x = pickle.dumps(
    (*reader.vertices_and_indices(),
    *reader.skinning_indices_weights(),
    reader.skeleton())
)
with open(str(resource_dir / 'simplified_man_average.dump'), 'wb') as f:
    f.write(x)

raise Exception()


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
#animations = IN.generate_augmentation(skeleton, animations)
#IN.save_animation_database(animations)

# RENDERING ###############
currentAnim = -1
foot_draw = viewer.FootGroundDraw(skeleton)
char_draw = viewer.CharacterDraw(True, vertices, indices, skinningindices, skinningweights, skeleton)


def _keyboard(viewer, keys, key, action, modifiers):
    global currentAnim
    global foot_draw
    global char_draw
    if action == keys.ACTION_PRESS:
        switch_anim = False
        if key == keys.RIGHT:
            currentAnim += 1
            switch_anim = True
        if key == keys.LEFT:
            currentAnim += -1
            switch_anim = True

        if switch_anim:
            currentAnim = currentAnim % len(animations)
            viewer.reset_timer()

            print(('Switch to animation', currentAnim))
            anim = animations[currentAnim]

            foot_draw.leftfootcoloranimation = compute_foot_contact_colors(skeleton, anim, 'Model:LeftFoot')
            foot_draw.rightfootcoloranimation = compute_foot_contact_colors(skeleton, anim, 'Model:RightFoot')

            anim = pq.pq_to_pose(anim)
            foot_draw.animation = anim
            char_draw.animation = anim


viewer.Viewer.draw_callbacks.append(foot_draw)
viewer.Viewer.draw_callbacks.append(char_draw)
viewer.Viewer.keyboard_callbacks.append(_keyboard)
viewer.mglw.run_window_config(viewer.Viewer)
