import maya.api.OpenMaya as OpenMaya

import mtypes as t
from mayamatrix import mayaToMatrix, matrixToMaya


class Skeleton(object):

    class Bone(object):
        def __init__(self, pq, parent, retargetTrScale, retargetTr ):
            self.pq = pq
            self.parent = parent
            self.retargetTrScale = retargetTrScale
            self.retargetTr = retargetTr

    def __init__(self):
        self.bones = []

    def add(self, pq, parent, retargetTrScale, retargetTr):
        self.bones.append(self.__class__.Bone(pq, parent, retargetTrScale, retargetTr))



def create_skeleton_compound(classtype, name):
    mComp = OpenMaya.MFnCompoundAttribute()
    compound = mComp.create(name, name)
    setattr(classtype, name, compound)
    mComp.array = True
    mComp.storable = True
    mComp.writable = True

    mAttr = OpenMaya.MFnMatrixAttribute()
    srcMatrix = mAttr.create( name + "SrcMatrix", name + "SrcMatrix" )
    setattr(classtype, name + "SrcMatrix", srcMatrix)
    mAttr.array = False
    mAttr.storable = True
    mAttr.writable = True

    nAttr = OpenMaya.MFnNumericAttribute()
    boneParent = nAttr.create( name + "BoneParent", name + "BoneParent", OpenMaya.MFnNumericData.kInt, -1 )
    setattr(classtype, name + "BoneParent", boneParent)
    nAttr.array = False
    nAttr.storable = True
    nAttr.writable = True

    nAttr = OpenMaya.MFnNumericAttribute()
    translateScale = nAttr.create( name + "TranslateScale", name + "TranslateScale", OpenMaya.MFnNumericData.kFloat, 0 )
    setattr(classtype, name + "TranslateScale", translateScale)
    nAttr.array = False
    nAttr.storable = True
    nAttr.writable = True

    nAttr = OpenMaya.MFnNumericAttribute()
    targetTranslate = nAttr.create( name + "TargetTranslate", name + "TargetTranslate", OpenMaya.MFnNumericData.k3Float )
    setattr(classtype, name + "TargetTranslate", targetTranslate)
    nAttr.array = False
    nAttr.storable = True
    nAttr.writable = True
    nAttr.keyable = True

    classtype.addAttribute(srcMatrix)
    classtype.addAttribute(boneParent)
    classtype.addAttribute(translateScale)
    classtype.addAttribute(targetTranslate)

    mComp.addChild(srcMatrix)
    mComp.addChild(boneParent)
    mComp.addChild(translateScale)
    mComp.addChild(targetTranslate)

    classtype.addAttribute(compound)

    return compound


def create_skeletons_from_input(classtype, name, dataBlock):
    src = Skeleton()
    dst = Skeleton()

    boneHandleList = dataBlock.inputArrayValue( getattr(classtype, name))
    id = 0
    while boneHandleList.isDone() == False and id < 512:
        dataHandle = boneHandleList.inputValue()

        sm = mayaToMatrix(dataHandle.child(getattr(classtype, name + "SrcMatrix")).asMatrix())
        bp = dataHandle.child(getattr(classtype, name + "BoneParent")).asInt()
        ts = dataHandle.child(getattr(classtype, name + "TranslateScale")).asFloat()
        tt = dataHandle.child(getattr(classtype, name + "TargetTranslate")).asFloat3()

        pqs = t.PosQuat.fromMatrix(sm)
        pqd = t.PosQuat(p=t.Vector(tt), q=pqs.q)

        src.add(pqs, bp, ts, t.Vector(tt))
        dst.add(pqd, bp, ts, t.Vector(tt))
        id += 1
        
        boneHandleList.next()

    return src, dst


def transfer_skeletons(src, dst):
    for s, d in zip(src.bones, dst.bones):
        d.pq.q = s.pq.q.copy()
        if s.retargetTrScale < 0.0001 :
            d.pq.p = d.retargetTr.copy()
        else:
            d.pq.p = s.pq.p.scale(s.retargetTrScale)


def output_skeleton(classtype, name, dataBlock, skl):
    outputs = dataBlock.outputArrayValue( getattr(classtype, name))
    for bone in skl.bones:
        outputs.outputValue().setMMatrix (matrixToMaya(bone.pq.matrix()))
        outputs.next()