from pathlib import Path
import pickle
import numpy as np

import modifier
import posquat as pq
import copy

from viewer import viewer
import fbxreader
import skeleton as sk
import displacement as disp
import utilities as ut
import animations as IN
import transition as trn


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
'''

# LOAD CHARACTER
vertices, indices, skinningindices, skinningweights, skeleton = pickle.load(
    open(str(resource_dir / 'simplified_man_average.dump'), 'rb'))


'''
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
    
reader = fbxreader.FbxReader(str(resource_dir / 'idle.fbx'))
animation = reader.animation_dictionary(skeleton)['Take 001']
animation = np.dot(animation, np.array([[1,0,0,0], [0,0,-1,0], [0,1,0,0], [0,0,0,1]]))
disp.update_matrix_anim_projecting_disp_on_ground(animation)
x = pickle.dumps(animation)
with open(str(resource_dir / 'idle.dump'), 'wb') as f:
    f.write(x)


reader = fbxreader.FbxReader(str(resource_dir / 'on_spot.fbx'))
animation = reader.animation_dictionary(skeleton)['Take 001']
disp.update_matrix_anim_projecting_disp_on_ground(animation)
x = pickle.dumps(animation)
with open(str(resource_dir / 'on_spot.dump'), 'wb') as f:
    f.write(x)
    
raise Exception()
'''


def compute_foot_contact_colors(skel:sk.Skeleton, anim, bonename):
    # generate foot speed
    is_static = ut.is_foot_static(anim[0][..., skel.boneid(bonename), :])
    contactcolors = np.repeat(np.zeros(3)[np.newaxis, ...], len(anim[0]), axis=0)
    contactcolors[is_static > 0.5] = np.array([1, 0, 0])
    return contactcolors




'''
#animations = IN.get_raw_animations(skeleton)
#animations = IN.generate_augmentation(skeleton, animations)
#IN.save_animation_database(animations)

anim_db = IN.load_animation_database()
mapping_db = trn.build_mapping_table(skeleton, anim_db)


idle = pq.pose_to_pq(pickle.load(open(str(resource_dir / 'idle.dump'), 'rb')))
idle = disp.reset_displacement_origin(skeleton, idle)

a = trn.create_transition(
    skeleton,
    anim_db,
    mapping_db,
    (idle[0][260:300, ...], idle[1][260:300, ...]),
    (idle[0][1440:1500, ...], idle[1][1440:1500, ...])
)
a = trn.create_transition(
    skeleton,
    anim_db,
    mapping_db,
    a,
    modifier.mirror_animation((idle[0][200:240, ...], idle[1][200:240, ...]))
)
a = trn.create_transition(
    skeleton,
    anim_db,
    mapping_db,
    a,
    disp.set_displacement_origin(skeleton, (idle[0][500:550, ...], idle[1][500:550, ...]), (np.array([20,0,0]), pq.quat_from_angle_axis(np.array([90 * 3.1415 / 180]), np.array([[1, 0, 0]]))))
)
a = trn.create_transition(
    skeleton,
    anim_db,
    mapping_db,
    a,
    (idle[0][250:260, ...], idle[1][250:260, ...])
)

animations = [a]
'''
animations = [IN.get_raw_animation('on_spot')]
animations[0] = modifier.lock_feet(skeleton, animations[0], 5, 10)

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

            #lcl = skeleton.global_to_local(anim)
            #anim = skeleton.local_to_global(lcl)

            anim = pq.pq_to_pose(anim)
            foot_draw.animation = anim
            char_draw.animation = anim


viewer.Viewer.draw_callbacks.append(char_draw)
viewer.Viewer.draw_callbacks.append(foot_draw)
viewer.Viewer.keyboard_callbacks.append(_keyboard)
viewer.mglw.run_window_config(viewer.Viewer)
