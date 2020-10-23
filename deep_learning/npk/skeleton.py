import numpy as np
import copy
import posquat as pq


class Bone(object):
    def __init__(self, name, parent=-1):
        self.name = name
        self.parent = parent
        self.children = []


class Skeleton(object):
    def __init__(self):
        self.bones = []
        self.parentlist = []
        self.bindpose = np.zeros([512, 4, 4])
        self.initialpose = np.zeros([512, 4, 4])
        self.upleglength = 0
        self.leglength = 0
        self.hipsid = 0
        self.leftlegids = [0,0,0]
        self.rightlegids = [0, 0, 0]

    def local_to_global(self, localpose):
        count = len(self.bones)
        pos, quat = localpose

        gpos = np.zeros_like(pos)
        gquat = np.zeros_like(quat)

        # root is not converted
        gpos[..., 0, :] = pos[..., 0, :]
        gquat[..., 0, :] = quat[..., 0, :]

        for i in range(1, count):
            gpos[..., i, :], gquat[..., i, :] = pq.mult(
                (pos[..., i, :], quat[..., i, :]),
                (gpos[..., self.parentlist[i], :], gquat[..., self.parentlist[i], :])
            )
        return gpos, gquat

    def global_to_local(self, globalpose):
        """compute a global pose or global animation out of a local pose"""
        gpos, gquat = globalpose
        ipose, iquat = pq.inv(None, gpos, gquat)

        pos = np.zeros_like(gpos)
        quat = np.zeros_like(gquat)

        #root is not converted
        pos[..., 0, :] = gpos[..., 0, :]
        quat[..., 0, :] = gquat[..., 0, :]

        #multiply by the inverse parent
        pos[..., 1:, :], quat[..., 1:, :] = pq.mult(
            (gpos[..., 1:, :], gquat[..., 1:, :]),
            (ipose[..., self.parentlist[1:], :], iquat[..., self.parentlist[1:], :])
        )
        return pos, quat

    def foot_ik(self, localpose, hips, leftfoot, rightfoot):
        raise NotImplemented()
        # this is still assuming matrix pose and one pose at a time

        pose = copy.deepcopy(localpose)
        pose[self.hipsid, :, :] = np.dot(hips, np.linalg.inv(localpose[0, :, :]))  # always direct child of root (root is always global)

        def _compute_leg(legIds, start_effector, end_effector):
            middle = ((end_effector[3, :3] - start_effector[3, :3])/(self.upleglength + self.leglength)) * self.upleglength
            middle_len = np.linalg.norm(middle)
            up_len = 0.0
            if middle_len < self.upleglength:
                up_len = np.sqrt(self.upleglength*self.upleglength - middle_len*middle_len)
            up_pos = start_effector[3, :3] + middle + start_effector[1, :3] * up_len

            start = np.eye(4)
            start[0, :3] = up_pos - start_effector[3, :3]
            start[0, :3] /= np.linalg.norm(start[0, :3])
            start[2, :3] = np.cross(start[0, :3], start_effector[1, :3])
            start[2, :3] /= np.linalg.norm(start[2, :3])
            start[1, :3] = np.cross(start[2, :3], start[0, :3])
            start[1, :3] /= np.linalg.norm(start[1, :3])
            start[3, :3] = start_effector[3, :3]

            middle = np.eye(4)
            middle[0, :3] = end_effector[3, :3] - up_pos
            middle[0, :3] /= np.linalg.norm(middle[0, :3])
            middle[2, :3] = np.cross(middle[0, :3], start_effector[1, :3])
            middle[2, :3] /= np.linalg.norm(middle[2, :3])
            middle[1, :3] = np.cross(middle[2, :3], middle[0, :3])
            middle[1, :3] /= np.linalg.norm(middle[1, :3])
            middle[3, :3] = up_pos

            return start, middle

        #globalposes
        leftUpLeg = np.dot(localpose[self.leftlegids[0], :, :], hips)
        leftUpLeg, leftLeg = _compute_leg(self.leftlegids, leftUpLeg, leftfoot)
        #localposes
        pose[self.leftlegids[2], :, :] = np.dot(leftfoot, np.linalg.inv(leftLeg))
        pose[self.leftlegids[1], :, :] = np.dot(leftLeg, np.linalg.inv(leftUpLeg))
        pose[self.leftlegids[0], :, :] = np.dot(leftUpLeg, np.linalg.inv(hips))

        # globalposes
        rightUpLeg = np.dot(localpose[self.rightlegids[0], :, :], hips)
        rightUpLeg, rightLeg = _compute_leg(self.rightlegids, rightUpLeg, rightfoot)
        # localposes
        pose[self.rightlegids[2], :, :] = np.dot(rightfoot, np.linalg.inv(rightLeg))
        pose[self.rightlegids[1], :, :] = np.dot(rightLeg, np.linalg.inv(rightUpLeg))
        pose[self.rightlegids[0], :, :] = np.dot(rightUpLeg, np.linalg.inv(hips))

        return pose

    def boneid(self, name):
        for i in range(len(self.bones)):
            if self.bones[i].name == name:
                return i
        return -1
