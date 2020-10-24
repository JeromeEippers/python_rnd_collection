from pathlib import Path
import pickle
import numpy as np
import posquat as pq
import copy

from viewer import viewer
import fbxreader
import displacement as disp
import transform as tr


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


def compute_foot_contact_colors(skel, anim, bonename, speedlimit=15):
    # generate foot speed
    footspeed = tr.compute_bone_speed(skel, anim, bonename)
    contactcolors = np.repeat(np.zeros(3)[np.newaxis, ...], len(anim[0]), axis=0)
    contactcolors[footspeed < speedlimit] = np.array([1, 0, 0])
    return contactcolors


def split_animation_by_foot_ground_contacts(skel, anim, speedlimit=15):
    # generate foot speed
    leftfootspeed = tr.compute_bone_speed(skel, anim, 'Model:LeftFoot')
    rightfootspeed = tr.compute_bone_speed(skel, anim, 'Model:RightFoot')

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


vertices, indices, skinningindices, skinningweights, skeleton = pickle.load(
    open(str(resource_dir / 'simplified_man_average.dump'), 'rb'))

'''
animation = pickle.load(open(str(resource_dir / 'side_steps.dump'), 'rb'))
animations = split_animation_by_foot_ground_contacts(skeleton, animation, 15)

animation = pickle.load(open(str(resource_dir / 'turn_steps.dump'), 'rb'))
animations += split_animation_by_foot_ground_contacts(skeleton, animation, 20)


animations = [disp.reset_displacement(skeleton, animations[15])]
animations += [disp.mirror_animation(animations[0])]
'''

animation = pq.pose_to_pq(pickle.load(open(str(resource_dir / 'side_steps.dump'), 'rb')))
animations = split_animation_by_foot_ground_contacts(skeleton, animation, 15)
animations = [disp.reset_displacement_origin(skeleton, anim) for anim in animations]

# TEST LERP
pos, quat = skeleton.global_to_local(animations[0])

npos = np.zeros([60,24,3])
nquat = np.zeros([60,24,4])

for i in range(60):
    npos[i,...], nquat[i,...] = pq.lerp( (pos[0], quat[0]), (pos[50], quat[50]), float(i)/60 )

pos, quat = skeleton.local_to_global((npos, nquat))
animations = [(pos, quat)] + animations


# RENDERING ###############
currentAnim = -1
foot_draw = viewer.FootGroundDraw(skeleton)
char_draw = viewer.CharacterDraw(True, vertices, indices, skinningindices, skinningweights, skeleton)


def _keyboard(keys, key, action, modifiers):
    global currentAnim
    global foot_draw
    global char_draw
    if action == keys.ACTION_PRESS:
        if key == keys.RIGHT:
            currentAnim += 1
        if key == keys.LEFT:
            currentAnim += -1
        currentAnim = currentAnim % len(animations)

        print(('Switch to animation', currentAnim))
        anim = animations[currentAnim]

        #test ik
        hipsP, hipsQ = copy.deepcopy(anim[0][...,skeleton.hipsid,:]), copy.deepcopy(anim[1][...,skeleton.hipsid,:])
        leftP, leftQ = anim[0][...,skeleton.leftlegids[-1],:], anim[1][...,skeleton.leftlegids[-1],:]
        rightP, rightQ = anim[0][..., skeleton.rightlegids[-1], :], anim[1][..., skeleton.rightlegids[-1], :]

        hipsP[..., 1] -= 20

        anim = skeleton.foot_ik( (hipsP, hipsQ), (leftP, leftQ), (rightP, rightQ), globalpose=anim )

        foot_draw.leftfootcoloranimation = compute_foot_contact_colors(skeleton, anim, 'Model:LeftFoot', 20)
        foot_draw.rightfootcoloranimation = compute_foot_contact_colors(skeleton, anim, 'Model:RightFoot', 20)

        anim = pq.pq_to_pose(anim)
        foot_draw.animation = anim
        char_draw.animation = anim


viewer.Viewer.draw_callbacks.append(foot_draw)
viewer.Viewer.draw_callbacks.append(char_draw)
viewer.Viewer.keyboard_callbacks.append(_keyboard)
viewer.mglw.run_window_config(viewer.Viewer)
