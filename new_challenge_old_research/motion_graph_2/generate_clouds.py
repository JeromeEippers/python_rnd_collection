import os
import sys

import numpy as np
from scipy.optimize import minimize

WRAP_LENGTH = 10

_this_folder_ = '\\'.join(__file__.split('\\')[:-1])
_parent_folder_ = '\\'.join(__file__.split('\\')[:-2])
if _parent_folder_ not in sys.path:
    sys.path.append(_parent_folder_)
    
from skeleton import *
from animation import *

animations = load_animations(_this_folder_+'\\all_moves_animations.dat')
animations = [animation for animation in animations if animation[0] >= 15]

def point_cloud(skeleton):
    cloud = np.array([skeleton.anchorGlobalPosition(i) for i in range(len(skeleton._anchors))])
    average = np.average(cloud, axis=0)
    average[2] = 0
    return cloud - average

def point_cloud_and_average(skeleton):
    cloud = np.array([skeleton.anchorGlobalPosition(i) for i in range(len(skeleton._anchors))])
    average = np.average(cloud, axis=0)
    average[2] = 0
    return cloud, average

def rotate_cloud(cloud, theta):
    c, s = np.cos(theta), np.sin(theta)
    M = np.array([[c,-s,0],[s,c,0],[0,0,1]])
    return cloud.dot(M)

def align_cloud(cloud, x,y,t):
    cloud = rotate_cloud(cloud, t)
    return cloud + np.array([x,y,0])

def get_anim_cloud_from_animation(skeleton, animation):
    keycount_a, _ = animation
    anim_a_clouds = []
    anim_a_averages = []
    for frame in range(keycount_a):
        skeleton.load_animation(animation, frame)
        cloud, average = point_cloud_and_average(skeleton)
        anim_a_clouds.append(cloud)
        anim_a_averages.append(average)
    return anim_a_clouds, anim_a_averages

def is_looping_animation(skeleton, animation):
    keycount, _ = animation
    
    def _objective(xyt, cloud_a, cloud_b):
        cloud = align_cloud(cloud_b, *xyt)
        v = cloud_a - cloud
        return np.sum(v*v) * 0.5
    
    skeleton.load_animation(animation, 0)
    cloud_a = point_cloud(skeleton)
    skeleton.load_animation(animation, keycount-1)
    cloud_b = point_cloud(skeleton)
        
    extra = (cloud_a,cloud_b)
    sol = minimize(_objective, [0,0,0], method='SLSQP', args=extra)
    return sol.fun < 0.0001

def align_animations(skeleton, animation, animation_frame):
    
    def _objective(xyt, cloud_a, cloud_b):
        cloud = align_cloud(cloud_b, *xyt)
        v = cloud_a - cloud
        return np.sum(v*v) * 0.5

    #we will solve clouds for previous node and next node
    #the skeleton already holds the previous frame
    cloud_a, average_a = point_cloud_and_average(skeleton)
    #load the new animation
    skeleton.load_animation(animation, animation_frame)
    cloud_b, average_b = point_cloud_and_average(skeleton)

    #remove the average to help the minize function
    cloud_a -= average_a
    cloud_b -= average_b
    average = average_b-average_a

    #align
    sol = minimize(_objective, [0,0,0], method='SLSQP', args=(cloud_a, cloud_b))

    #build matrix out of our result
    x,y,theta = sol.x
    c, s = np.cos(theta), np.sin(theta)
    M = np.array([[c,-s,0,0],[s,c,0,0],[0,0,1,0],[0,0,0,1]], dtype=float)

    #move the world matrix
    skeleton.world[3][:3] -= average+np.array([x,y,0])

    #recompute the center of cloud
    skeleton.load_animation(animation, animation_frame)
    cloud_b, average_b = point_cloud_and_average(skeleton)

    #rotate the matrix around the center of the cloud
    skeleton.world[3][:3] -= average_b
    skeleton.world = skeleton.world.dot(M)
    skeleton.world[3][:3] += average_b

def create_looping_animation_track(skeleton, animation):
    #assuming a looping animation, we create a new animation with WRAP_LENGTH data in front and end
    tracks_buffer = skeleton.create_tracks_buffer()
    keycount, tracks = animation
    
    #store the last x frames
    skeleton.world = np.array([[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]], dtype=float)
    for i in range(keycount-WRAP_LENGTH-1, keycount): #go one more frame because our last one is the first one of the next anim
        skeleton.load_animation(animation, i)
        skeleton.save_tracks(tracks_buffer)
        
    #align with the first frame
    align_animations(skeleton, animation, 0)
    
    #store the animation
    for i in range(1, keycount):
        skeleton.load_animation(animation, i)
        skeleton.save_tracks(tracks_buffer)
          
    #align with the first frame
    align_animations(skeleton, animation, 0)
    
    #store the end
    for i in range(1, WRAP_LENGTH+1):
        skeleton.load_animation(animation, i)
        skeleton.save_tracks(tracks_buffer)
        
        
    skeleton.world = np.array([[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]], dtype=float)
    
    return (len(tracks_buffer[0][1]), tracks_buffer)

def create_non_looping_animation_track(skeleton, animation):
    #assuming an animation that do not loop, we generate an animation with static constant velocity before and after
    tracks_buffer = skeleton.create_tracks_buffer()
    keycount, tracks = animation
    
    skeleton.world = np.array([[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]], dtype=float)
    skeleton.load_animation(animation, 1)
    _, average_a = point_cloud_and_average(skeleton)
    skeleton.load_animation(animation, 0)
    _, average_b = point_cloud_and_average(skeleton)
    average = average_a-average_b
    
    #store frame 0 sliding
    for i in range(WRAP_LENGTH):
        a = average*float(i)
        skeleton.world = np.array([[1,0,0,0],[0,1,0,0],[0,0,1,0],[a[0],a[1],0,1]], dtype=float)
        skeleton.save_tracks(tracks_buffer)
      
    #then store the current animation
    for i in range(0, keycount):
        skeleton.load_animation(animation, i)
        skeleton.save_tracks(tracks_buffer)
    
    #then keep storing the last frame with the slide
    for i in range(1,WRAP_LENGTH+1):
        a = average*float(WRAP_LENGTH+i)
        skeleton.world = np.array([[1,0,0,0],[0,1,0,0],[0,0,1,0],[a[0],a[1],0,1]], dtype=float)
        skeleton.save_tracks(tracks_buffer)
    
    return (len(tracks_buffer[0][1]), tracks_buffer)

def get_extended_cloud(skeleton, animation):
    extended_anim = None
    if is_looping_animation(skeleton, animation):
        extended_anim = create_looping_animation_track(skeleton, animation)
    else:
        extended_anim = create_non_looping_animation_track(skeleton, animation)
    return get_anim_cloud_from_animation(skeleton, extended_anim)



import concurrent.futures

def _future_get_extended_cloud(animation, id):
    my_skel = load_skeleton(_parent_folder_+'\\skeleton.dat')
    return id, get_extended_cloud(my_skel, animation)

if __name__ == '__main__':
    __spec__ = None
    
    animations_data = {'animations':animations, 'clouds':[None]*len(animations)}
    print('start multiprocessors')
    with concurrent.futures.ProcessPoolExecutor() as executor:
        futures = [executor.submit(_future_get_extended_cloud, anim, id) for id, anim in enumerate(animations)]
        for future in concurrent.futures.as_completed(futures):
            data = future.result()
            animations_data['clouds'][data[0]] = data[1]
    print('end multiprocessors')
            
            
            