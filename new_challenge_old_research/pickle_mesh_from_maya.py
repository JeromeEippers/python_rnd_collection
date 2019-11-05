obj = cmds.ls(sl=True)[0]
vertexCount = cmds.polyEvaluate( v=True )
faceCount = cmds.polyEvaluate( f=True )

indices = [
    [int(a[0]), int(a[1]), int(a[2])] for a in 
        [[x for x in str(( cmds.polyInfo('{}.f[{}]'.format(obj,f), faceToVertex=True) )[0]).split(' ') if x][2:5] 
        for f in range(faceCount)]
    ]
    
vertices = [cmds.xform('{}.vtx[{}]'.format(obj, v), q=True, t=True) for v in range(vertexCount)]

mesh = {'v':vertices,'i':indices}

import pickle
x = pickle.dumps(mesh)
with open(r'D:\Github\python_rnd_collection\new_challenge_old_research\mesh.dat', 'wb') as f:
    f.write(x)
