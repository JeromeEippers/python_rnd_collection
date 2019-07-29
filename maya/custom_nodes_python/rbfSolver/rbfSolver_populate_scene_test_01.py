import random
import math

#def mode
plugPath = r"/home/jeromee/development/local_dev/GitHub/python_rnd_collection/maya/custom_nodes_python/rbfSolver/rbfSolver.py"
if plugPath :
    try:
        cmds.unloadPlugin(plugPath)
    except Exception:
        pass
    cmds.loadPlugin(plugPath)
    
    
#EUCLIDIAN DISTANCE ---------------------------

solver = cmds.createNode('RBFSolver')
cmds.setAttr ("{}.sigma".format(solver), 10)

for i in range(12):

    sh = cmds.shadingNode('lambert', asShader=True)
    cmds.setAttr('{}.color'.format(sh), random.random() , random.random() , random.random())
    
    node = cmds.polySphere(r=0.05)[0]
    cmds.move(random.random()*2-1 + 5 , random.random() , random.random()*2-1, node )
    cmds.select( node )
    cmds.hyperShade( assign=sh )
    
    cmds.setAttr("{}.centers[{}]".format(solver,i), *cmds.getAttr('{}.translate'.format(node))[0])
    cmds.setAttr("{}.values[{}]".format(solver,i), *cmds.getAttr('{}.color'.format(sh))[0])
    
    
sh = cmds.shadingNode('lambert', asShader=True)
node = cmds.polyCube(d=0.1,h=0.1,w=0.1)[0]
cmds.move(5, 0,0, node )
cmds.select( node )
cmds.hyperShade( assign=sh )
cmds.connectAttr('{}.translate'.format(node), '{}.input'.format(solver))
cmds.connectAttr( '{}.output'.format(solver), '{}.color'.format(sh))


#ANGULAR DISTANCE ---------------------------
#careful with this, to work properly the inputs needs to relative to the center of the defining sphere
#in our case we build everything around 0 0 0 so this is done for us.

node = cmds.polySphere(r=1)[0]
sh = cmds.shadingNode('lambert', asShader=True)
cmds.setAttr('{}.color'.format(sh), 0,0,0)
cmds.select( node )
cmds.hyperShade( assign=sh )

solver = cmds.createNode('RBFSolver')
cmds.setAttr ("{}.sigma".format(solver), 10)
cmds.setAttr ("{}.distance".format(solver), 1)

for i in range(24):

    sh = cmds.shadingNode('lambert', asShader=True)
    cmds.setAttr('{}.color'.format(sh), random.random() , random.random() , random.random())
    
    theta = random.random()*3.1415*2
    phi = random.random()*3.1415*2
    x = math.sin(theta) * math.cos(phi)
    y = math.sin(theta) * math.sin(phi)
    z = math.cos(theta)
    
    node = cmds.polySphere(r=0.05)[0]
    cmds.move(x,y,z, node )
    cmds.select( node )
    cmds.hyperShade( assign=sh )
    
    cmds.setAttr("{}.centers[{}]".format(solver,i), *cmds.getAttr('{}.translate'.format(node))[0])
    cmds.setAttr("{}.values[{}]".format(solver,i), *cmds.getAttr('{}.color'.format(sh))[0])
    
sh = cmds.shadingNode('lambert', asShader=True)
node = cmds.polyCube(d=0.1,h=0.1,w=0.1)[0]
cmds.move(0, 1, 0, node )
cmds.select( node )
cmds.hyperShade( assign=sh )
cmds.connectAttr('{}.translate'.format(node), '{}.input'.format(solver))
cmds.connectAttr( '{}.output'.format(solver), '{}.color'.format(sh))
