import math, sys
import maya.api.OpenMaya as OpenMaya

import mtypes as t
from mayamatrix import mayaToMatrix, matrixToMaya
from Skeleton import create_skeleton_compound, create_skeletons_from_input, transfer_skeletons, output_skeleton
from Primitive import create_primitives_compound, create_primitives_from_input
from PrimitiveLink import create_primitive_links_compound, create_primitives_links_from_input

maya_useNewAPI = True 
kPluginNodeTypeName = "ConstraintSolverNode"
pluginNodeId = OpenMaya.MTypeId(0x8803)



# Node definition
class ConstraintSolverNode(OpenMaya.MPxNode):
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
            primitiveSource = create_primitives_from_input(cls, 'primitiveSource', dataBlock)
            primitiveDestination = create_primitives_from_input(cls, 'primitiveDestination', dataBlock)
            links = create_primitives_links_from_input(cls, 'link', dataBlock)

            #gather links
            for link in links:
                link.gather(primitiveSource, src)


            #transfer bone animation
            transfer_skeletons(src, dst)

            #solve links
            for iteration in range(10):
                s = 0.1 + iteration/9.0
                for link in links:
                    if link.weight > 0.001 :
                        a,b = link.solve(primitiveDestination, dst)

                        primitiveA = primitiveDestination[link.primitiveIdA]
                        primitiveB = primitiveDestination[link.primitiveIdB]

                        ao = dst.globalPq(primitiveA.boneParent)
                        bo = dst.globalPq(primitiveB.boneParent)

                        dst.setGlobalPq(primitiveA.boneParent, t.PosQuat.lerp(ao, a, s))
                        dst.setGlobalPq(primitiveB.boneParent, t.PosQuat.lerp(bo, b, s))
       
            output_skeleton(cls, 'outputs', dataBlock, dst)

            
            dataBlock.setClean( plug )

# creator
def nodeCreator():
    return ConstraintSolverNode()
    

# initializer
def nodeInitializer():

    classname = ConstraintSolverNode

    #input
    skel = create_skeleton_compound(classname, 'skeleton')
    primitivesS = create_primitives_compound(classname, 'primitiveSource')
    primitivesD = create_primitives_compound(classname, 'primitiveDestination')
    link = create_primitive_links_compound(classname, 'link')

    # output
    mAttr = OpenMaya.MFnMatrixAttribute()
    classname.outputs = mAttr.create( "outputs","outputs" )
    mAttr.array = True
    mAttr.storable = True
    mAttr.writable = True

    classname.addAttribute(classname.outputs)

    classname.attributeAffects(skel, classname.outputs)
    classname.attributeAffects(primitivesS, classname.outputs)
    classname.attributeAffects(primitivesD, classname.outputs)
    classname.attributeAffects(link, classname.outputs)
    


    
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
    