import maya.api.OpenMaya as OpenMaya

import mtypes as t
import CapsuleLink as CL

class PrimitiveLink(object):

    def __init__(self, primitiveIdA, capsuleIdA, primitiveIdB, capsuleIdB, weight, ABRatio, AOrientationRatio):
        self.primitiveIdA = primitiveIdA
        self.capsuleIdA = capsuleIdA
        self.primitiveIdB = primitiveIdB
        self.capsuleIdB = capsuleIdB
        self.weight = weight
        self.ABRatio = ABRatio
        self.AOrientationRatio = AOrientationRatio
        self.link = None

    def __repr__(self):
        return """PrimitiveLink(
            primitiveIdA={}, 
            capsuleIdA={}, 
            primitiveIdB={},
            capsuleIdB={},
            weight={},
            ABRatio={},
            AOrientationRatio={},
            link={}
        )""".format(self.primitiveIdA, self.capsuleIdA, self.primitiveIdB, self.capsuleIdB, self.weight, self.ABRatio, self.AOrientationRatio, self.link)


    def gather(self, primitives, skeleton):
        primitiveA = primitives[self.primitiveIdA]
        primitiveB = primitives[self.primitiveIdB]
        capsuleA = primitiveA.capsules[self.capsuleIdA].copy()
        capsuleB = primitiveB.capsules[self.capsuleIdB].copy()
        capsuleA.pq = skeleton.globalPq(primitiveA.boneParent) * capsuleA.pq
        capsuleB.pq = skeleton.globalPq(primitiveB.boneParent) * capsuleB.pq

        self.link = CL.CapsuleLink.gather(capsuleA, capsuleB)



    def solve(self, primitives, skeleton):
        primitiveA = primitives[self.primitiveIdA]
        primitiveB = primitives[self.primitiveIdB]
        capsuleA = primitiveA.capsules[self.capsuleIdA].copy()
        capsuleB = primitiveB.capsules[self.capsuleIdB].copy()
        capsuleA.pq = skeleton.globalPq(primitiveA.boneParent) * capsuleA.pq
        capsuleB.pq = skeleton.globalPq(primitiveB.boneParent) * capsuleB.pq

        resultA, resultB = self.link.solve(capsuleA, capsuleB, self.weight, self.ABRatio, self.AOrientationRatio)

        return (
            resultA * primitiveA.capsules[self.capsuleIdA].pq.inverse(),
            resultB * primitiveB.capsules[self.capsuleIdB].pq.inverse()
        )


def create_primitive_links_compound(classtype, name):

    mComp = OpenMaya.MFnCompoundAttribute()
    compound = mComp.create(name, name)
    setattr(classtype, name, compound)
    mComp.array = True
    mComp.storable = True
    mComp.writable = True

    nAttr = OpenMaya.MFnNumericAttribute()
    primitiveA = nAttr.create( name + "PrimitiveA", name + "PrimitiveA", OpenMaya.MFnNumericData.kInt, 0 )
    setattr(classtype, name + "PrimitiveA", primitiveA)
    nAttr.array = False
    nAttr.storable = True
    nAttr.writable = True

    nAttr = OpenMaya.MFnNumericAttribute()
    capsuleA = nAttr.create( name + "CapsuleA", name + "CapsuleA", OpenMaya.MFnNumericData.kInt, 0 )
    setattr(classtype, name + "CapsuleA", capsuleA)
    nAttr.array = False
    nAttr.storable = True
    nAttr.writable = True

    nAttr = OpenMaya.MFnNumericAttribute()
    primitiveB = nAttr.create( name + "PrimitiveB", name + "PrimitiveB", OpenMaya.MFnNumericData.kInt, 0 )
    setattr(classtype, name + "PrimitiveB", primitiveB)
    nAttr.array = False
    nAttr.storable = True
    nAttr.writable = True

    nAttr = OpenMaya.MFnNumericAttribute()
    capsuleB = nAttr.create( name + "CapsuleB", name + "CapsuleB", OpenMaya.MFnNumericData.kInt, 0 )
    setattr(classtype, name + "CapsuleB", capsuleB)
    nAttr.array = False
    nAttr.storable = True
    nAttr.writable = True

    nAttr = OpenMaya.MFnNumericAttribute()
    weight = nAttr.create( name +"Weight",name + "Weight", OpenMaya.MFnNumericData.kDouble, 1.0 )
    setattr(classtype, name + "Weight", weight)
    nAttr.array = False
    nAttr.storable = True
    nAttr.writable = True

    nAttr = OpenMaya.MFnNumericAttribute()
    abRatio = nAttr.create( name +"ABRatio",name + "ABRatio", OpenMaya.MFnNumericData.kDouble, 0.0 )
    setattr(classtype, name + "ABRatio", abRatio)
    nAttr.array = False
    nAttr.storable = True
    nAttr.writable = True

    nAttr = OpenMaya.MFnNumericAttribute()
    aOrientationRatio = nAttr.create( name +"AOrientationRatio",name + "AOrientationRatio", OpenMaya.MFnNumericData.kDouble, 1.0 )
    setattr(classtype, name + "AOrientationRatio", aOrientationRatio)
    nAttr.array = False
    nAttr.storable = True
    nAttr.writable = True

    classtype.addAttribute(primitiveA)
    classtype.addAttribute(capsuleA)
    classtype.addAttribute(primitiveB)
    classtype.addAttribute(capsuleB)
    classtype.addAttribute(weight)
    classtype.addAttribute(abRatio)
    classtype.addAttribute(aOrientationRatio)

    mComp.addChild(primitiveA)
    mComp.addChild(capsuleA)
    mComp.addChild(primitiveB)
    mComp.addChild(capsuleB)
    mComp.addChild(weight)
    mComp.addChild(abRatio)
    mComp.addChild(aOrientationRatio)

    classtype.addAttribute(compound)

    return compound



def create_primitives_links_from_input(classtype, name, dataBlock):
    links = []

    linksHandle = dataBlock.inputArrayValue( getattr(classtype, name))
    while linksHandle.isDone() == False:
        linkHandle = linksHandle.inputValue()

        primitiveA = linkHandle.child(getattr(classtype, name + "PrimitiveA")).asInt()
        capsuleA = linkHandle.child(getattr(classtype, name + "CapsuleA")).asInt()
        primitiveB = linkHandle.child(getattr(classtype, name + "PrimitiveB")).asInt()
        capsuleB = linkHandle.child(getattr(classtype, name + "CapsuleB")).asInt()
        weight = linkHandle.child(getattr(classtype, name + "Weight")).asDouble()
        abRatio = linkHandle.child(getattr(classtype, name + "ABRatio")).asDouble()
        aOrientationRatio = linkHandle.child(getattr(classtype, name + "AOrientationRatio")).asDouble()

        links.append(PrimitiveLink(
            primitiveA,
            capsuleA,
            primitiveB,
            capsuleB,
            weight,
            abRatio,
            aOrientationRatio
        ))
       
        linksHandle.next()

    return links