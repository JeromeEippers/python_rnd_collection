import math, sys
import maya.api.OpenMaya as OpenMaya

import mtypes as t
from mayamatrix import mayaToMatrix, matrixToMaya
from Skeleton import create_skeleton_compound, create_skeletons_from_input, transfer_skeletons, output_skeleton

maya_useNewAPI = True 
kPluginNodeTypeName = "SkeletonSolverNode"
pluginNodeId = OpenMaya.MTypeId(0x8802)



# Node definition
class SkeletonSolverNode(OpenMaya.MPxNode):
    # class variables
    outputs = OpenMaya.MObject()
    
    
    def __init__(self):
        OpenMaya.MPxNode.__init__(self)

    def shouldSave(self):
        return True
        

    def compute(self, plug, dataBlock):

        cls = self.__class__

        if ( plug == cls.outputs ):
            
            src, dst = create_skeletons_from_input(cls, 'skeleton', dataBlock)
            transfer_skeletons(src, dst)
            output_skeleton(cls, 'outputs', dataBlock, dst)
            dataBlock.setClean( plug )

# creator
def nodeCreator():
    return SkeletonSolverNode()
    

# initializer
def nodeInitializer():

    classname = SkeletonSolverNode

    #input
    skel = create_skeleton_compound(classname, 'skeleton')

    # output
    mAttr = OpenMaya.MFnMatrixAttribute()
    classname.outputs = mAttr.create( "outputs","outputs" )
    mAttr.array = True
    mAttr.storable = True
    mAttr.writable = True

    classname.addAttribute(classname.outputs)

    classname.attributeAffects(skel, classname.outputs)
    


    
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