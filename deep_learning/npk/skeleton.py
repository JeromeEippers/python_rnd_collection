import numpy as np


class Bone(object):
    def __init__(self, name, parent=-1):
        self.name = name
        self.parent = parent
        self.children = []


class Skeleton(object):
    def __init__(self):
        self.bones = []
        self.bindpose = np.zeros([512, 4, 4])
        self.initialpose = np.zeros([512, 4, 4])

    def globalpose(self, localpose):
        count = len(self.bones)
        pose = np.zeros([count, 4, 4])
        for i in range(count):
            if self.bones[i].parent > -1:
                pose[i, :, :] = np.dot(localpose[i, :, :], pose[self.bones[i].parent, :, :])
            else:
                pose[i, :, :] = localpose[i, :, :]
        return pose

    def boneid(self, name):
        for i in range(len(self.bones)):
            if self.bones[i].name == name:
                return i
        return -1
