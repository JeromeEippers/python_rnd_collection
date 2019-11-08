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
    print bone
    m = cmds.xform(bone, matrix=True, q=True)
    sb = DataBone(len(skeleton._bones), parent, bone, m)
    skeleton._bones.append(sb)
    for child in [x for x in cmds.listRelatives(bone, children=True, type='transform', shapes=False) or [] if x]:
        if cmds.nodeType(child) != 'joint':
            
            print ('anchor', child)
            m = cmds.xform(child, matrix=True, q=True)
            anch = DataBone(len(skeleton._anchors), sb._id, 'anchor', m)
            skeleton._anchors.append(anch)
            
    for child in [x for x in cmds.listRelatives(bone, children=True, type='joint') or [] if x]:
        build_skeleton(child, sb._id)
    

build_skeleton( 'BaseSkeleton', -1 )

import pickle
x = pickle.dumps(skeleton)
with open(r'D:\Github\python_rnd_collection\new_challenge_old_research\skeleton.dat', 'wb') as f:
    f.write(x)
    