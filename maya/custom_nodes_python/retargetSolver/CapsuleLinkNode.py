import math, sys
import maya.api.OpenMaya as OpenMaya

import mtypes as t
from CapsuleLink import CapsuleLink
from mayamatrix import mayaToMatrix, matrixToMaya

maya_useNewAPI = True 
kPluginNodeTypeName = "CapsuleLinkNode"
pluginNodeId = OpenMaya.MTypeId(0x8801)


def create_capsule_compound(classtype, name):
    mComp = OpenMaya.MFnCompoundAttribute()
    compound = mComp.create(name, name)
    setattr(classtype, name, compound)
    mComp.array = False
    mComp.storable = True
    mComp.writable = True

    mAttr = OpenMaya.MFnMatrixAttribute()
    matrix = mAttr.create( name + "Matrix", name + "Matrix" )
    setattr(classtype, name + "Matrix", matrix)
    mAttr.array = False
    mAttr.storable = True
    mAttr.writable = True

    nAttr = OpenMaya.MFnNumericAttribute()
    radius = nAttr.create( name + "Radius", name + "Radius", OpenMaya.MFnNumericData.kDouble, 0.5 )
    setattr(classtype, name + "Radius", radius)
    nAttr.array = False
    nAttr.storable = True
    nAttr.writable = True

    nAttr = OpenMaya.MFnNumericAttribute()
    height = nAttr.create( name + "Height", name + "Height", OpenMaya.MFnNumericData.kDouble, 1.0 )
    setattr(classtype, name + "Height", height)
    nAttr.array = False
    nAttr.storable = True
    nAttr.writable = True

    classtype.addAttribute(matrix)
    classtype.addAttribute(radius)
    classtype.addAttribute(height)

    mComp.addChild(matrix)
    mComp.addChild(radius)
    mComp.addChild(height)

    classtype.addAttribute(compound)

    return compound



def get_capsule_datablock(classtype, name, dataBlock, pq=None):
    if pq == None:
        matrix = mayaToMatrix(dataBlock.inputValue( getattr(classtype, name+"Matrix" )).asMatrix())
        pq = t.PosQuat.fromMatrix(matrix)
    radius = dataBlock.inputValue( getattr(classtype, name+"Radius" )).asDouble()
    height = dataBlock.inputValue( getattr(classtype, name+"Height" )).asDouble()

    return t.Capsule(
        pq,
        radius,
        height
    )


# Node definition
class CapsuleLinkNode(OpenMaya.MPxNode):
    # class variables
    outputA = OpenMaya.MObject()
    outputB = OpenMaya.MObject()

    weight = OpenMaya.MObject()
    abRatio = OpenMaya.MObject()
    aOrientationRatio = OpenMaya.MObject()
    
    def __init__(self):
        OpenMaya.MPxNode.__init__(self)

    def shouldSave(self):
        return True
        

    def compute(self, plug, dataBlock):

        cls = self.__class__

        if ( plug == cls.outputA or plug == cls.outputB ):
            
            inputCapsuleA = get_capsule_datablock(cls, 'inputCapsuleA', dataBlock)
            inputCapsuleB = get_capsule_datablock(cls, 'inputCapsuleB', dataBlock)
            outputCapsuleA = get_capsule_datablock(cls, 'outputCapsuleA', dataBlock, inputCapsuleA.pq.copy())
            outputCapsuleB = get_capsule_datablock(cls, 'outputCapsuleB', dataBlock, inputCapsuleB.pq.copy())

            link = CapsuleLink.gather(inputCapsuleA, inputCapsuleB)

            weight = dataBlock.inputValue(cls.weight).asDouble()
            abRatio = dataBlock.inputValue(cls.abRatio).asDouble()
            aOrientationRatio = dataBlock.inputValue(cls.aOrientationRatio).asDouble()
            a,b = link.solve(outputCapsuleA, outputCapsuleB, weight, abRatio, aOrientationRatio)

            dataBlock.outputValue( cls.outputA ).setMMatrix (matrixToMaya(a.matrix()))
            dataBlock.outputValue( cls.outputB ).setMMatrix (matrixToMaya(b.matrix()))
            
            dataBlock.setClean( plug )

# creator
def nodeCreator():
    return CapsuleLinkNode()
    
# initializer
def nodeInitializer():
    classname = CapsuleLinkNode
    # input
    inputCapsuleA = create_capsule_compound(classname, 'inputCapsuleA')
    inputCapsuleB = create_capsule_compound(classname, 'inputCapsuleB')
    outputCapsuleA = create_capsule_compound(classname, 'outputCapsuleA')
    outputCapsuleB = create_capsule_compound(classname, 'outputCapsuleB')

    mAttr = OpenMaya.MFnMatrixAttribute()
    classname.outputA = mAttr.create( "outputA","outputA" )
    mAttr.array = False
    mAttr.storable = True
    mAttr.writable = True

    classname.outputB = mAttr.create( "outputB","outputB" )
    mAttr.array = False
    mAttr.storable = True
    mAttr.writable = True

    nAttr = OpenMaya.MFnNumericAttribute()
    classname.weight = nAttr.create( "weight", "weight", OpenMaya.MFnNumericData.kDouble, 1.0 )
    nAttr.array = False
    nAttr.storable = True
    nAttr.writable = True

    classname.abRatio = nAttr.create( "abRatio", "abRatio", OpenMaya.MFnNumericData.kDouble, 0.0 )
    nAttr.array = False
    nAttr.storable = True
    nAttr.writable = True

    classname.aOrientationRatio = nAttr.create( "aOrientationRatio", "aOrientationRatio", OpenMaya.MFnNumericData.kDouble, 1.0 )
    nAttr.array = False
    nAttr.storable = True
    nAttr.writable = True

    classname.addAttribute(classname.outputA)
    classname.addAttribute(classname.outputB)
    classname.addAttribute(classname.weight)
    classname.addAttribute(classname.abRatio)
    classname.addAttribute(classname.aOrientationRatio)
    
    classname.attributeAffects( inputCapsuleA, classname.outputA )
    classname.attributeAffects( inputCapsuleA, classname.outputB )
    classname.attributeAffects( inputCapsuleB, classname.outputA )
    classname.attributeAffects( inputCapsuleB, classname.outputB )
    classname.attributeAffects( outputCapsuleA, classname.outputA )
    classname.attributeAffects( outputCapsuleA, classname.outputB )
    classname.attributeAffects( outputCapsuleB, classname.outputA )
    classname.attributeAffects( outputCapsuleB, classname.outputB )

    classname.attributeAffects( classname.weight, classname.outputA )
    classname.attributeAffects( classname.weight, classname.outputB )
    classname.attributeAffects( classname.abRatio, classname.outputA )
    classname.attributeAffects( classname.abRatio, classname.outputB )
    classname.attributeAffects( classname.aOrientationRatio, classname.outputA )
    classname.attributeAffects( classname.aOrientationRatio, classname.outputB )



    
# initialize the script plug-in
def initializePlugin(mobject):
    mplugin = OpenMaya.MFnPlugin(mobject)
    try:
        mplugin.registerNode( kPluginNodeTypeName, pluginNodeId, nodeCreator, nodeInitializer )
    except:
        sys.stderr.write( "Failed to register node: %s" % kPluginNodeTypeName )
        raise
        
# uninitialize the script plug-in
def uninitializePlugin(mobject):
    mplugin = OpenMaya.MFnPlugin(mobject)
    try:
        mplugin.deregisterNode( pluginNodeId )
    except:
        sys.stderr.write( "Failed to register node: %s" % kPluginNodeTypeName )
        raise