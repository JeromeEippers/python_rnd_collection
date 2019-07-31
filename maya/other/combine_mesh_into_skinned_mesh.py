import maya.cmds as cmds
from functools import wraps
 
    
def createFastCombinedMesh(meshList, name, rootname):
    
    cmds.select(cl=True);
    rootSkeleton = cmds.joint(p=[0,0,0], n=rootname)
    cmds.select(cl=True);
    rootMesh = cmds.createNode('transform', name=name+'_temp')
    
    
    vertCounts = [cmds.polyEvaluate(m, v=True) for m in meshList]
    duplicates = []
    bones = []
    for mesh in meshList:
        dup = cmds.duplicate(mesh)[0]
        dup = cmds.parent(dup, rootMesh)[0]
        duplicates.append(dup)
        cmds.select(cl=True);
        bone = cmds.joint(p=[0,0,0], n=mesh+'_jnt1')
        bone = cmds.parent(bone, rootSkeleton)[0]
        bones.append(bone)
        cmds.select(cl=True);
        
    combinedMesh = cmds.polyUnite( *duplicates, n=name )[0]
    cmds.delete(rootMesh)
    
    #bind skin
    skin = cmds.skinCluster(combinedMesh, rootSkeleton, bindMethod=0, normalizeWeights=1, weightDistribution=0, mi=1, omi=True, dr=4)[0]
    
    startSkin = 0
    for jnt, vertcount in zip(bones, vertCounts):
        cmds.skinPercent( skin, '{}.vtx[{}:{}]'.format(combinedMesh, startSkin, startSkin+vertcount-1), transformValue=[(jnt, 1.0)])
        startSkin += vertcount
    
    return bones
    
