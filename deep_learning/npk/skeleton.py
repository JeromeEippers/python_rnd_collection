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
        self.localinitialpq = None
        self.upleglength = 0
        self.leglength = 0

        self.hipsid = 0
        self.leftlegids = [0, 0, 0]
        self.rightlegids = [0, 0, 0]
        self.leftfootid = 0
        self.rightfootid = 0
        self.copid = 0

    def local_to_global(self, localpose, extra_root=None):
        count = len(self.bones)
        pos, quat = localpose

        gpos = np.zeros_like(pos)
        gquat = np.zeros_like(quat)

        if extra_root is None:
            # root is not converted
            gpos[..., 0, :] = pos[..., 0, :]
            gquat[..., 0, :] = quat[..., 0, :]
        else:
            gpos[..., 0, :], gquat[..., 0, :] = pq.mult(
                (pos[..., 0, :], quat[..., 0, :]),
                extra_root
            )

        for i in range(1, count):
            gpos[..., i, :], gquat[..., i, :] = pq.mult(
                (pos[..., i, :], quat[..., i, :]),
                (gpos[..., self.parentlist[i], :], gquat[..., self.parentlist[i], :])
            )
        return gpos, pq.vec_normalize(gquat)

    def global_to_local(self, globalpose, extra_root=None):
        """compute a global pose or global animation out of a local pose"""
        gpos, gquat = globalpose
        ipose, iquat = pq.inv(None, gpos, gquat)

        pos = np.zeros_like(gpos)
        quat = np.zeros_like(gquat)

        if extra_root is None:
            # root is not converted
            pos[..., 0, :] = gpos[..., 0, :]
            quat[..., 0, :] = gquat[..., 0, :]
        else:
            pos[..., 0, :], quat[..., 0, :] = pq.mult(
                (gpos[..., 0, :], gquat[..., 0, :]),
                pq.inv(extra_root)
            )

        # multiply by the inverse parent
        pos[..., 1:, :], quat[..., 1:, :] = pq.mult(
            (gpos[..., 1:, :], gquat[..., 1:, :]),
            (ipose[..., self.parentlist[1:], :], iquat[..., self.parentlist[1:], :])
        )

        #remap lengths
        if self.localinitialpq != None:
            #pos[..., 1:, :] = self.localinitialpq[0][1:, :]
            pass

        return pos, pq.vec_normalize(quat)

    def foot_ik(self, hips, leftfoot, rightfoot, globalpose=None):

        pos_augmentation = np.ones_like(hips[0][..., 0, 0, np.newaxis].repeat(3, axis=-1))
        quat_augmentation = np.ones_like(hips[1][..., 0, 0, np.newaxis].repeat(4, axis=-1))

        y_vectors = np.array([0, 1, 0]) * pos_augmentation

        if globalpose is None:
            gpos, gquat = pq.pose_to_pq(self.initialpose)
            gpos = gpos * pos_augmentation
            gquat = gquat * quat_augmentation
            globalpose = (gpos, gquat)

        localpose = self.global_to_local(globalpose)

        gpos, gquat = globalpose
        lpos, lquat = localpose

        # set the hips in local were we want it (hips is always child of root)
        lpos[..., self.hipsid, :], lquat[..., self.hipsid, :] = \
            pq.mult(hips, pq.inv(positions=gpos[..., 0, :], quaternions=gquat[..., 0, :]))

        # recompute globals
        gpos, gquat = self.local_to_global((lpos, lquat))

        def _compute_max_length(start_pos, end_pos):
            middle = end_pos - start_pos
            return np.sqrt(np.max(np.sum(middle * middle, axis=-1, keepdims=True)))

        def _compute_leg(start_pos, end_pos, pole_dir):
            middle = ((end_pos - start_pos)/(self.upleglength + self.leglength)) * self.upleglength
            middle_len = np.sum(middle * middle, axis=-1, keepdims=True)
            up_len = np.zeros_like(middle_len)
            sqrt_up_length = self.upleglength * self.upleglength
            up_len = np.where(middle_len < sqrt_up_length, np.sqrt(sqrt_up_length - middle_len), up_len)
            up_pos = start_pos + middle + pole_dir * up_len

            start_quat = pq.quat_from_lookat(up_pos - start_pos, pole_dir)
            middle_quat = pq.quat_from_lookat(end_pos - up_pos, pole_dir)

            return start_quat, middle_quat, up_pos

        # check if we will be in over stretch
        lmax = _compute_max_length(gpos[..., self.leftlegids[0], :], leftfoot[0])
        lmax = max(lmax, _compute_max_length(gpos[..., self.rightlegids[0], :], rightfoot[0]))
        if lmax > self.leglength + self.upleglength:
            # TODO lower the hips in the direction of the middle between both legs
            raise Exception()

        # compute legs
        start_quat, middle_quat, middle_pos = _compute_leg(
            gpos[..., self.leftlegids[0], :],
            leftfoot[0],
            pq.quat_mul_vec(gquat[..., self.leftlegids[0], :], y_vectors)
        )
        gquat[..., self.leftlegids[0], :] = start_quat
        gquat[..., self.leftlegids[1], :] = middle_quat
        gpos[..., self.leftlegids[1], :] = middle_pos
        gpos[..., self.leftlegids[2], :] = leftfoot[0]
        gquat[..., self.leftlegids[2], :] = leftfoot[1]
        gpos[..., self.leftlegids[2]+1, :], gquat[..., self.leftlegids[2]+1, :] = pq.mult(
            (lpos[..., self.leftlegids[2] + 1, :], lquat[..., self.leftlegids[2] + 1, :]),
            (gpos[..., self.leftlegids[2], :], gquat[..., self.leftlegids[2], :])
        )

        start_quat, middle_quat, middle_pos = _compute_leg(
            gpos[..., self.rightlegids[0], :],
            rightfoot[0],
            pq.quat_mul_vec(gquat[..., self.rightlegids[0], :], y_vectors)
        )
        gquat[..., self.rightlegids[0], :] = start_quat
        gquat[..., self.rightlegids[1], :] = middle_quat
        gpos[..., self.rightlegids[1], :] = middle_pos
        gpos[..., self.rightlegids[2], :] = rightfoot[0]
        gquat[..., self.rightlegids[2], :] = rightfoot[1]
        gpos[..., self.rightlegids[2] + 1, :], gquat[..., self.rightlegids[2] + 1, :] = pq.mult(
            (lpos[..., self.rightlegids[2] + 1, :], lquat[..., self.rightlegids[2] + 1, :]),
            (gpos[..., self.rightlegids[2], :], gquat[..., self.rightlegids[2], :])
        )

        return gpos, gquat

    def boneid(self, name):
        for i in range(len(self.bones)):
            if self.bones[i].name == name:
                return i
        return -1
