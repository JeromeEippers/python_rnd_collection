import maya.api.OpenMaya as OpenMaya

import mtypes as t
from mayamatrix import mayaToMatrix, matrixToMaya


class Primitive(object):

    def __init__(self, boneParent):
        self.boneParent = boneParent
        self.capsules = []

    def addCapsule(self, capsule):
        self.capsules.append(capsule)

    def __repr__(self):
        return """Primitive(
            boneParent={}, 
            capsules=[{}]
        )""".format(self.boneParent, ', \n'.join([str(x) for x in self.capsules]))



def create_primitives_compound(classtype, name):

    mComp = OpenMaya.MFnCompoundAttribute()
    compound = mComp.create(name, name)
    setattr(classtype, name, compound)
    mComp.array = True
    mComp.storable = True
    mComp.writable = True

    mCompC = OpenMaya.MFnCompoundAttribute()
    capsule = mCompC.create(name+"Capsule", name+"Capsule")
    setattr(classtype, name+"Capsule", capsule)
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


def create_primitives_from_input(classtype, name, dataBlock):
    primitives = []

    primitivesHandle = dataBlock.inputArrayValue( getattr(classtype, name))
    while primitivesHandle.isDone() == False:

        primitiveHandle = primitivesHandle.inputValue()

        boneParent = primitiveHandle.child(getattr(classtype, name + "BoneParent")).asInt()
        primitive = Primitive(boneParent)
        primitives.append(primitive)

        capsulesHandle = OpenMaya.MArrayDataHandle( primitiveHandle.child(getattr(classtype, name + "Capsule")) )

        while capsulesHandle.isDone() == False:
            capsuleHandle = capsulesHandle.inputValue()

            matrix = mayaToMatrix(capsuleHandle.child(getattr(classtype, name + "CapsuleMatrix")).asMatrix())
            radius = capsuleHandle.child(getattr(classtype, name + "CapsuleRadius")).asDouble()
            height = capsuleHandle.child(getattr(classtype, name + "CapsuleHeight")).asDouble()

            capsulesHandle.next()

            primitive.addCapsule( t.Capsule(
                t.PosQuat.fromMatrix(matrix),
                radius,
                height
            ))
            

        primitivesHandle.next()

    return primitives