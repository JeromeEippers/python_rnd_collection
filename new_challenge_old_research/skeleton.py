import numpy as np
import pickle

class DataBone(object):
    
    def __init__(self, id, parentId, name, matrix):
        self._id = id
        self._parentId = parentId
        self._name = name
        self._matrix = matrix
        
    def __repr__(self):
        return "bone:{} name:{} parent:{}".format(self._id, self._name, self._parentId )
        
class DataSkeleton(object):
    
    def __init__(self):
        self._bones = []
        
    def convert_to_np(self):
        for bone in self._bones:
            bone._matrix = np.array([
                bone._matrix[0:4],
                bone._matrix[4:8],
                bone._matrix[8:12],
                bone._matrix[12:16]])
            
    def globalMatrix(self, boneId):
        if self._bones[boneId]._parentId >= 0:
            return np.dot(self._bones[boneId]._matrix, self.globalMatrix(self._bones[boneId]._parentId))
        return self._bones[boneId]._matrix.copy()
    
    def load_animation(self, animation, frame):
        keycount, tracks = animation
        for track in tracks:
            name = track[0]
            bone = next((bone for bone in self._bones if bone._name == name),None)
            if bone:
                bone._matrix = track[1][frame]
    
    
def load_skeleton(path):
    skeleton = pickle.load(open(path,'rb'))
    skeleton.convert_to_np()
    return skeleton