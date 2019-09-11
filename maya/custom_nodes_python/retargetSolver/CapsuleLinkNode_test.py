def capsule(name, radius, height):
    
    cyl = cmds.polyCylinder(n=name, r=radius, h=height, ax=[1,0,0], sx=10, sy=1, sz=1)[0]
    sph = cmds.polySphere(r=radius, sx=10, sy=10, ax=[1,0,0])[0]
    cmds.move(height*0.5, 0 ,0, sph)
    cmds.makeIdentity(sph, apply=True, t=1)
    cmds.parent(cmds.pickWalk(sph, d='down'), cyl, shape=True, add=True)
    cmds.delete(sph)
    sph = cmds.polySphere(r=radius, sx=10, sy=10, ax=[1,0,0])[0]
    cmds.move(-height*0.5, 0 ,0, sph)
    cmds.makeIdentity(sph, apply=True, t=1)
    cmds.parent(cmds.pickWalk(sph, d='down'), cyl, shape=True, add=True)
    cmds.delete(sph)
    
    return cyl
    
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
    
ia = [1.0, 2.0]
ib = [0.2, 0.5]
oa = [1.0, 2.0]
ob = [0.2, 0.5]
    

inputA = controlableCapsule("inputA", *ia)
inputB = controlableCapsule("inputB", *ib)

outputA = controlableCapsule("outputA", *oa)
outputB = controlableCapsule("outputB", *ob)
dmoutputA = cmds.shadingNode('decomposeMatrix', asUtility=True)
dmoutputB = cmds.shadingNode('decomposeMatrix', asUtility=True)

cmds.move(3,0,0,inputB)
cmds.move(3,0,0,outputB)

rootA = cmds.createNode('transform', n="src")
cmds.addAttr(rootA,ln="weight", at='double', dv=1, min=0, max=1, k=True)
cmds.addAttr(rootA,ln="abRatio", at='double', dv=0, min=0, max=1, k=True)
cmds.addAttr(rootA,ln="aOrientationRatio", at='double', dv=1, min=0, max=1, k=True)
rootB = cmds.createNode('transform', n="dst")
cmds.parent([inputA, inputB], rootA)
cmds.parent([outputA, outputB], rootB)

cmds.move(0,0,5, rootB)

link = cmds.createNode("CapsuleLinkNode")

cmds.connectAttr('{}.matrix'.format(inputA), '{}.inputCapsuleAMatrix'.format(link))
cmds.connectAttr('{}.radius'.format(inputA), '{}.inputCapsuleARadius'.format(link))
cmds.connectAttr('{}.height'.format(inputA), '{}.inputCapsuleAHeight'.format(link))
cmds.connectAttr('{}.matrix'.format(inputB), '{}.inputCapsuleBMatrix'.format(link))
cmds.connectAttr('{}.radius'.format(inputB), '{}.inputCapsuleBRadius'.format(link))
cmds.connectAttr('{}.height'.format(inputB), '{}.inputCapsuleBHeight'.format(link))

cmds.connectAttr('{}.weight'.format(rootA), '{}.weight'.format(link))
cmds.connectAttr('{}.abRatio'.format(rootA), '{}.abRatio'.format(link))
cmds.connectAttr('{}.aOrientationRatio'.format(rootA), '{}.aOrientationRatio'.format(link))

cmds.connectAttr('{}.radius'.format(outputA), '{}.outputCapsuleARadius'.format(link))
cmds.connectAttr('{}.height'.format(outputA), '{}.outputCapsuleAHeight'.format(link))
cmds.connectAttr('{}.radius'.format(outputB), '{}.outputCapsuleBRadius'.format(link))
cmds.connectAttr('{}.height'.format(outputB), '{}.outputCapsuleBHeight'.format(link))

cmds.connectAttr('{}.outputA'.format(link), '{}.inputMatrix'.format(dmoutputA))
cmds.connectAttr('{}.outputTranslate'.format(dmoutputA), '{}.translate'.format(outputA))
cmds.connectAttr('{}.outputRotate'.format(dmoutputA), '{}.rotate'.format(outputA))
cmds.connectAttr('{}.outputB'.format(link), '{}.inputMatrix'.format(dmoutputB))
cmds.connectAttr('{}.outputTranslate'.format(dmoutputB), '{}.translate'.format(outputB))
cmds.connectAttr('{}.outputRotate'.format(dmoutputB), '{}.rotate'.format(outputB))
