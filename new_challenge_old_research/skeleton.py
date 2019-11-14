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
        self._anchors = []
        self._world_matrix = np.array([[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]], dtype=float)
        
    def convert_to_np(self):
        for bone in self._bones:
            bone._matrix = np.array([
                bone._matrix[0:4],
                bone._matrix[4:8],
                bone._matrix[8:12],
                bone._matrix[12:16]])
            bone._matrix[3] *= np.array([0.01,0.01,0.01,1])
        for bone in self._anchors:
            bone._matrix = np.array([
                bone._matrix[0:4],
                bone._matrix[4:8],
                bone._matrix[8:12],
                bone._matrix[12:16]])
            bone._matrix[3] *= np.array([0.01,0.01,0.01,1])
            
    def globalMatrix(self, boneId):
        if self._bones[boneId]._parentId >= 0:
            return np.dot(self._bones[boneId]._matrix, self.globalMatrix(self._bones[boneId]._parentId))
        return np.dot(self._bones[boneId]._matrix, self._world_matrix)
    
    def anchorGlobalPosition(self, anchorId):
        return np.dot(self._anchors[anchorId]._matrix, self.globalMatrix(self._anchors[anchorId]._parentId))[3][:3]
    
    def bone_id(self, name):
        return next((b._id for b in self._bones if b._name == name),0)
    
    def load_animation(self, animation, frame):
        keycount, tracks = animation
        for track in tracks:
            name = track[0]
            bone = next((bone for bone in self._bones if bone._name == name),None)
            if bone:
                bone._matrix = track[1][frame]
                
    def create_tracks_buffer(self):
        return [(bone._name, []) for bone in self._bones]
    
    def save_tracks(self, tracks_buffer):
        for track in tracks_buffer:
            name = track[0]
            bone = next((bone for bone in self._bones if bone._name == name))
            if bone._parentId >= 0:
                track[1].append(bone._matrix)
            else:
                track[1].append(np.dot(bone._matrix, self._world_matrix))
            
    
    
def load_skeleton(path):
    skeleton = pickle.load(open(path,'rb'))
    skeleton.convert_to_np()
    #inject the world matrix, because pickle seems to lose it (was not part of the pickle data)
    skeleton._world_matrix = np.array([[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]], dtype=float)
    return skeleton