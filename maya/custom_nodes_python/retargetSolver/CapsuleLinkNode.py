import math, sys
import maya.api.OpenMaya as OpenMaya

import mtypes as t
from CapsuleLink import CapsuleLink
from mayamatrix import mayaToMatrix, matrixToMaya
import mayaNodeHelper as h 

maya_useNewAPI = True 
kPluginNodeTypeName = "CapsuleLinkNode"
pluginNodeId = OpenMaya.MTypeId(0x8801)



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

        if ( plug == CapsuleLinkNode.outputA or plug == CapsuleLinkNode.outputB ):
            
            inputCapsuleA = h.get_capsule_datablock(CapsuleLinkNode, 'inputCapsuleA', dataBlock)
            inputCapsuleB = h.get_capsule_datablock(CapsuleLinkNode, 'inputCapsuleB', dataBlock)
            outputCapsuleA = h.get_capsule_datablock(CapsuleLinkNode, 'outputCapsuleA', dataBlock, inputCapsuleA.pq.copy())
            outputCapsuleB = h.get_capsule_datablock(CapsuleLinkNode, 'outputCapsuleB', dataBlock, inputCapsuleB.pq.copy())

            link = CapsuleLink.gather(inputCapsuleA, inputCapsuleB)

            weight = dataBlock.inputValue(CapsuleLinkNode.weight).asDouble()
            abRatio = dataBlock.inputValue(CapsuleLinkNode.abRatio).asDouble()
            aOrientationRatio = dataBlock.inputValue(CapsuleLinkNode.aOrientationRatio).asDouble()
            a,b = link.solve(outputCapsuleA, outputCapsuleB, weight, abRatio, aOrientationRatio)

            dataBlock.outputValue( CapsuleLinkNode.outputA ).setMMatrix (matrixToMaya(a.matrix()))
            dataBlock.outputValue( CapsuleLinkNode.outputB ).setMMatrix (matrixToMaya(b.matrix()))
            
            dataBlock.setClean( plug )

# creator
def nodeCreator():
    return CapsuleLinkNode()
    
# initializer
def nodeInitializer():

    # input
    inputCapsuleA = h.create_capsule_compound(CapsuleLinkNode, 'inputCapsuleA')
    inputCapsuleB = h.create_capsule_compound(CapsuleLinkNode, 'inputCapsuleB')
    outputCapsuleA = h.create_capsule_compound(CapsuleLinkNode, 'outputCapsuleA')
    outputCapsuleB = h.create_capsule_compound(CapsuleLinkNode, 'outputCapsuleB')

    mAttr = OpenMaya.MFnMatrixAttribute()
    CapsuleLinkNode.outputA = mAttr.create( "outputA","outputA" )
    mAttr.array = False
    mAttr.storable = True
    mAttr.writable = True

    CapsuleLinkNode.outputB = mAttr.create( "outputB","outputB" )
    mAttr.array = False
    mAttr.storable = True
    mAttr.writable = True

    nAttr = OpenMaya.MFnNumericAttribute()
    CapsuleLinkNode.weight = nAttr.create( "weight", "weight", OpenMaya.MFnNumericData.kDouble, 1.0 )
    nAttr.array = False
    nAttr.storable = True
    nAttr.writable = True

    CapsuleLinkNode.abRatio = nAttr.create( "abRatio", "abRatio", OpenMaya.MFnNumericData.kDouble, 0.0 )
    nAttr.array = False
    nAttr.storable = True
    nAttr.writable = True

    CapsuleLinkNode.aOrientationRatio = nAttr.create( "aOrientationRatio", "aOrientationRatio", OpenMaya.MFnNumericData.kDouble, 1.0 )
    nAttr.array = False
    nAttr.storable = True
    nAttr.writable = True

    CapsuleLinkNode.addAttribute(CapsuleLinkNode.outputA)
    CapsuleLinkNode.addAttribute(CapsuleLinkNode.outputB)
    CapsuleLinkNode.addAttribute(CapsuleLinkNode.weight)
    CapsuleLinkNode.addAttribute(CapsuleLinkNode.abRatio)
    CapsuleLinkNode.addAttribute(CapsuleLinkNode.aOrientationRatio)
    
    CapsuleLinkNode.attributeAffects( inputCapsuleA, CapsuleLinkNode.outputA )
    CapsuleLinkNode.attributeAffects( inputCapsuleA, CapsuleLinkNode.outputB )
    CapsuleLinkNode.attributeAffects( inputCapsuleB, CapsuleLinkNode.outputA )
    CapsuleLinkNode.attributeAffects( inputCapsuleB, CapsuleLinkNode.outputB )
    CapsuleLinkNode.attributeAffects( outputCapsuleA, CapsuleLinkNode.outputA )
    CapsuleLinkNode.attributeAffects( outputCapsuleA, CapsuleLinkNode.outputB )
    CapsuleLinkNode.attributeAffects( outputCapsuleB, CapsuleLinkNode.outputA )
    CapsuleLinkNode.attributeAffects( outputCapsuleB, CapsuleLinkNode.outputB )

    CapsuleLinkNode.attributeAffects( CapsuleLinkNode.weight, CapsuleLinkNode.outputA )
    CapsuleLinkNode.attributeAffects( CapsuleLinkNode.weight, CapsuleLinkNode.outputB )
    CapsuleLinkNode.attributeAffects( CapsuleLinkNode.abRatio, CapsuleLinkNode.outputA )
    CapsuleLinkNode.attributeAffects( CapsuleLinkNode.abRatio, CapsuleLinkNode.outputB )
    CapsuleLinkNode.attributeAffects( CapsuleLinkNode.aOrientationRatio, CapsuleLinkNode.outputA )
    CapsuleLinkNode.attributeAffects( CapsuleLinkNode.aOrientationRatio, CapsuleLinkNode.outputB )



    
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