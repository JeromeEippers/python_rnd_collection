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
            
    @property
    def world(self):
        return self._bones[0]._matrix

    @world.setter
    def world(self, m):
        self._bones[0]._matrix = m
        
    def bone_children(self, id):
        return [b for b in self._bones if b._parentId == id]
            
    def globalMatrix(self, boneId):
        if self._bones[boneId]._parentId >= 0:
            return np.dot(self._bones[boneId]._matrix, self.globalMatrix(self._bones[boneId]._parentId))
        return self._bones[boneId]._matrix.copy()
    
    def setGlobalMatrix(self, boneId, matrix):
        if self._bones[boneId]._parentId >= 0:
            parent = self.globalMatrix(self._bones[boneId]._parentId)
            self._bones[boneId]._matrix = np.dot(matrix, np.linalg.inv(parent))
        else:
            self._bones[boneId]._matrix = matrix
    
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
                bone._matrix = track[1][frame].copy()
                
    def create_tracks_buffer(self):
        return [(bone._name, []) for bone in self._bones[1:]] #when we do animation we do not animate the world
    
    def save_tracks(self, tracks_buffer):
        #when we save the tracks we save it by baking the world into the first bone
        for track in tracks_buffer:
            name = track[0]
            bone = next((bone for bone in self._bones[1:] if bone._name == name))
            if bone._parentId == 0:
                track[1].append(np.dot(bone._matrix.copy(), self.world))
            else:
                track[1].append(bone._matrix.copy())
                
    def convert_animation_to_local(self, animation):
        buffer = self.create_tracks_buffer()
        keycount, anim_tracks = animation
        
        for track in buffer:
            name = track[0]
            bone = next((bone for bone in self._bones[1:] if bone._name == name), None)
            anim_track = next((anim_track[1] for anim_track in anim_tracks if anim_track[0] == name), None)
            if bone and anim_track:
                inv_matrix = np.linalg.inv(bone._matrix)
                track[1].extend( [np.dot(anim_matrix, inv_matrix) for anim_matrix in anim_track] )
            
            if bone._parentId == 0:
                norm = np.linalg.norm(bone._matrix[3][:3])
                for i in range(keycount):
                    track[1][i][3][:3] = anim_track[i][3][:3] / norm
        
        returnBuffer = [track for track in buffer if len(track[1])==keycount]
        return (keycount, returnBuffer)
    
    def convert_back_local_animation(self, animation):
        buffer = self.create_tracks_buffer()
        keycount, anim_tracks = animation
        
        for track in buffer:
            name = track[0]
            bone = next((bone for bone in self._bones[1:] if bone._name == name), None)
            anim_track = next((anim_track[1] for anim_track in anim_tracks if anim_track[0] == name), None)
            if bone and anim_track:
                track[1].extend( [np.dot(anim_matrix, bone._matrix) for anim_matrix in anim_track] )
                
            if bone._parentId == 0:
                norm = np.linalg.norm(bone._matrix[3][:3])
                for i in range(keycount):
                    track[1][i][3][:3] = anim_track[i][3][:3] * norm
                
        returnBuffer = [track for track in buffer if len(track[1])==keycount]
        return (keycount, returnBuffer)
    
    def adapt_bone_lengths(self, other, ratio):
        for src, dst in zip(other._bones[2:]+other._anchors, self._bones[2:]+self._anchors):
            selfLen = np.linalg.norm(dst._matrix[3][:3])
            otherLen = np.linalg.norm(src._matrix[3][:3])
            if selfLen > 0.001:
                dst._matrix[3][:3] *= (ratio*otherLen + (1.0-ratio)*selfLen)/selfLen
                    
                
    
            
    
    
def load_skeleton(path):
    skeleton = pickle.load(open(path,'rb'))
    skeleton.convert_to_np()
    #reset world to identity
    skeleton.world = np.array([[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]], dtype=float)
    return skeleton