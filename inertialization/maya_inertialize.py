def inertialize(x0, v0, t1, t):
    
    #check if the velocity is going toward reaching 0 or not
    if v0 >= 0:
        v0 = 0
    else:
        t1adjusted = -5.0*x0/v0
        if t1adjusted > 0:
            t1 = min(t1, t1adjusted)
    t = min(t,t1)
            
    #compute the acceleration
    a0 = max((-8.0*v0*t1 - 20.0*x0)/(t1*t1),0)

    #compute the factors of the polynomial
    A = -(a0*t1*t1 + 6.0*v0*t1 + 12.0*x0)/(2.0*t1*t1*t1*t1*t1)
    B = (3.0*a0*t1*t1 + 16.0*v0*t1 + 30.0*x0)/(2.0*t1*t1*t1*t1)
    C = -(3.0*a0*t1*t1 + 12.0*v0*t1 +20.0*x0)/(2.0*t1*t1*t1)
    
    xt = A*t*t*t*t*t + B*t*t*t*t + C*t*t*t + a0*0.5*t*t + v0*t + x0 
    return xt
    
    
def inertialize_vector(previous, current, target, dt, blendTime, t):
    vx0 = current - target
    vxm1 = previous - target
    
    x0 = vx0.length()
    if x0 < 0.01:
        return target
    
    vx0_dir = vx0.normalize()

    xm1 = vxm1.dot(vx0_dir)
    v0 = (x0 - xm1) / dt
    
    xt = inertialize(x0, v0, blendTime, t)
    
    result = target + vx0_dir.scale(xt)
    #print(previous,current, target, vx0, vxm1, x0, v0, xt, result)
    
    return result



def inertialize_quaternion(previous, current, target, dt, blendTime, t):
    
    if previous.dot(current) < 0:
        current = current.scale(-1)
    if previous.dot(target) < 0:
        target = target.scale(-1)
    
    q0 = current * target.conjugate()
    q1 = previous * target.conjugate()
     
    vx0, x0 = q0.normalize().axisAngle()
 
    xm1 = 2* math.atan(Vector(q1._values[1:4]).dot(vx0) / q1._values[0])
    
    v0 = (x0 - xm1) / dt
    
    xt = inertialize(x0, v0, blendTime, t)
    return (Quaternion.fromAxisAngle(vx0, xt) * target).normalize()
    
    
    
class BodyPart(object):
    
    class BlendType(object):
        WORLD = 0
        LOCAL = 1
        WORLD_TR = 2
        
    class Bone(object):
        def __init__(self, name):
            self.name = name
            self.tm2 = PosQuat()
            self.tm1 = PosQuat()
            self.target = PosQuat()
            self.localTr = cmds.xform(name, q=True, t=True, ws=False)
            
            
    def __init__(self, blendType, blendFrame, boneNames):
        self.blendType = blendType
        self.bones = [self.Bone(b) for b in boneNames]
        self.blendFrame = blendFrame
        
    def _get_pq(self, name):
        if self.blendType == self.__class__.BlendType.LOCAL:
            m = cmds.xform(name, q=True, m=True, ws=False)
        else:
            m = cmds.xform(name, q=True, m=True, ws=True)
        m = Matrix([m[0:4],m[4:8],m[8:12],m[12:16]])
        return PosQuat.fromMatrix(m)
        
    def _set_pq(self, name, pq, localTr):
        m = pq.matrix()
        matrix = m._values[0] + m._values[1] + m._values[2] + m._values[3]
        if self.blendType == self.__class__.BlendType.LOCAL:
            cmds.xform(name, m=matrix, ws=False)
        else:
            cmds.xform(name, m=matrix, ws=True)
            if self.blendType == self.__class__.BlendType.WORLD: 
                cmds.xform(name, t=localTr, ws=False)
        
    def gather_tm2(self):
        for bone in self.bones:
            bone.tm2 = self._get_pq(bone.name)
            
    def gather_tm1(self):
        for bone in self.bones:
            bone.tm1 = self._get_pq(bone.name)
            
    def gather_target(self):
        for bone in self.bones:
            bone.target = self._get_pq(bone.name)
            
    def inertialize(self, t1, t):
        for bone in self.bones:
            p = inertialize_vector(bone.tm2.p, bone.tm1.p, bone.target.p, 1.0/30.0, t1, t)
            q = inertialize_quaternion(bone.tm2.q, bone.tm1.q, bone.target.q, 1.0/30.0, t1, t)
            bone.target = PosQuat(p=p, q=q)
            
    def key(self):
        for bone in self.bones:
            self._set_pq(bone.name, bone.target, bone.localTr)
        cmds.setKeyframe([b.name for b in self.bones], at='translate')
        cmds.setKeyframe([b.name for b in self.bones], at='rotate')
            
            
            
def inertialize_animation(discontinuityFrame, nextdiscontinuityFrame, bodyParts):
    
    #gather values
    cmds.currentTime(discontinuityFrame-2)
    for bp in bodyParts:
        bp.gather_tm2()
        
    cmds.currentTime(discontinuityFrame-1)
    for bp in bodyParts:
        bp.gather_tm1()
        
        
    startFrame = discontinuityFrame
    endFrame = discontinuityFrame + max(bp.blendFrame for bp in bodyParts)
        
    
        
    for frame in range(startFrame, endFrame):
        if frame >= nextdiscontinuityFrame:
            break
            
        t = float(frame-startFrame+1)/30.0
        
        
        cmds.currentTime(frame)
        
        #get targets
        for bp in bodyParts:
            bp.gather_target()
            
        #inertialize
        for bp in bodyParts:
            t1 = float(bp.blendFrame)/30.0
            
            bp.inertialize(t1, t)
            bp.key()


root = BodyPart(BodyPart.BlendType.WORLD_TR, 7, [
    "Greyman:Hips"
])
spine = BodyPart(BodyPart.BlendType.WORLD, 5, [
    "Greyman:Spine",
    "Greyman:Spine1",
    "Greyman:Spine2",
    "Greyman:Neck"
])
head = BodyPart(BodyPart.BlendType.WORLD, 5, [
    "Greyman:Neck1",
    "Greyman:Head"
])
left_arm = BodyPart(BodyPart.BlendType.LOCAL, 4, [
    "Greyman:LeftClavicle",
    "Greyman:LeftArm",
    "Greyman:LeftForeArm",
    "Greyman:LeftHand"
])
right_arm = BodyPart(BodyPart.BlendType.LOCAL, 4, [
    "Greyman:RightClavicle",
    "Greyman:RightArm",
    "Greyman:RightForeArm",
    "Greyman:RightHand"
])
left_leg = BodyPart(BodyPart.BlendType.LOCAL, 7, [
    "Greyman:LeftUpLeg",
    "Greyman:LeftLeg",
    "Greyman:LeftFoot",
    "Greyman:LeftFootToes"
])
right_leg = BodyPart(BodyPart.BlendType.LOCAL, 7, [
    "Greyman:RightUpLeg",
    "Greyman:RightLeg",
    "Greyman:RightFoot",
    "Greyman:RightFootToes"
])

#inertialize_animation(9, 100, [root, spine, head, left_arm, right_arm, left_leg, right_leg])
