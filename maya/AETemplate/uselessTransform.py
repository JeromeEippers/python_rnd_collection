import os
import time
import pdb

import maya.cmds as cmds
import maya.mel as mel

from maya.OpenMaya import *
from maya.OpenMayaMPx import *

################################################################################
#Primary Node Class
################################################################################

kPluginNodeName = 'uselessTransform'
kPluginNodeId = MTypeId(0xae7e391a)

class UTrans(MPxTransform):
    '''
    The uselessTransform plugin class
    '''
    #Attrs MObjects
    _strAttr = MObject()
    _enumAttr = MObject()
    _numAttr = MObject()
    
    def __init__(self, trans=None):
        '''
        Initialize
        '''
        if trans is None:
            super(UTrans, self).__init__()
        else:
            super(UTrans, self).__init__(trans)
    
################################################################################
#Setup the Node
################################################################################
def UTransCreator():
    '''
    Creator
    '''
    return asMPxPtr(UTrans())
    
def UTransInit():
    '''
    Initialize the attributes
    '''
    nAttr = MFnNumericAttribute()
    eAttr = MFnEnumAttribute()
    tAttr = MFnTypedAttribute()
    
    UTrans._strAttr = tAttr.create("stringAttr", "sta", MFnData.kString)
    tAttr.setDefault(MFnStringData().create(''))
    tAttr.setStorable(True)
    tAttr.setWritable(True)
    UTrans.addAttribute(UTrans._strAttr)
    
    UTrans._enumAttr = eAttr.create("enumAttr", "ena", 0)
    eAttr.addField("0", 0)
    eAttr.addField("1", 1)
    eAttr.addField("2", 2)
    eAttr.addField("3", 3)
    eAttr.addField("4", 4)
    eAttr.addField("5", 5)
    eAttr.addField("6", 6)
    eAttr.addField("7", 7)
    eAttr.addField("8", 8)
    eAttr.addField("9", 9)
    eAttr.setStorable(True)
    eAttr.setReadable(True)
    eAttr.setWritable(True)
    UTrans.addAttribute(UTrans._enumAttr)
    
    UTrans._numAttr = nAttr.create("numAttr", "nua", MFnNumericData.kFloat, 0.0)
    nAttr.setDefault(0.0)
    nAttr.setStorable(True)
    nAttr.setWritable(True)
    UTrans.addAttribute(UTrans._numAttr)
    
################################################################################
#Initialize/Uninitialize the plugin
################################################################################
def initializePlugin(mobject):
    mplugin = MFnPlugin(mobject, "Autodesk", "1.0", "Any")
    try:
        mplugin.registerTransform(kPluginNodeName,
                                  kPluginNodeId,
                                  UTransCreator,
                                  UTransInit,
                                  MPxTransformationMatrix.creator,
                                  MTypeId(0x58A00001))
    except:
        sys.stderr.write( "Failed to register node: %s" % kPluginNodeName )
        raise
        


# uninitialize the script plug-in
def uninitializePlugin(mobject):
    mplugin = MFnPlugin(mobject)
    try:
        mplugin.deregisterNode( kPluginNodeId )
    except:
        sys.stderr.write( "Failed to deregister node: %s" % kPluginNodeName )
        raise