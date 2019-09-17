import mtypes as t


class CapsuleLink(object):

    def __init__(self, distance, ratioA, ratioB, normalA, normalB, relativePq):
        self.distance = distance
        self.ratioA = ratioA
        self.ratioB = ratioB
        self.normalA = normalA
        self.normalB = normalB
        self.relativePq = relativePq

    def __repr__(self):
        return """CapsuleLink(
            distance={}, 
            ratioA={}, 
            ratioB={},
            normalA={},
            normalB={},
            relativePq={}
        )""".format(self.distance, self.ratioA, self.ratioB, self.normalA, self.normalB, self.relativePq)

    @classmethod
    def gather(cls, capsuleA, capsuleB):
        return cls(*(capsuleA.distance(capsuleB)))


    def solve(self, capsuleA, capsuleB, weight=1.0, ABRatio=0.0, AOrientationRatio=1.0):

        A = t.PosQuat(capsuleA.globalSurfacePosition(self.ratioA, self.normalA), capsuleA.pq.q)
        B = t.PosQuat(capsuleB.globalSurfacePosition(self.ratioB, self.normalB), capsuleB.pq.q)

        resultA = capsuleA.pq.copy()
        resultB = capsuleB.pq.copy()

        #compute the target pq
        target = A * self.relativePq
        localATarget = capsuleA.pq.inverse() * target
        localB = capsuleB.pq.inverse() * B

        if ABRatio < 0.999 :
            #compute how we will move capsuleB so B matches the target
            resultB = target * (B.inverse() * capsuleB.pq)
            #if the ratio is not 1.0 we will move B a little then compute the motion we have to do on A to reach also the target            
            if ABRatio > 0.001 :
                resultB = t.PosQuat.lerp( capsuleB.pq, resultB, 1.0-ABRatio )

        if ABRatio > 0.001 :
            #compute how we will move primA so that target matches bPQ
            goalB = (resultB * localB)
            #check if we want to move only in translation or not 
            #in that case we change the goalB (to reach) to have the same orientation as what the target is already, so no rotation will happen
            if AOrientationRatio < 0.999:
                goalB = (resultB * localB)
                goalB.q = t.Quaternion.lerp(target.q, goalB.q, AOrientationRatio)
            resultA = goalB * ( target.inverse() * capsuleA.pq )
             
            #check that primA has been moved completly and not only on translation
            #otherwise we move back the primB to make sure we are solving the constraint
            if AOrientationRatio < 0.999:
                resultB = (resultA * localATarget) * ( B.inverse() * capsuleB.pq )

        #solve weights     
        resultA = t.PosQuat.lerp( capsuleA.pq, resultA, weight )    
        resultB = t.PosQuat.lerp( capsuleB.pq, resultB, weight )  

        return resultA, resultB

