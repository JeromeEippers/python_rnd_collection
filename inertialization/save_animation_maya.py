import pickle

bones = [
    "Hips",
    "LeftUpLeg",
    "LeftLeg",
    "LeftFoot",
    "LeftToeBase",
    "RightUpLeg",
    "RightLeg",
    "RightFoot",
    "RightToeBase",
    "Spine",
    "Spine1",
    "LeftShoulder",
    "LeftArm",
    "LeftForeArm",
    "LeftHand",
    "RightShoulder",
    "RightArm",
    "RightForeArm",
    "RightHand",
    "Neck",
    "Head"
]


def save_animation(path, startframe, endframe):
    
    export = []
    
    for bone in bones:
        
        keys = []
        
        for frame in range(startframe, endframe+1):
            cmds.currentTime(frame)
            
            key = cmds.xform(bone, m=True, q=True)
            
            keys.append(key)
            
        export.append((bone, keys))
        
    s = pickle.dumps(export)
    with open(path, 'wb') as f:
        f.write(s)
            
            
            
save_animation(r"C:\Users\jerom\Documents\Projects\Personal\python_rnd_collection\inertialization\wave.dat",0,60)          
print ("done")