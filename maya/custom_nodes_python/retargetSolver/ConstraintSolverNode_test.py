#srcbones = [u'Character1_Hips', u'Character1_LeftUpLeg', u'Character1_LeftLeg', u'Character1_LeftFoot', u'Character1_LeftToeBase', u'Character1_RightUpLeg', u'Character1_RightLeg', u'Character1_RightFoot', u'Character1_RightToeBase', u'Character1_Spine', u'Character1_Spine1', u'Character1_Spine2', u'Character1_LeftShoulder', u'Character1_LeftArm', u'Character1_LeftForeArm', u'Character1_LeftHand', u'Character1_LeftHandThumb1', u'Character1_LeftHandThumb2', u'Character1_LeftHandThumb3', u'Character1_LeftHandThumb4', u'Character1_LeftHandIndex1', u'Character1_LeftHandIndex2', u'Character1_LeftHandIndex3', u'Character1_LeftHandIndex4', u'Character1_LeftHandMiddle1', u'Character1_LeftHandMiddle2', u'Character1_LeftHandMiddle3', u'Character1_LeftHandMiddle4', u'Character1_LeftHandRing1', u'Character1_LeftHandRing2', u'Character1_LeftHandRing3', u'Character1_LeftHandRing4', u'Character1_LeftHandPinky1', u'Character1_LeftHandPinky2', u'Character1_LeftHandPinky3', u'Character1_LeftHandPinky4', u'Character1_RightShoulder', u'Character1_RightArm', u'Character1_RightForeArm', u'Character1_RightHand', u'Character1_RightHandThumb1', u'Character1_RightHandThumb2', u'Character1_RightHandThumb3', u'Character1_RightHandThumb4', u'Character1_RightHandIndex1', u'Character1_RightHandIndex2', u'Character1_RightHandIndex3', u'Character1_RightHandIndex4', u'Character1_RightHandMiddle1', u'Character1_RightHandMiddle2', u'Character1_RightHandMiddle3', u'Character1_RightHandMiddle4', u'Character1_RightHandRing1', u'Character1_RightHandRing2', u'Character1_RightHandRing3', u'Character1_RightHandRing4', u'Character1_RightHandPinky1', u'Character1_RightHandPinky2', u'Character1_RightHandPinky3', u'Character1_RightHandPinky4', u'Character1_Neck', u'Character1_Head']
#dstbones = [u'Character2_Hips', u'Character2_LeftUpLeg', u'Character2_LeftLeg', u'Character2_LeftFoot', u'Character2_LeftToeBase', u'Character2_RightUpLeg', u'Character2_RightLeg', u'Character2_RightFoot', u'Character2_RightToeBase', u'Character2_Spine', u'Character2_Spine1', u'Character2_Spine2', u'Character2_LeftShoulder', u'Character2_LeftArm', u'Character2_LeftForeArm', u'Character2_LeftHand', u'Character2_LeftHandThumb1', u'Character2_LeftHandThumb2', u'Character2_LeftHandThumb3', u'Character2_LeftHandThumb4', u'Character2_LeftHandIndex1', u'Character2_LeftHandIndex2', u'Character2_LeftHandIndex3', u'Character2_LeftHandIndex4', u'Character2_LeftHandMiddle1', u'Character2_LeftHandMiddle2', u'Character2_LeftHandMiddle3', u'Character2_LeftHandMiddle4', u'Character2_LeftHandRing1', u'Character2_LeftHandRing2', u'Character2_LeftHandRing3', u'Character2_LeftHandRing4', u'Character2_LeftHandPinky1', u'Character2_LeftHandPinky2', u'Character2_LeftHandPinky3', u'Character2_LeftHandPinky4', u'Character2_RightShoulder', u'Character2_RightArm', u'Character2_RightForeArm', u'Character2_RightHand', u'Character2_RightHandThumb1', u'Character2_RightHandThumb2', u'Character2_RightHandThumb3', u'Character2_RightHandThumb4', u'Character2_RightHandIndex1', u'Character2_RightHandIndex2', u'Character2_RightHandIndex3', u'Character2_RightHandIndex4', u'Character2_RightHandMiddle1', u'Character2_RightHandMiddle2', u'Character2_RightHandMiddle3', u'Character2_RightHandMiddle4', u'Character2_RightHandRing1', u'Character2_RightHandRing2', u'Character2_RightHandRing3', u'Character2_RightHandRing4', u'Character2_RightHandPinky1', u'Character2_RightHandPinky2', u'Character2_RightHandPinky3', u'Character2_RightHandPinky4', u'Character2_Neck', u'Character2_Head']

srcbones = [u'Character1_Spine2', u'Character1_LeftShoulder', u'Character1_LeftArm', u'Character1_LeftForeArm', u'Character1_LeftHand', u'Character1_RightShoulder', u'Character1_RightArm', u'Character1_RightForeArm', u'Character1_RightHand', u'c1_weapon']
dstbones = [u'Character2_Spine2', u'Character2_LeftShoulder', u'Character2_LeftArm', u'Character2_LeftForeArm', u'Character2_LeftHand', u'Character2_RightShoulder', u'Character2_RightArm', u'Character2_RightForeArm', u'Character2_RightHand', u'c2_weapon']


def parentId(srcbones, bone):
    p = cmds.listRelatives(bone, parent=True)[0]
    id = -1
    if p in srcbones:
        id = srcbones.index(p)
    return id
    
    
def controlableCapsule(name, radius, height):
    root = cmds.createNode('transform', n=name)
    cmds.addAttr(root,ln="height", at='double', dv=height, k=True)
    cmds.addAttr(root,ln="radius", at='double', dv=radius, k=True)
    cyl = cmds.polyCylinder(n=name+'cyl', r=1, h=1, ax=[1,0,0], sx=10, sy=1, sz=1)[0]
    sphA = cmds.polySphere(n=name+'sphA', r=1, sx=10, sy=10, ax=[1,0,0])[0]
    sphB = cmds.polySphere(n=name+'sphB', r=1, sx=10, sy=10, ax=[1,0,0])[0]

    cmds.connectAttr('{}.height'.format(root), '{}.scaleX'.format(cyl))
    cmds.connectAttr('{}.radius'.format(root), '{}.scaleY'.format(cyl))
    cmds.connectAttr('{}.radius'.format(root), '{}.scaleZ'.format(cyl))
    
    sphM = cmds.shadingNode('floatMath', asUtility=True)
    cmds.setAttr("{}.operation".format(sphM), 2)
    cmds.setAttr("{}.floatB".format(sphM), 0.5)
    cmds.connectAttr('{}.height'.format(root), '{}.floatA'.format(sphM))
    cmds.connectAttr('{}.outFloat'.format(sphM), '{}.translateX'.format(sphA))
    cmds.connectAttr('{}.radius'.format(root), '{}.scaleX'.format(sphA))
    cmds.connectAttr('{}.radius'.format(root), '{}.scaleY'.format(sphA))
    cmds.connectAttr('{}.radius'.format(root), '{}.scaleZ'.format(sphA))
    
    sphM = cmds.shadingNode('floatMath', asUtility=True)
    cmds.setAttr("{}.operation".format(sphM), 2)
    cmds.setAttr("{}.floatB".format(sphM), -0.5)
    cmds.connectAttr('{}.height'.format(root), '{}.floatA'.format(sphM))
    cmds.connectAttr('{}.outFloat'.format(sphM), '{}.translateX'.format(sphB))
    cmds.connectAttr('{}.radius'.format(root), '{}.scaleX'.format(sphB))
    cmds.connectAttr('{}.radius'.format(root), '{}.scaleY'.format(sphB))
    cmds.connectAttr('{}.radius'.format(root), '{}.scaleZ'.format(sphB))

    cmds.parent([sphA, sphB, cyl], root)
    return root
    
    
#create hands capsules
c1_leftHand = controlableCapsule("c1_leftHand", 1.1, 5.2)
cmds.parent(c1_leftHand, 'Character1_LeftHand')
cmds.setAttr("{}.translate".format(c1_leftHand), 6.2, -1.5, 0.6)
cmds.setAttr("{}.rotate".format(c1_leftHand), 0, -90, 0)
c1_rightHand = controlableCapsule("c1_rightHand", 1.1, 5.2)
cmds.parent(c1_rightHand, 'Character1_RightHand')
cmds.setAttr("{}.translate".format(c1_rightHand), -6.2, -1.5, 0.6)
cmds.setAttr("{}.rotate".format(c1_rightHand), 0, -90, 0)

c2_leftHand = controlableCapsule("c2_leftHand", 1.1, 5.2)
cmds.parent(c2_leftHand, 'Character2_LeftHand')
cmds.setAttr("{}.translate".format(c2_leftHand), 6.2, -1.5, 0.6)
cmds.setAttr("{}.rotate".format(c2_leftHand), 0, -90, 0)
c2_rightHand = controlableCapsule("c2_rightHand", 1.1, 5.2)
cmds.parent(c2_rightHand, 'Character2_RightHand')
cmds.setAttr("{}.translate".format(c2_rightHand), -6.2, -1.5, 0.6)
cmds.setAttr("{}.rotate".format(c2_rightHand), 0, -90, 0)


#create weapons
c1_weapon = cmds.createNode('transform', n="c1_weapon")
c1_weaponT = controlableCapsule("c1_weaponT", 2, 11)
cmds.parent(c1_weaponT, c1_weapon)
cmds.setAttr("{}.translate".format(c1_weaponT), -5.5, -8, 0)
cmds.setAttr("{}.rotate".format(c1_weaponT), 0, 0, -115)
c1_weaponH = controlableCapsule("c1_weaponH", 3, 38)
cmds.parent(c1_weaponH, c1_weapon)
cmds.setAttr("{}.translate".format(c1_weaponH), 10, 1, 0)
cmds.setAttr("{}.rotate".format(c1_weaponH), 0, 0, 0)
cmds.parent(c1_weapon, 'Character1_Spine2')

c2_weapon = cmds.createNode('transform', n="c2_weapon")
c2_weaponT = controlableCapsule("c2_weaponT", 2, 11)
cmds.parent(c2_weaponT, c2_weapon)
cmds.setAttr("{}.translate".format(c2_weaponT), -5.5, -8, 0)
cmds.setAttr("{}.rotate".format(c2_weaponT), 0, 0, -115)
c2_weaponH = controlableCapsule("c2_weaponH", 3, 38)
cmds.parent(c2_weaponH, c2_weapon)
cmds.setAttr("{}.translate".format(c2_weaponH), 10, 1, 0)
cmds.setAttr("{}.rotate".format(c2_weaponH), 0, 0, 0)
cmds.parent(c2_weapon, 'Character2_Spine2')
   
#create Hips capsule
c1_Hips = controlableCapsule("c1_Hips", 5, 10)
cmds.parent(c1_Hips, 'Character1_Spine2')
cmds.setAttr("{}.translate".format(c1_Hips), 0, -40, 0)

c2_Hips = controlableCapsule("c2_Hips", 5, 21.5)
cmds.parent(c2_Hips, 'Character2_Spine2')
cmds.setAttr("{}.translate".format(c2_Hips), 0, -38, 0)
   
   
#create parameter holder
params = cmds.createNode('transform', n="SOLVER")
cmds.addAttr(params,ln="HandHandWeight", at='double', dv=1, min=0, max=1, k=True)
cmds.addAttr(params,ln="HandHandRatio", at='double', dv=0, min=0, max=1, k=True)
cmds.addAttr(params,ln="HandHandOrientation", at='double', dv=1, min=0, max=1, k=True) 
cmds.addAttr(params,ln="TriggerWeight", at='double', dv=1, min=0, max=1, k=True)
cmds.addAttr(params,ln="TriggerRatio", at='double', dv=0, min=0, max=1, k=True)
cmds.addAttr(params,ln="TriggerOrientation", at='double', dv=1, min=0, max=1, k=True) 
cmds.addAttr(params,ln="HandleWeight", at='double', dv=1, min=0, max=1, k=True)
cmds.addAttr(params,ln="HandleRatio", at='double', dv=0, min=0, max=1, k=True)
cmds.addAttr(params,ln="HandleOrientation", at='double', dv=1, min=0, max=1, k=True)
cmds.addAttr(params,ln="HipsLWeight", at='double', dv=1, min=0, max=1, k=True)
cmds.addAttr(params,ln="HipsLRatio", at='double', dv=0, min=0, max=1, k=True)
cmds.addAttr(params,ln="HipsLOrientation", at='double', dv=1, min=0, max=1, k=True)
cmds.addAttr(params,ln="HipsRWeight", at='double', dv=1, min=0, max=1, k=True)
cmds.addAttr(params,ln="HipsRRatio", at='double', dv=0, min=0, max=1, k=True)
cmds.addAttr(params,ln="HipsROrientation", at='double', dv=1, min=0, max=1, k=True)
  
#create solver
solver = cmds.createNode("ConstraintSolverNode")
    
    
#attach skeletons
id = 0
for src, dst in zip(srcbones, dstbones):
    p = parentId(srcbones, src)
    
    cmds.connectAttr('{}.matrix'.format(src), '{}.skeleton[{}].skeletonSrcMatrix'.format(solver,id))
    cmds.setAttr('{}.skeleton[{}].skeletonBoneParent'.format(solver,id), p)
    cmds.setAttr('{}.skeleton[{}].skeletonTranslateScale'.format(solver,id), 0)
    cmds.setAttr('{}.skeleton[{}].skeletonTargetTranslate'.format(solver,id),
        *(cmds.getAttr('{}.translate'.format(dst))[0])
        )
    
    dm = cmds.shadingNode('decomposeMatrix', asUtility=True)
    cmds.connectAttr('{}.outputs[{}]'.format(solver,id), '{}.inputMatrix'.format(dm))
    cmds.connectAttr('{}.outputTranslate'.format(dm), '{}.translate'.format(dst))
    cmds.connectAttr('{}.outputRotate'.format(dm), '{}.rotate'.format(dst))
    
    id += 1
    
cmds.setAttr('{}.skeleton[{}].skeletonTranslateScale'.format(solver,9), 1)
    
    
#hands primitive
cmds.connectAttr('{}.matrix'.format(c1_leftHand), '{}.primitiveSource[{}].primitiveSourceCapsule[{}].primitiveSourceCapsuleMatrix'.format(solver,0,0))
cmds.connectAttr('{}.height'.format(c1_leftHand), '{}.primitiveSource[{}].primitiveSourceCapsule[{}].primitiveSourceCapsuleHeight'.format(solver,0,0))
cmds.connectAttr('{}.radius'.format(c1_leftHand), '{}.primitiveSource[{}].primitiveSourceCapsule[{}].primitiveSourceCapsuleRadius'.format(solver,0,0))
cmds.setAttr('{}.primitiveSource[{}].primitiveSourceBoneParent'.format(solver,0), 4)

cmds.connectAttr('{}.matrix'.format(c1_rightHand), '{}.primitiveSource[{}].primitiveSourceCapsule[{}].primitiveSourceCapsuleMatrix'.format(solver,1,0))
cmds.connectAttr('{}.height'.format(c1_rightHand), '{}.primitiveSource[{}].primitiveSourceCapsule[{}].primitiveSourceCapsuleHeight'.format(solver,1,0))
cmds.connectAttr('{}.radius'.format(c1_rightHand), '{}.primitiveSource[{}].primitiveSourceCapsule[{}].primitiveSourceCapsuleRadius'.format(solver,1,0))
cmds.setAttr('{}.primitiveSource[{}].primitiveSourceBoneParent'.format(solver,1), 8)

cmds.connectAttr('{}.matrix'.format(c2_leftHand), '{}.primitiveDestination[{}].primitiveDestinationCapsule[{}].primitiveDestinationCapsuleMatrix'.format(solver,0,0))
cmds.connectAttr('{}.height'.format(c2_leftHand), '{}.primitiveDestination[{}].primitiveDestinationCapsule[{}].primitiveDestinationCapsuleHeight'.format(solver,0,0))
cmds.connectAttr('{}.radius'.format(c2_leftHand), '{}.primitiveDestination[{}].primitiveDestinationCapsule[{}].primitiveDestinationCapsuleRadius'.format(solver,0,0))
cmds.setAttr('{}.primitiveDestination[{}].primitiveDestinationBoneParent'.format(solver,0), 4)

cmds.connectAttr('{}.matrix'.format(c2_rightHand), '{}.primitiveDestination[{}].primitiveDestinationCapsule[{}].primitiveDestinationCapsuleMatrix'.format(solver,1,0))
cmds.connectAttr('{}.height'.format(c2_rightHand), '{}.primitiveDestination[{}].primitiveDestinationCapsule[{}].primitiveDestinationCapsuleHeight'.format(solver,1,0))
cmds.connectAttr('{}.radius'.format(c2_rightHand), '{}.primitiveDestination[{}].primitiveDestinationCapsule[{}].primitiveDestinationCapsuleRadius'.format(solver,1,0))
cmds.setAttr('{}.primitiveDestination[{}].primitiveDestinationBoneParent'.format(solver,1), 8)

#hands link
cmds.connectAttr('{}.HandHandWeight'.format(params), '{}.link[{}].linkWeight'.format(solver,0))
cmds.connectAttr('{}.HandHandRatio'.format(params), '{}.link[{}].linkABRatio'.format(solver,0))
cmds.connectAttr('{}.HandHandOrientation'.format(params), '{}.link[{}].linkAOrientationRatio'.format(solver,0))
cmds.setAttr('{}.link[{}].linkPrimitiveA'.format(solver,0), 0)
cmds.setAttr('{}.link[{}].linkCapsuleA'.format(solver,0), 0)
cmds.setAttr('{}.link[{}].linkPrimitiveB'.format(solver,0), 1)
cmds.setAttr('{}.link[{}].linkCapsuleB'.format(solver,0), 0)

#weapon primitives
cmds.connectAttr('{}.matrix'.format(c1_weaponT), '{}.primitiveSource[{}].primitiveSourceCapsule[{}].primitiveSourceCapsuleMatrix'.format(solver,2,0))
cmds.connectAttr('{}.height'.format(c1_weaponT), '{}.primitiveSource[{}].primitiveSourceCapsule[{}].primitiveSourceCapsuleHeight'.format(solver,2,0))
cmds.connectAttr('{}.radius'.format(c1_weaponT), '{}.primitiveSource[{}].primitiveSourceCapsule[{}].primitiveSourceCapsuleRadius'.format(solver,2,0))
cmds.connectAttr('{}.matrix'.format(c1_weaponH), '{}.primitiveSource[{}].primitiveSourceCapsule[{}].primitiveSourceCapsuleMatrix'.format(solver,2,1))
cmds.connectAttr('{}.height'.format(c1_weaponH), '{}.primitiveSource[{}].primitiveSourceCapsule[{}].primitiveSourceCapsuleHeight'.format(solver,2,1))
cmds.connectAttr('{}.radius'.format(c1_weaponH), '{}.primitiveSource[{}].primitiveSourceCapsule[{}].primitiveSourceCapsuleRadius'.format(solver,2,1))
cmds.setAttr('{}.primitiveSource[{}].primitiveSourceBoneParent'.format(solver,2), 9)
    
cmds.connectAttr('{}.matrix'.format(c2_weaponT), '{}.primitiveDestination[{}].primitiveDestinationCapsule[{}].primitiveDestinationCapsuleMatrix'.format(solver,2,0))
cmds.connectAttr('{}.height'.format(c2_weaponT), '{}.primitiveDestination[{}].primitiveDestinationCapsule[{}].primitiveDestinationCapsuleHeight'.format(solver,2,0))
cmds.connectAttr('{}.radius'.format(c2_weaponT), '{}.primitiveDestination[{}].primitiveDestinationCapsule[{}].primitiveDestinationCapsuleRadius'.format(solver,2,0))
cmds.connectAttr('{}.matrix'.format(c2_weaponH), '{}.primitiveDestination[{}].primitiveDestinationCapsule[{}].primitiveDestinationCapsuleMatrix'.format(solver,2,1))
cmds.connectAttr('{}.height'.format(c2_weaponH), '{}.primitiveDestination[{}].primitiveDestinationCapsule[{}].primitiveDestinationCapsuleHeight'.format(solver,2,1))
cmds.connectAttr('{}.radius'.format(c2_weaponH), '{}.primitiveDestination[{}].primitiveDestinationCapsule[{}].primitiveDestinationCapsuleRadius'.format(solver,2,1))
cmds.setAttr('{}.primitiveDestination[{}].primitiveDestinationBoneParent'.format(solver,2), 9)

#weapons link
cmds.connectAttr('{}.TriggerWeight'.format(params), '{}.link[{}].linkWeight'.format(solver,1))
cmds.connectAttr('{}.TriggerRatio'.format(params), '{}.link[{}].linkABRatio'.format(solver,1))
cmds.connectAttr('{}.TriggerOrientation'.format(params), '{}.link[{}].linkAOrientationRatio'.format(solver,1))
cmds.setAttr('{}.link[{}].linkPrimitiveA'.format(solver,1), 1)
cmds.setAttr('{}.link[{}].linkCapsuleA'.format(solver,1), 0)
cmds.setAttr('{}.link[{}].linkPrimitiveB'.format(solver,1), 2)
cmds.setAttr('{}.link[{}].linkCapsuleB'.format(solver,1), 0)

cmds.connectAttr('{}.HandleWeight'.format(params), '{}.link[{}].linkWeight'.format(solver,2))
cmds.connectAttr('{}.HandleRatio'.format(params), '{}.link[{}].linkABRatio'.format(solver,2))
cmds.connectAttr('{}.HandleOrientation'.format(params), '{}.link[{}].linkAOrientationRatio'.format(solver,2))
cmds.setAttr('{}.link[{}].linkPrimitiveA'.format(solver,2), 0)
cmds.setAttr('{}.link[{}].linkCapsuleA'.format(solver,2), 0)
cmds.setAttr('{}.link[{}].linkPrimitiveB'.format(solver,2), 2)
cmds.setAttr('{}.link[{}].linkCapsuleB'.format(solver,2), 1)

#hips primitive
cmds.connectAttr('{}.matrix'.format(c1_Hips), '{}.primitiveSource[{}].primitiveSourceCapsule[{}].primitiveSourceCapsuleMatrix'.format(solver,3,0))
cmds.connectAttr('{}.height'.format(c1_Hips), '{}.primitiveSource[{}].primitiveSourceCapsule[{}].primitiveSourceCapsuleHeight'.format(solver,3,0))
cmds.connectAttr('{}.radius'.format(c1_Hips), '{}.primitiveSource[{}].primitiveSourceCapsule[{}].primitiveSourceCapsuleRadius'.format(solver,3,0))
cmds.setAttr('{}.primitiveSource[{}].primitiveSourceBoneParent'.format(solver,3), 0)

cmds.connectAttr('{}.matrix'.format(c2_Hips), '{}.primitiveDestination[{}].primitiveDestinationCapsule[{}].primitiveDestinationCapsuleMatrix'.format(solver,3,0))
cmds.connectAttr('{}.height'.format(c2_Hips), '{}.primitiveDestination[{}].primitiveDestinationCapsule[{}].primitiveDestinationCapsuleHeight'.format(solver,3,0))
cmds.connectAttr('{}.radius'.format(c2_Hips), '{}.primitiveDestination[{}].primitiveDestinationCapsule[{}].primitiveDestinationCapsuleRadius'.format(solver,3,0))
cmds.setAttr('{}.primitiveDestination[{}].primitiveDestinationBoneParent'.format(solver,3), 0)

#weapons link
cmds.connectAttr('{}.HipsLWeight'.format(params), '{}.link[{}].linkWeight'.format(solver,3))
cmds.connectAttr('{}.HipsLRatio'.format(params), '{}.link[{}].linkABRatio'.format(solver,3))
cmds.connectAttr('{}.HipsLOrientation'.format(params), '{}.link[{}].linkAOrientationRatio'.format(solver,3))
cmds.setAttr('{}.link[{}].linkPrimitiveA'.format(solver,3), 0)
cmds.setAttr('{}.link[{}].linkCapsuleA'.format(solver,3), 0)
cmds.setAttr('{}.link[{}].linkPrimitiveB'.format(solver,3), 3)
cmds.setAttr('{}.link[{}].linkCapsuleB'.format(solver,3), 0)

cmds.connectAttr('{}.HipsRWeight'.format(params), '{}.link[{}].linkWeight'.format(solver,4))
cmds.connectAttr('{}.HipsRRatio'.format(params), '{}.link[{}].linkABRatio'.format(solver,4))
cmds.connectAttr('{}.HipsROrientation'.format(params), '{}.link[{}].linkAOrientationRatio'.format(solver,4))
cmds.setAttr('{}.link[{}].linkPrimitiveA'.format(solver,4), 1)
cmds.setAttr('{}.link[{}].linkCapsuleA'.format(solver,4), 0)
cmds.setAttr('{}.link[{}].linkPrimitiveB'.format(solver,4), 3)
cmds.setAttr('{}.link[{}].linkCapsuleB'.format(solver,4), 0)
