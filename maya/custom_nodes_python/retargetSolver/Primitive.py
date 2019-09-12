import maya.api.OpenMaya as OpenMaya

import mtypes as t
from mayamatrix import mayaToMatrix, matrixToMaya


class Primitive(object):

    def __init__(self, boneParent):
        self.boneParent = boneParent
        self.capsules = []

    def addCapsule(self, capsule):
        self.capsules.append(capsule)



def create_primitives_compound(classtype, name):

    mComp = OpenMaya.MFnCompoundAttribute()
    compound = mComp.create(name, name)
    setattr(classtype, name, compound)
    mComp.array = True
    mComp.storable = True
    mComp.writable = True

    mCompC = OpenMaya.MFnCompoundAttribute()
    capsule = mCompC.create(name+"Capsule", name+"Capsule")
    setattr(classtype, name, capsule)
    mCompC.array = True
    mCompC.storable = True
    mCompC.writable = True

    mAttr = OpenMaya.MFnMatrixAttribute()
    capsulematrix = mAttr.create( name + "CapsuleMatrix", name + "CapsuleMatrix" )
    setattr(classtype, name + "CapsuleMatrix", capsulematrix)
    mAttr.array = False
    mAttr.storable = True
    mAttr.writable = True

    nAttr = OpenMaya.MFnNumericAttribute()
    capsuleradius = nAttr.create( name + "CapsuleRadius", name + "CapsuleRadius", OpenMaya.MFnNumericData.kDouble, 0.5 )
    setattr(classtype, name + "CapsuleRadius", capsuleradius)
    nAttr.array = False
    nAttr.storable = True
    nAttr.writable = True

    nAttr = OpenMaya.MFnNumericAttribute()
    capsuleheight = nAttr.create( name + "CapsuleHeight", name + "CapsuleHeight", OpenMaya.MFnNumericData.kDouble, 1.0 )
    setattr(classtype, name + "CapsuleHeight", capsuleheight)
    nAttr.array = False
    nAttr.storable = True
    nAttr.writable = True

    classtype.addAttribute(capsulematrix)
    classtype.addAttribute(capsuleradius)
    classtype.addAttribute(capsuleheight)

    mCompC.addChild(capsulematrix)
    mCompC.addChild(capsuleradius)
    mCompC.addChild(capsuleheight)

    classtype.addAttribute(capsule)

    nAttr = OpenMaya.MFnNumericAttribute()
    boneParent = nAttr.create( name + "BoneParent", name + "BoneParent", OpenMaya.MFnNumericData.kInt, -1 )
    setattr(classtype, name + "BoneParent", boneParent)
    nAttr.array = False
    nAttr.storable = True
    nAttr.writable = True

    classtype.addAttribute(boneParent)

    mComp.addChild(capsule)
    mComp.addChild(boneParent)

    classtype.addAttribute(compound)

    return compound