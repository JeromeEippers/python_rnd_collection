import random

#def mode
plugPath = r"/home/jeromee/development/local_dev/GitHub/python_rnd_collection/maya/custom_nodes_python/rbfSolver.py"
if plugPath :
    cmds.unloadPlugin(plugPath)
    cmds.loadPlugin(plugPath)
    

solver = cmds.createNode('jeRBFSolver')

for i in range(12):

    sh = cmds.shadingNode('lambert', asShader=True)
    cmds.setAttr('{}.color'.format(sh), random.random() , random.random() , random.random())
    
    node = cmds.polySphere(r=0.25)[0]
    cmds.move(random.random()*10-5 , random.random()*2 , random.random()*10-5, node )
    cmds.select( node )
    cmds.hyperShade( assign=sh )
    
    cmds.setAttr("{}.centers[{}]".format(solver,i), *cmds.getAttr('{}.translate'.format(node))[0])
    cmds.setAttr("{}.values[{}]".format(solver,i), *cmds.getAttr('{}.color'.format(sh))[0])
    
    
sh = cmds.shadingNode('lambert', asShader=True)
node = cmds.polyCube()[0]
cmds.select( node )
cmds.hyperShade( assign=sh )
cmds.connectAttr('{}.translate'.format(node), '{}.input'.format(solver))
cmds.connectAttr( '{}.output'.format(solver), '{}.color'.format(sh))