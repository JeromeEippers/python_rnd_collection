srcbones = [u'Character1_Hips', u'Character1_LeftUpLeg', u'Character1_LeftLeg', u'Character1_LeftFoot', u'Character1_LeftToeBase', u'Character1_RightUpLeg', u'Character1_RightLeg', u'Character1_RightFoot', u'Character1_RightToeBase', u'Character1_Spine', u'Character1_Spine1', u'Character1_Spine2', u'Character1_LeftShoulder', u'Character1_LeftArm', u'Character1_LeftForeArm', u'Character1_LeftHand', u'Character1_LeftHandThumb1', u'Character1_LeftHandThumb2', u'Character1_LeftHandThumb3', u'Character1_LeftHandThumb4', u'Character1_LeftHandIndex1', u'Character1_LeftHandIndex2', u'Character1_LeftHandIndex3', u'Character1_LeftHandIndex4', u'Character1_LeftHandMiddle1', u'Character1_LeftHandMiddle2', u'Character1_LeftHandMiddle3', u'Character1_LeftHandMiddle4', u'Character1_LeftHandRing1', u'Character1_LeftHandRing2', u'Character1_LeftHandRing3', u'Character1_LeftHandRing4', u'Character1_LeftHandPinky1', u'Character1_LeftHandPinky2', u'Character1_LeftHandPinky3', u'Character1_LeftHandPinky4', u'Character1_RightShoulder', u'Character1_RightArm', u'Character1_RightForeArm', u'Character1_RightHand', u'Character1_RightHandThumb1', u'Character1_RightHandThumb2', u'Character1_RightHandThumb3', u'Character1_RightHandThumb4', u'Character1_RightHandIndex1', u'Character1_RightHandIndex2', u'Character1_RightHandIndex3', u'Character1_RightHandIndex4', u'Character1_RightHandMiddle1', u'Character1_RightHandMiddle2', u'Character1_RightHandMiddle3', u'Character1_RightHandMiddle4', u'Character1_RightHandRing1', u'Character1_RightHandRing2', u'Character1_RightHandRing3', u'Character1_RightHandRing4', u'Character1_RightHandPinky1', u'Character1_RightHandPinky2', u'Character1_RightHandPinky3', u'Character1_RightHandPinky4', u'Character1_Neck', u'Character1_Head']
dstbones = [u'Character2_Hips', u'Character2_LeftUpLeg', u'Character2_LeftLeg', u'Character2_LeftFoot', u'Character2_LeftToeBase', u'Character2_RightUpLeg', u'Character2_RightLeg', u'Character2_RightFoot', u'Character2_RightToeBase', u'Character2_Spine', u'Character2_Spine1', u'Character2_Spine2', u'Character2_LeftShoulder', u'Character2_LeftArm', u'Character2_LeftForeArm', u'Character2_LeftHand', u'Character2_LeftHandThumb1', u'Character2_LeftHandThumb2', u'Character2_LeftHandThumb3', u'Character2_LeftHandThumb4', u'Character2_LeftHandIndex1', u'Character2_LeftHandIndex2', u'Character2_LeftHandIndex3', u'Character2_LeftHandIndex4', u'Character2_LeftHandMiddle1', u'Character2_LeftHandMiddle2', u'Character2_LeftHandMiddle3', u'Character2_LeftHandMiddle4', u'Character2_LeftHandRing1', u'Character2_LeftHandRing2', u'Character2_LeftHandRing3', u'Character2_LeftHandRing4', u'Character2_LeftHandPinky1', u'Character2_LeftHandPinky2', u'Character2_LeftHandPinky3', u'Character2_LeftHandPinky4', u'Character2_RightShoulder', u'Character2_RightArm', u'Character2_RightForeArm', u'Character2_RightHand', u'Character2_RightHandThumb1', u'Character2_RightHandThumb2', u'Character2_RightHandThumb3', u'Character2_RightHandThumb4', u'Character2_RightHandIndex1', u'Character2_RightHandIndex2', u'Character2_RightHandIndex3', u'Character2_RightHandIndex4', u'Character2_RightHandMiddle1', u'Character2_RightHandMiddle2', u'Character2_RightHandMiddle3', u'Character2_RightHandMiddle4', u'Character2_RightHandRing1', u'Character2_RightHandRing2', u'Character2_RightHandRing3', u'Character2_RightHandRing4', u'Character2_RightHandPinky1', u'Character2_RightHandPinky2', u'Character2_RightHandPinky3', u'Character2_RightHandPinky4', u'Character2_Neck', u'Character2_Head']

def parentId(srcbones, bone):
    p = cmds.listRelatives(bone, parent=True)[0]
    id = -1
    if p in srcbones:
        id = srcbones.index(p)
    return id
    
skeleton = cmds.createNode("SkeletonSolverNode")
    
    
id = 0
for src, dst in zip(srcbones, dstbones):
    p = parentId(srcbones, src)
    
    cmds.connectAttr('{}.matrix'.format(src), '{}.skeleton[{}].skeletonSrcMatrix'.format(skeleton,id))
    cmds.setAttr('{}.skeleton[{}].skeletonBoneParent'.format(skeleton,id), p)
    cmds.setAttr('{}.skeleton[{}].skeletonTranslateScale'.format(skeleton,id), 0)
    cmds.setAttr('{}.skeleton[{}].skeletonTargetTranslate'.format(skeleton,id),
        *(cmds.getAttr('{}.translate'.format(dst))[0])
        )
    
    dm = cmds.shadingNode('decomposeMatrix', asUtility=True)
    cmds.connectAttr('{}.outputs[{}]'.format(skeleton,id), '{}.inputMatrix'.format(dm))
    cmds.connectAttr('{}.outputTranslate'.format(dm), '{}.translate'.format(dst))
    cmds.connectAttr('{}.outputRotate'.format(dm), '{}.rotate'.format(dst))
    
    id += 1
    
    