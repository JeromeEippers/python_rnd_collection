import sys
import numpy as np
from skeleton import Skeleton, Bone

fbxsdkpath = r'D:\Software\fbx_python37_x64'
if fbxsdkpath not in sys.path:
    sys.path.append(fbxsdkpath)

import FbxCommon as fb
import fbx


def find_mesh_node(pScene):
    def _get_mesh(pNode):
        if isinstance(pNode.GetNodeAttribute(), fbx.FbxMesh):
            return pNode
        for i in range(pNode.GetChildCount()):
            ret = _get_mesh(pNode.GetChild(i))
            if ret:
                return ret

    node = _get_mesh(pScene.GetRootNode())
    if node :
        return node
    return None


def read_vertices_buffer(lMeshNode):
    lMesh = lMeshNode.GetNodeAttribute()
    lControlPointsCount = lMesh.GetControlPointsCount()
    lControlPoints = lMesh.GetControlPoints()

    m = lMeshNode.EvaluateGlobalTransform()

    # 3pos, 3normal
    vertexstride = 6
    vertices = np.zeros((lControlPointsCount, vertexstride), dtype=np.float32)

    for i in range(lControlPointsCount):
        # get positions
        vertices[i, :3] = list(m.MultT(lControlPoints[i]))[:3]

        # get normals
        for j in range(lMesh.GetLayerCount()):
            leNormals = lMesh.GetLayer(j).GetNormals()
            if leNormals:
                if leNormals.GetMappingMode() == fbx.FbxLayerElement.eByControlPoint:
                    if leNormals.GetReferenceMode() == fbx.FbxLayerElement.eDirect:
                        vertices[i, 3:6] = list(m.MultT(leNormals.GetDirectArray().GetAt(i)))[:3]

    return vertices


def read_index_buffer(lMeshNode):
    lMesh = lMeshNode.GetNodeAttribute()
    lPolygonCount = lMesh.GetPolygonCount()
    faces = np.zeros(lPolygonCount * 10, dtype=np.int)

    arrayid = 0
    for i in range(lPolygonCount):
        lPolygonSize = lMesh.GetPolygonSize(i)

        # retriangulate
        for j in range(2, lPolygonSize):
            faces[arrayid] = lMesh.GetPolygonVertex(i, j - 2)
            arrayid += 1
            faces[arrayid] = lMesh.GetPolygonVertex(i, j - 1)
            arrayid += 1
            faces[arrayid] = lMesh.GetPolygonVertex(i, j)
            arrayid += 1
    return faces[:arrayid]


def read_skeleton(pScene):
    skeleton = Skeleton()

    def _skel(pNode, pParent):

        bone = Bone(pNode.GetName(), pParent)
        if pParent > -1:
            skeleton.bones[pParent].children.append(bone)
        skeleton.bones.append(bone)
        boneid = len(skeleton.bones) - 1

        m = pNode.EvaluateGlobalTransform()
        for i in range(4):
            for j in range(4):
                skeleton.bindpose[boneid, i, j] = m.Get(i, j)
                skeleton.initialpose[boneid, i, j] = m.Get(i, j)

        for i in range(pNode.GetChildCount()):
            childnode = pNode.GetChild(i)
            if isinstance(childnode.GetNodeAttribute(), fbx.FbxMesh) == False:
                _skel(childnode, boneid)

    lRootNode = pScene.GetRootNode()
    _skel(lRootNode.GetChild(0), -1)

    skeleton.bindpose = skeleton.bindpose[:len(skeleton.bones), :, :]
    skeleton.initialpose = skeleton.initialpose[:len(skeleton.bones), :, :]

    return skeleton


def read_bindpose(lMeshNode, skeleton):
    lMesh = lMeshNode.GetNodeAttribute()
    skin = lMesh.GetDeformer(0,fbx.FbxDeformer.eSkin)
    clustercount = skin.GetClusterCount()

    for clusterid in range(clustercount):
        cluster = skin.GetCluster(clusterid)
        linkedNode = cluster.GetLink()

        boneid = skeleton.boneid(linkedNode.GetName())
        if boneid < 0:
            raise Exception('bone {} not found in skeleton'.format(linkedNode.GetName()))

        m = fbx.FbxAMatrix()
        m = cluster.GetTransformLinkMatrix(m)
        m = m.Inverse()
        for i in range(4):
            for j in range(4):
                skeleton.bindpose[boneid,i,j] = m.Get(i,j)


def read_skinning(lMeshNode, skeleton):
    lMesh = lMeshNode.GetNodeAttribute()
    lControlPointsCount = lMesh.GetControlPointsCount()
    weights = np.zeros([lControlPointsCount, 8])
    indices = np.zeros([lControlPointsCount, 8], dtype=np.int32)
    counts = np.zeros([lControlPointsCount], dtype=np.int32)

    skin = lMesh.GetDeformer(0, fbx.FbxDeformer.eSkin)
    clustercount = skin.GetClusterCount()

    for clusterid in range(clustercount):
        cluster = skin.GetCluster(clusterid)
        linkedNode = cluster.GetLink()

        boneid = skeleton.boneid(linkedNode.GetName())
        if boneid < 0:
            raise Exception('bone {} not found in skeleton'.format(linkedNode.GetName()))

        vertcount = cluster.GetControlPointIndicesCount()
        for k in range(vertcount):
            vertindex = cluster.GetControlPointIndices()[k]
            index = counts[vertindex]
            indices[vertindex, index] = boneid
            weights[vertindex, index] = cluster.GetControlPointWeights()[k]
            counts[vertindex] += 1


    ind = np.argsort(weights)[:,-4:]
    normalizeweights = np.zeros([lControlPointsCount, 4])
    normalizeindices = np.zeros([lControlPointsCount, 4], dtype=np.int32)

    for i in range(lControlPointsCount):
        normalizeweights[i,:] = weights[i,ind[i]]
        normalizeweights[i, :] /= np.sum(normalizeweights[i, :])
        normalizeindices[i, :] = indices[i, ind[i]]

    return normalizeindices, normalizeweights


def read_animations(pScene, skeleton):
    animations = {}
    time = fbx.FbxTime()
    lRootNode = pScene.GetRootNode()

    mapping = {bone.name:lRootNode.FindChild(bone.name,True,True) for bone in skeleton.bones }

    for i in range(pScene.GetSrcObjectCount(fbx.FbxCriteria.ObjectType(fbx.FbxAnimStack.ClassId))):
        lAnimStack = pScene.GetSrcObject(fbx.FbxCriteria.ObjectType(fbx.FbxAnimStack.ClassId), i)

        pScene.SetCurrentAnimationStack(lAnimStack)

        start = lAnimStack.LocalStart.Get()
        stop = lAnimStack.LocalStop.Get()
        name = lAnimStack.GetName()

        animlen = stop.GetFrameCount() - start.GetFrameCount() + 1
        bonelen = len(skeleton.bones)
        animation = np.repeat(skeleton.initialpose[np.newaxis,...], animlen, axis=0)

        for frame in range(start.GetFrameCount(), stop.GetFrameCount() + 1):
            animframe = frame - start.GetFrameCount()
            time.SetFrame(frame)
            for boneid in range(bonelen):
                bone = skeleton.bones[boneid]
                if bone.name in mapping and mapping[bone.name] is not None:
                    localMatrix = mapping[bone.name].EvaluateGlobalTransform(time)
                    for i in range(4):
                        for j in range(4):
                            animation[animframe, boneid, i, j] = localMatrix.Get(i, j)

        animations[name] = animation
    return animations


class FbxReader(object):

    def __init__(self, path):
        lSdkManager, lScene = fb.InitializeSdkObjects()
        status = fb.LoadScene(lSdkManager, lScene, path)
        if not status:
            raise Exception('error in fbx file')

        self._scene = lScene
        self._mesh = find_mesh_node(self._scene)
        self._vertices = None
        self._indices = None
        self._skinning = None
        self._skeleton = None
        self._animations = None

    def vertices_and_indices(self):
        if self._mesh:
            if self._vertices is None:
                self._vertices = read_vertices_buffer(self._mesh)
            if self._indices is None:
                self._indices = read_index_buffer(self._mesh)
            return self._vertices, self._indices
        raise Exception('no mesh')

    def skeleton(self):
        if self._skeleton is None:
            self._skeleton = read_skeleton(self._scene)
            if self._mesh:
                read_bindpose(self._mesh, self._skeleton)
        return self._skeleton

    def skinning_indices_weights(self):
        if self._mesh:
            if self._skinning is None:
                self._skinning = read_skinning(self._mesh, self.skeleton())
            return self._skinning
        raise Exception('no mesh')

    def animation_dictionary(self, skeleton=None):
        if self._animations is None:
            if skeleton is None:
                skeleton = self.skeleton()
            self._animations = read_animations(self._scene, skeleton)
        return self._animations
