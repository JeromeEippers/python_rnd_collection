class DataBone(object):
    
    def __init__(self, id, parentId, name, matrix):
        self._id = id
        self._parentId = parentId
        self._name = name
        self._matrix = matrix
        
    def __repr__(self):
        return "bone:{} name:{} parent:{}".format(self._id, self._name, self._parentId )
        
        
class DataSkeleton(object):
    
    def __init__(self):
        self._bones = []
        self._anchors = []
    

skeleton = DataSkeleton()

def build_skeleton(bone, parent):
    name = bone.split(':')[-1].split('|')[-1]
    print('bone', name)
    m = cmds.xform(bone, matrix=True, q=True)
    print(m)
    sb = DataBone(len(skeleton._bones), parent, name, m)
    skeleton._bones.append(sb)
    for child in [x for x in cmds.listRelatives(bone, children=True, type='transform', shapes=False, fullPath=True) or [] if x]:
        if cmds.nodeType(child) != 'joint':
            name = child.split(':')[-1].split('|')[-1]
            print ('anchor', name)
            m = cmds.xform(child, matrix=True, q=True)
            anch = DataBone(len(skeleton._anchors), sb._id, 'anchor', m)
            skeleton._anchors.append(anch)
            
    for child in [x for x in cmds.listRelatives(bone, children=True, type='joint', fullPath=True) or [] if x]:
        build_skeleton(child, sb._id)
    

build_skeleton( 'RhinoAligned:Rhino_Base', -1 )

import pickle
x = pickle.dumps(skeleton)
with open(r'D:\Github\python_rnd_collection\new_challenge_old_research\skeleton_retarget_rhinoAligned.dat', 'wb') as f:
    f.write(x)
    