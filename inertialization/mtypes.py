import math

class Vector(object):
    
    @classmethod
    def zeros(cls, count):
        return cls([0] * count)
    
    @classmethod
    def ones(cls, count):
        return cls([1] * count)
    
    def __init__(self, values):
        self._values = values

    def copy(self):
        return self.__class__([x for x in self._values])
        
    def __add__(self, other):
        return self.__class__([ia + ib for ia,ib in zip(self._values, other._values)])
    
    def __sub__(self, other):
        return self.__class__([ia - ib for ia,ib in zip(self._values, other._values)])
    
    def dot(self, other):
        return sum([ia * ib for ia,ib in zip(self._values, other._values)])
    
    def scale(self, value):
        return self.__class__([ia * value for ia in self._values])
    
    def lengthSquare(self):
        return self.dot(self)
    
    def length(self):
        return math.sqrt(self.dot(self))
    
    def cross3(self, other):
        assert(len(self._values) == len(other._values) == 3 )
        
        return self.__class__([
            self._values[1] * other._values[2] - self._values[2] * other._values[1],
            -self._values[0] * other._values[2] + self._values[2] * other._values[0],
            self._values[0] * other._values[1] - self._values[1] * other._values[0]
        ])
    
    def normalize(self, tolerance=0.00001):
        mag2 = sum(n * n for n in self._values)
        if abs(mag2) > tolerance:
            mag = math.sqrt(mag2)
            return self.__class__([n / mag for n in self._values])
        return self.__class__([n for n in self._values])
    
    @classmethod
    def lerp(cls, a, b, t):
        return a.scale(1.0-t) + b.scale(t)
    
    def __repr__(self):
        return '[{}]'.format( ', '.join(['{:7.3f}'.format(c) for c in self._values]) )
    
    
    
class Matrix(object):
    
    @classmethod
    def zeros (cls, rows, cols):
        return cls([[0]*cols for i in range(rows)])

    @classmethod
    def identity (cls, rows):
        M = cls.zeros(rows, rows)
        for r in range(rows):
            M._values[r][r] = 1.0
        return M
    
    def __init__(self, values):
        self._values = values
        
    def copy (self):
        return self.__class__([[v for v in col] for col in self._values])
    
    def transpose(self):
        rowsA = len(self._values)
        colsA = len(self._values[0])
        return self.__class__( [[self._values[i][j] for i in range(rowsA)] for j in range(colsA)] )
    
    def scale(self, scale):
        return self.__class__([[v*scale for v in col] for col in self._values])

    def dot(self, other):
        rowsA = len(self._values)
        colsA = len(self._values[0])
        rowsB = len(other._values)
        colsB = len(other._values[0])

        if colsA != rowsB:
            raise Exception('Number of A columns must equal number of B rows.')

        C = self.__class__.zeros(rowsA, colsB)

        for i in range(rowsA):
            for j in range(colsB):
                C._values[i][j] = sum([self._values[i][k] * other._values[k][j] for k in range(colsA)])

        return C
    
    def inverse(self):
        rowsA = len(self._values)
        colsA = len(self._values[0])

        if rowsA != colsA:
            raise Exception('Matrix must be square')

        AM = self.copy()
        IM = self.__class__.identity(rowsA)

        for fd in range(rowsA):
            fdScaler = 1.0 / AM._values[fd][fd]
            for j in range(rowsA):
                AM._values[fd][j] *= fdScaler
                IM._values[fd][j] *= fdScaler
            for i in list(range(rowsA))[0:fd] + list(range(rowsA))[fd+1:]:
                crScaler = AM._values[i][fd]
                for j in range(rowsA):
                    AM._values[i][j] = AM._values[i][j] - crScaler * AM._values[fd][j]
                    IM._values[i][j] = IM._values[i][j] - crScaler * IM._values[fd][j]
        return IM
    
    def quaternion(self):
        return Quaternion.fromMatrix(self)
    
    def translation(self):
        return Vector(self._values[3][:3])
    
    def setQuaternion(self, q):
        m = q.matrix()
        self._values[0][:4] = m._values[0][:4]
        self._values[1][:4] = m._values[1][:4]
        self._values[2][:4] = m._values[2][:4]
        
    def setTranslation(self, v):
        self._values[3][:3] = v._values[:3]
    
    def __repr__(self):
        return '[' + '\n '.join([' '.join(['{:7.3}'.format(c) for c in row]) for row in self._values]) + ' ]'
    
    
class Quaternion(Vector):
    
    @classmethod
    def identity (cls):
        return cls([1.0, 0.0, 0.0, 0.0])
    
    def __mul__(self, other):
        if isinstance(other, self.__class__):
            w1, x1, y1, z1 = self._values
            w2, x2, y2, z2 = other._values
            w = w1 * w2 - x1 * x2 - y1 * y2 - z1 * z2
            x = w1 * x2 + x1 * w2 + y1 * z2 - z1 * y2
            y = w1 * y2 + y1 * w2 + z1 * x2 - x1 * z2
            z = w1 * z2 + z1 * w2 + x1 * y2 - y1 * x2
            return self.__class__([w, x, y, z])
        
        elif isinstance(other, Vector) and len(other._values) == 3:
            q2 = self.__class__([0] + other._values)
            return Vector(((self * q2) * self.conjugate())._values[1:])
        
        import traceback
        traceback.print_stack()
        raise Exception('unsupported multiplication {} * {}'.format(self, other))

    def conjugate(self):
        w, x, y, z = self._values
        return self.__class__([w, -x, -y, -z])
    
    
    @classmethod
    def lerp(cls, a, b, t):
        return (a.scale(1.0-t) + b.scale(t)).normalize()
    
    @classmethod
    def fromAxisAngle(cls, v, theta):
        v = v.normalize()
        x, y, z = v._values
        theta /= 2
        w = math.cos(theta)
        x = x * math.sin(theta)
        y = y * math.sin(theta)
        z = z * math.sin(theta)
        return cls([w, x, y, z])
    
    def axisAngle(self):
        w, v = self._values[0], Vector(self._values[1:])
        theta = math.acos(w) * 2.0
        return v.normalize(), theta
    
    @classmethod
    def fromMatrix(cls, M):
        a = M.transpose()._values
        Q = cls.identity()
        q = Q._values
        
        trace = a[0][0] + a[1][1] + a[2][2]

        if trace > 0:
            s = 0.5 / math.sqrt(trace + 1.0)
            q[0] = 0.25 / s
            q[1] = ( a[2][1] - a[1][2] ) * s
            q[2] = ( a[0][2] - a[2][0] ) * s
            q[3] = ( a[1][0] - a[0][1] ) * s
            
        else:
            if a[0][0] > a[1][1] and a[0][0] > a[2][2]:
                s = 2.0 * math.sqrt( 1.0 + a[0][0] - a[1][1] - a[2][2])
                q[0] = (a[2][1] - a[1][2] ) / s
                q[1] = 0.25 * s
                q[2] = (a[0][1] + a[1][0] ) / s
                q[3] = (a[0][2] + a[2][0] ) / s
            elif a[1][1] > a[2][2]:
                s = 2.0 * math.sqrt( 1.0 + a[1][1] - a[0][0] - a[2][2])
                q[0] = (a[0][2] - a[2][0] ) / s
                q[1] = (a[0][1] + a[1][0] ) / s
                q[2] = 0.25 * s
                q[3] = (a[1][2] + a[2][1] ) / s
            else:
                s = 2.0 * math.sqrt( 1.0 + a[2][2] - a[0][0] - a[1][1] )
                q[0] = (a[1][0] - a[0][1] ) / s
                q[1] = (a[0][2] + a[2][0] ) / s
                q[2] = (a[1][2] + a[2][1] ) / s
                q[3] = 0.25 * s  
        
        return Q
    
    def matrix(self):
        w, x, y, z = self._values
        xx = x ** 2
        xy = x * y
        xz = x * z
        xw = x * w
        yy = y ** 2
        yz = y * z
        yw = y * w
        zz = z ** 2
        zw = z * w
        M = Matrix.identity(4)
        M._values[0][0] = 1 - 2 * (yy + zz)
        M._values[0][1] = 2 * (xy - zw)
        M._values[0][2] = 2 * (xz + yw)
        M._values[1][0] = 2 * (xy + zw)
        M._values[1][1] = 1 - 2 * (xx + zz)
        M._values[1][2] = 2 * (yz - xw)
        M._values[2][0] = 2 * (xz - yw)
        M._values[2][1] = 2 * (yz + xw)
        M._values[2][2] = 1 - 2 * (xx + yy)
        return M.transpose()
    
    
class PosQuat(object):
    
    def __init__(self, p=Vector.zeros(3), q=Quaternion.identity()):
        self.p = p
        self.q = q

    def copy(self):
        return self.__class__(self.p.copy(), self.q.copy())
        
    def matrix(self):
        m = self.q.matrix()
        m.setTranslation(self.p)
        return m
    
    @classmethod
    def fromMatrix(cls, m):
        return cls(p=m.translation(), q=m.quaternion())
        
    def __repr__(self):
        return 'PosQuat(position={}, quaternion={})'.format(self.p, self.q)
    
    def __mul__(self, other):
        """
        'self' is the parent in world space, 'other' is the child in local space.
        this returns the child in world space
        ('other' is translated in 'self' space, then quaternions are multiplied)
        """
        p = self.q * other.p
        p += self.p
        q = self.q * other.q
        return self.__class__(p,q)
    
    def __add__(self, other):
        """
        'self' is world transformation, 'other' is world transform. 
        This returns the 'other' moved by 'self' in world
        ('self' and 'other' position are added and then the quaternion are multiplied)
        """
        return self.__class__( self.p + other.p, self.q * other.q )
    
    def __sub__(self, other):
        """
        Return the world transformation that transform 'self' into 'other'
        z = a - b
        b = z + a
        """
        p = other.p - self.p
        q = other.q * self.q.conjugate()
        return self.__class__(p,q)
                
    def inverse(self):
        q = self.q.conjugate()
        p = q * (Vector([0,0,0]) - self.p)
        return self.__class__(p,q)
    
    def transformPoint(self, point):
        p = self.q * point
        return self.p + p
    
    def transformVector(self, vect):
        return self.q * vect
    
    @classmethod
    def lerp(cls, a, b, t):
        return cls(Vector.lerp(a.p, b.p, t), Quaternion.lerp(a.q, b.q, t))
    
    

def determinant3(a, v1, v2):
    return a[0] * (v1[1] * v2[2] - v1[2] * v2[1]) + a[1] * (v1[2] * v2[0] - v1[0] * v2[2]) + a[2] * (v1[0] * v2[1] - v1[1] * v2[0])

        
def segments_distance(a0,a1,b0,b1):
    ''' Given two line segments defined by pairs (a0,a1,b0,b1)
        Return the two closest points and the lerp t value along each line.
    '''

    # Calculate denomitator
    A = a1 - a0
    B = b1 - b0

    Amagn = A.length()
    Bmagn = B.length()
    _A = A.scale( 1.0 / Amagn )
    _B = B.scale( 1.0 / Bmagn )
    cross = _A.cross3(_B)

    denom = cross.lengthSquare()

    # If denominator is 0, lines are parallel: 
    #there is a more complicated computation possible to find the real closest point depending of the end segments.
    #but for our process we can just discard that case for now
    if (denom == 0):
        return a0,b0,0,0

    # Lines criss-cross: Calculate the dereminent and return points
    t = (b0 - a0)
    det0 = determinant3(t._values, _B._values, cross._values)
    det1 = determinant3(t._values, _A._values, cross._values)

    t0 = det0/denom
    t1 = det1/denom

    pA = a0 + _A.scale(t0)
    pB = b0 + _B.scale(t1)

    # Clamp results to line segments
    st0 = t0
    st1 = t1
    if t0 < 0 :
        pA = a0
        st0 = 0
    elif t0 > Amagn :
        pA = a1
        st0 = Amagn
    
    if t1 < 0 :
        pB = b0
        st1 = 0
    elif t1 > Bmagn :
        pB = b1
        st1 = Bmagn
        
    #reproject clamped
    if t0 < 0 or t0 > Amagn:
        dot = _B.dot(pA-b0)
        st1 = min(Bmagn, max(0, dot))
        pB = b0 + _B.scale(st1)
        
    if t1 < 0 or t1 > Bmagn:
        dot = _A.dot(pB-a0)
        st0 = min(Amagn, max(0, dot))
        pA = a0 + _A.scale(st0)
        
    return pA, pB, st0/Amagn, st1/Bmagn

    
    
class Capsule(object):
    
    def __init__(self, pq, radius, length):
        self.pq = pq
        self.radius = radius
        self.length = length

    def copy(self):
        return self.__class__(self.pq.copy(), self.radius, self.length)

    def __repr__(self):
        return 'Capsule(pq={}, radius={}, length={})'.format(self.pq, self.radius, self.length)
        
    def distance(self, other):
        """
        Compute the distance between 2 capsules
        
        returns :
            the distance,
            the relative distance along the line segment of the self capsule
            the relative distance along the line segment of the other capsule
            the vector from the relative distance point on self capsule toward the other
            the vector from the relative distance point on other capsule toward the self
            the local posquat with the relation between the points on the surfaces of the self and the other capsules
        """
        selfstart = self.pq.transformPoint(Vector([-self.length*0.5,0,0]))
        selfend = self.pq.transformPoint(Vector([self.length*0.5,0,0]))
        otherstart = other.pq.transformPoint(Vector([-other.length*0.5,0,0]))
        otherend = other.pq.transformPoint(Vector([other.length*0.5,0,0]))
        
        #segment segment distance
        pt1, pt2, t1, t2 = segments_distance(selfstart, selfend, otherstart, otherend)

        #compute vector and distance
        vect = pt2-pt1
        distance = vect.length()
        
        if distance > 0.0001 :
            
            #compute local vector of each capsule
            vect = vect.scale(1.0/distance)
            vect1 = self.pq.inverse().transformVector(vect)
            vect2 = other.pq.inverse().transformVector(Vector([0,0,0])-vect)
            
            #compute point on the surface of each capsule
            pq1 = PosQuat(pt1 + vect.scale(self.radius), self.pq.q)
            pq2 = PosQuat(pt2 - vect.scale(other.radius), other.pq.q)
            
            #get the pq2 local to pq1
            localpq = pq1.inverse() * pq2
            
            return distance, t1, t2, vect1, vect2, localpq
        
        return 0,0,0, Vector([0,0,0]), Vector([0,0,0]), PosQuat()

    def localSurfacePosition(self, ratio, normal):
        """return the local point on the surface of the capsule using the ratio (start end of the height) and the normal
        
        Arguments:
            ratio {float} -- 0..1 ratio between the bottom and top of the capsule
            normal {vect3} -- the direction toward the surface starting from the point on the ratio
        
        Returns:
            vect3 -- the position
        """
        x = self.length * ( ratio - 0.5 )
        return Vector([x,0,0]) + normal.scale(self.radius)

    def globalSurfacePosition(self, ratio, normal):
        """return the point on the surface of the capsule using the ratio (start end of the height) and the normal transformed by the PosQuat
        
        Arguments:
            ratio {float} -- 0..1 ratio between the bottom and top of the capsule
            normal {vect3} -- the direction toward the surface starting from the point on the ratio
        
        Returns:
            vect3 -- the position
        """
        return self.pq.transformPoint(self.localSurfacePosition(ratio, normal))

            
        