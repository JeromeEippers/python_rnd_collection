from pathlib import Path
import pickle
import numpy as np

import animation_framework as fw
import viewers as V

from animation_framework import posquat as pq

import test
from animation_framework import skeleton as sk
from animation_framework import utilities as ut
import animations as IN
import transition_type_b as trn
import motionmatching as MM

resource_dir = Path(__file__).parent.resolve() / 'resources'


# LOAD CHARACTER
skeleton = fw.get_skeleton()

'''
# DUMP ANIMATIONS

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

#a, is_transition = test.create_transition_animation(resource_dir, skeleton)
#animations = [a]
#transitions = [is_transition]

#animations = IN.get_raw_db_animations(with_foot_phase=True)
animations = [IN.get_raw_animation('side_steps', with_foot_phase=True)]
#motionmatching_db = MM.build_motion_db(animations, skeleton, stride=8)

#anim_a = animations[0][0][:2,:,:], animations[0][1][:2,:,:]
#anim_b = animations[0][0][-2:,:,:], animations[0][1][-2:,:,:]
#debug_transition = {}
#transition = MM.create_motion_transition(motionmatching_db, skeleton, anim_a, anim_b, 80, debug_dict=debug_transition)


# RENDERING ###############
fw.run_main_window(widgets_addon=[
    V.animations_widget(animations),
])
