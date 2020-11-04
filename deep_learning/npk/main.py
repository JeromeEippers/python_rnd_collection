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
import transition_type_b as trn

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
    
reader = fbxreader.FbxReader(str(resource_dir / 'idle_relax.fbx'))
animation = reader.animation_dictionary(skeleton)['Take 001']
animation = np.dot(animation, np.array([[1,0,0,0], [0,0,-1,0], [0,1,0,0], [0,0,0,1]]))
disp.update_matrix_anim_projecting_disp_on_ground(animation)
x = pickle.dumps(animation)
with open(str(resource_dir / 'idle_relax.dump'), 'wb') as f:
    f.write(x)
    
raise Exception()
'''


'''
print("create animations")
animations = IN.get_raw_db_animations(skeleton)
animations = IN.generate_augmentation(skeleton, animations)
IN.save_animation_database(animations)

print("building db")
anim_db = IN.load_animation_database()
mapping_db = trn.build_mapping_table(skeleton, anim_db)
x = pickle.dumps(mapping_db)
with open(str(resource_dir / 'mapping.dump'), 'wb') as f:
    f.write(x)
print("done")
'''


anim_db = IN.load_animation_database()
mapping_db = pickle.load(open(str(resource_dir / 'mapping.dump'), 'rb'))

idle = pq.pose_to_pq(pickle.load(open(str(resource_dir / 'idle.dump'), 'rb')))
idle = disp.reset_displacement_origin(skeleton, idle)
relax = pq.pose_to_pq(pickle.load(open(str(resource_dir / 'idle_relax.dump'), 'rb')))
relax = disp.reset_displacement_origin(skeleton, relax)
alert = pq.pose_to_pq(pickle.load(open(str(resource_dir / 'idle_alerted.dump'), 'rb')))
alert = disp.reset_displacement_origin(skeleton, alert)
rootup = pq.quat_from_angle_axis(np.array([90 * 3.1415 / 180]), np.array([[1, 0, 0]]))

is_transition = np.ones(6000)
a = trn.create_transition(
    skeleton,
    anim_db,
    mapping_db,
    (idle[0][260:300, ...], idle[1][260:300, ...]),
    (idle[0][1440:1500, ...], idle[1][1440:1500, ...])
)
is_transition[:40] = 0
is_transition[len(a[0])-60:len(a[0])] = 0

a = trn.create_transition(
    skeleton,
    anim_db,
    mapping_db,
    a,
    (alert[0][0:40, ...], alert[1][0:40, ...])
)
is_transition[len(a[0])-40:len(a[0])] = 0

a = trn.create_transition(
    skeleton,
    anim_db,
    mapping_db,
    a,
    disp.set_displacement_origin(
        skeleton,
        (idle[0][500:550, ...], idle[1][500:550, ...]),
        (
            np.array([0, 0, 0]),
            pq.quat_mul(rootup, pq.quat_from_angle_axis(np.array([-120 * 3.1415 / 180]), np.array([[0, 1, 0]])))
        )
    )
)
is_transition[len(a[0])-50:len(a[0])] = 0

a = trn.create_transition(
    skeleton,
    anim_db,
    mapping_db,
    a,
    disp.set_displacement_origin(
        skeleton,
        (relax[0][00:50, ...], relax[1][00:50, ...]),
        (
            np.array([-35, 0, 0]),
            pq.quat_mul(rootup, pq.quat_from_angle_axis(np.array([-130 * 3.1415 / 180]), np.array([[0, 1, 0]])))
        )
    )
)
is_transition[len(a[0])-50:len(a[0])] = 0

a = trn.create_transition(
    skeleton,
    anim_db,
    mapping_db,
    a,

    (idle[0][250:260, ...], idle[1][250:260, ...])
)
is_transition[len(a[0])-10:len(a[0])] = 0

animations = [a, anim_db[226]]
transitions = [is_transition[:len(a[0])]]

# RENDERING ###############
currentAnim = -1


def compute_foot_contact_colors(skel: sk.Skeleton, anim, bonename):
    # generate foot speed
    is_static = ut.is_foot_static(anim[0][..., skel.boneid(bonename), :])
    contactcolors = np.repeat(np.zeros(3)[np.newaxis, ...], len(anim[0]), axis=0)
    contactcolors[is_static > 0.5] = np.array([1, 0, 0])
    return contactcolors


class MainWidget(viewer.CharacterWidget):

    def key_event(self, key, action, modifiers):
        global currentAnim
        global animations

        keys = self.window.wnd.keys

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
                self.window.reset_timer()

                print(('Switch to animation', currentAnim))
                anim = animations[currentAnim]

                body_color = np.ones_like(anim[0][:,0,:])
                #body_color[transitions[currentAnim] > 0.5] = np.array([.8, .8, 1])
                leftfootcoloranimation = compute_foot_contact_colors(skeleton, anim, 'Model:LeftFoot')
                rightfootcoloranimation = compute_foot_contact_colors(skeleton, anim, 'Model:RightFoot')


                self.change_animation(pq.pq_to_pose(anim), body_color, leftfootcoloranimation, rightfootcoloranimation)
        return False


viewer.ViewerWindow.widgets.append(
    MainWidget(True, vertices, indices, skinningindices, skinningweights, skeleton)
)
viewer.mglw.run_window_config(viewer.ViewerWindow)
