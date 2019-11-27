import os
import sys

import numpy as np
from scipy.optimize import minimize

WRAP_LENGTH = 10

_this_folder_ = '\\'.join(__file__.split('\\')[:-1])
_parent_folder_ = '\\'.join(__file__.split('\\')[:-2])
if _parent_folder_ not in sys.path:
    sys.path.append(_parent_folder_)
  

from animation import *


#reload the clouds and animation data
import pickle
animations_data = pickle.load(open(_this_folder_+'\\all_animations_and_clouds.dat','rb'))


def rotate_cloud(cloud, theta):
    c, s = np.cos(theta), np.sin(theta)
    M = np.array([[c,-s,0],[s,c,0],[0,0,1]])
    return cloud.dot(M)

def align_cloud(cloud, x,y,t):
    cloud = rotate_cloud(cloud, t)
    return cloud + np.array([x,y,0])

def compute_errors_between_2_animations(anim_a, clouds_and_averages_a, anim_b, clouds_and_averages_b):
    WRAP_OFFSET = 9
    
    keycount_a, _ = anim_a
    keycount_b, _ = anim_b
   
        
    def _objective(xyt, cloud_a, cloud_b, weights):
        cloud = align_cloud(cloud_b, *xyt)
        v = cloud_a - cloud
        sqr = np.sum(v*v, axis=1)
        return np.sum(sqr * weights) * 0.5
    
    def _concat(arg, arg2):
        a = np.concatenate((arg[0],arg2[0]), axis=0)
        b = np.concatenate((arg[1],arg2[1]), axis=0)
        w = np.concatenate((arg[2],arg2[2]))
        return (a,b,w)
    
    def _build_lists(frame_a, frame_b, weight):
        a = clouds_and_averages_a[0][frame_a]
        b = clouds_and_averages_b[0][frame_b]
        w = np.array([weight]*a.shape[0])
        return (a,b,w)
    
    errors = []
    for frame_a in range(WRAP_OFFSET, keycount_a+WRAP_OFFSET):
        errors.append([])
        for frame_b in range(WRAP_OFFSET, keycount_b+WRAP_OFFSET):
               
            arg = _build_lists(frame_a, frame_b, 1.0)
            
            arg2 = _build_lists(frame_a-1, frame_b-1, 0.8)
            arg = _concat(arg2, arg)
                
            arg2 = _build_lists(frame_a-2, frame_b-2, 0.5)
            arg = _concat(arg2, arg)
                
            arg2 = _build_lists(frame_a-3, frame_b-3, 0.3)
            arg = _concat(arg2, arg)
                
            arg2 = _build_lists(frame_a+1, frame_b+1, 0.8)
            arg = _concat(arg, arg2)
                
            arg2 = _build_lists(frame_a+2, frame_b+2, 0.5)
            arg = _concat(arg, arg2)
                
            arg2 = _build_lists(frame_a+3, frame_b+3, 0.3)
            arg = _concat(arg, arg2)
            
            #remove the averages to make it reach easier
            a,b,w = arg
            a -= clouds_and_averages_a[1][frame_a]
            b -= clouds_and_averages_b[1][frame_b]
            arg = (a,b,w)

            #solve, and make sure we can find a good solution
            inputs = [0,0,0]
            for iteration in range(10):
                sol = minimize(_objective, inputs, method='SLSQP', args=arg)
                if sol.success:
                    break
                inputs = sol.x
            errors[frame_a-WRAP_OFFSET].append(sol.fun)
        
    return np.array(errors)

import concurrent.futures

def _future_compute_errors_between_2_animations(anim_a, clouds_and_averages_a, anim_b, clouds_and_averages_b, id_a, id_b):
    return id_a, id_b, compute_errors_between_2_animations(anim_a, clouds_and_averages_a, anim_b, clouds_and_averages_b)

if __name__ == '__main__':
    __spec__ = None
    
    count = len(animations_data['animations'])
    errors_data = {'errors':[], 'accessor':np.array([[-1]*count for i in range(count)])}
    
    print('start multiprocessors')
    with concurrent.futures.ProcessPoolExecutor() as executor:
        futures = []
        for i in range(count):
            for j in range(i, count):
                futures.append(
                    executor.submit(
                        _future_compute_errors_between_2_animations, 
                        animations_data['animations'][i],
                        animations_data['clouds'][i],
                        animations_data['animations'][j],
                        animations_data['clouds'][j], 
                        i,j))

        for future in concurrent.futures.as_completed(futures):
            i,j,error = future.result()
            errors_data['errors'].append(error)
            errors_data['accessor'][i][j] = len(errors_data['errors'])-1
            
            if i!=j:
                errors_data['errors'].append(error.T)
                errors_data['accessor'][j][i] = len(errors_data['errors'])-1
            
    print('end multiprocessors')