import math, sys
import maya.OpenMaya as OpenMaya
import maya.OpenMayaMPx as OpenMayaMPx
kPluginNodeTypeName = "jeRBFSolver"
rbfNodeId = OpenMaya.MTypeId(0x8800)


"""MATRIX MATH"""
def zeros (rows, cols):
    return [[0]*cols for i in range(rows)];


def identity (rows):
    M = zeros(rows, rows)
    for r in range(rows):
        M[r][r] = 1.0
    return M


def copyMatrix (M):
    return [[v for v in col] for col in M]


def transpose(A):
    rowsA = len(A)
    colsA = len(A[0])
    
    return [[A[i][j] for i in range(rowsA)] for j in range(colsA)]

def scale(A, scale):
    return [[v*scale for v in col] for col in A]

def dot(A, B):
    rowsA = len(A)
    colsA = len(A[0])
    rowsB = len(B)
    colsB = len(B[0])
    
    if colsA != rowsB:
        raise Exception('Number of A columns must equal number of B rows.')
    
    C = zeros(rowsA, colsB)
    
    for i in range(rowsA):
        for j in range(colsB):
            C[i][j] = sum([A[i][k] * B[k][j] for k in range(colsA)])
            
    return C


def inverse(A):
    rowsA = len(A)
    colsA = len(A[0])
    
    if rowsA != colsA:
        raise Exception('Matrix must be square')
    
    AM = copyMatrix(A)
    IM = identity(rowsA)
    
    for fd in range(rowsA):
        fdScaler = 1.0 / AM[fd][fd]
        for j in range(rowsA):
            AM[fd][j] *= fdScaler
            IM[fd][j] *= fdScaler
        for i in list(range(rowsA))[0:fd] + list(range(rowsA))[fd+1:]:
            crScaler = AM[i][fd]
            for j in range(rowsA):
                AM[i][j] = AM[i][j] - crScaler * AM[fd][j]
                IM[i][j] = IM[i][j] - crScaler * IM[fd][j]
    return IM

def solve(A, b):
    Inv = inverse(A)
    return dot(Inv, b)


"""VECTOR MATH"""
import math

def vAdd(a,b):
    return [ia + ib for ia,ib in zip(a,b)]

def vSub(a,b):
    return [ia + ib for ia,ib in zip(a,b)]

def vScale(a, scale):
    return [ia * scale for ia in a]

def vDot(a,b):
    return sum([ia * ib for ia,ib in zip(a,b)])

def vLength(a):
    return math.sqrt(vDot(a,a))

def vNormalize(a):
    return vScale(a, 1.0/vLength(a))


"""RBF"""
def gaussian(x, sigma=1):
    return math.exp(-x * x / math.pow(sigma, 2.0))

def multiQuadratic(x, sigma=1):
    return math.sqrt(1+ (x*sigma)**2)

def inverseQuadratic(x, sigma=1):
    return 1.0 / (1.0 + (x*sigma)**2)

def inverseMultiQuadratic(x, sigma=1):
    return 1.0 / math.sqrt(1.0 + (x*sigma)**2)

def thinPlate(r):
    return r * r * math.log(max(1e-8, r))


def normDist(va, vb):
    return vLength(vSub(va,vb))

def dotDist(va, vb):
    d = vDot(vNormalize(va), vNormalize(vb))
    if d < 0:
        d = 1.0 - d
    return d

class RBF (object):
    
    def __init__(self, centers, values, distfunc, kernelfunc ):
        """ 
        centers {matrix} : the list of coordinates
        values {matrix} : the list of values for each center
        distfunc {function} : the method used to compute the distance between centers
        kernelfunc {function} : the method used to compute the kernel value
        """
        count = len(centers)
        Phi = zeros(count, count)
        for i in range(count):
            for j in range(i, count):
                dist = distfunc(centers[i], centers[j])
                Phi[i][j] = Phi[j][i] = kernelfunc(dist)
                
        A = Phi
        b = values
                
        self.centers = centers
        self.values = values
        self.dist = distfunc
        self.kernel = kernelfunc
        self.coeffs = solve(A, b)
        
    def evaluate(self, centers):
        """
        centers {matrix} : the list of coordinates we want to evaluate
        """
        Phi = [
            [self.kernel(self.dist(value, center)) for center in self.centers]
            for value in centers
        ]
        return dot(Phi, self.coeffs)




# Node definition
class RbfSolver(OpenMayaMPx.MPxNode):
    # class variables
    inputCenters = OpenMaya.MObject()
    inputValues = OpenMaya.MObject()
    inputEval = OpenMaya.MObject()
    inputSigma = OpenMaya.MObject()
    inputKernel = OpenMaya.MObject()
    inputDistance = OpenMaya.MObject()
    inputForceUpdate = OpenMaya.MObject()
    output = OpenMaya.MObject()
    
    def __init__(self):
        OpenMayaMPx.MPxNode.__init__(self)
        self._rbf = None

    def shouldSave(self):
        return True
        
    def compute(self, plug, dataBlock):
        if ( plug == RbfSolver.output ):
            recompute = dataBlock.inputValue( RbfSolver.inputForceUpdate ).asBool()

            if self._rbf == None or recompute:
                self._rbf = None

                centers = dataBlock.inputArrayValue( RbfSolver.inputCenters )
                values = dataBlock.inputArrayValue( RbfSolver.inputValues )

                
                if centers.elementCount() == values.elementCount():

                    centersmatrix = []
                    valuesmatrix = []

                    kernel = dataBlock.inputValue( RbfSolver.inputKernel ).asInt()
                    dist = dataBlock.inputValue( RbfSolver.inputDistance ).asInt()
                    sigma = dataBlock.inputValue( RbfSolver.inputSigma ).asDouble()
                    gaussParam = max(0.1, sigma)

                    for ci in range(centers.elementCount()):
                        centers.jumpToElement(ci)
                        values.jumpToElement(ci)
                        centersmatrix.append ( list(centers.inputValue().asDouble3()) )
                        valuesmatrix.append ( list(values.inputValue().asDouble3()) )

                    if centersmatrix:

                        kernelFunction = lambda x:gaussian(x, sigma)
                        if kernel == 1:
                            kernelFunction = lambda x:multiQuadratic(x, sigma)
                        if kernel == 2:
                            kernelFunction = lambda x:inverseQuadratic(x, sigma)
                        if kernel == 3:
                            kernelFunction = lambda x:inverseMultiQuadratic(x, sigma)
                        if kernel == 4:
                            kernelFunction = lambda x:thinPlate(x)

                        distfunction = normDist
                        if dist == 1:
                            distfunction = dotDist

                        self._rbf = RBF(centersmatrix, valuesmatrix, distfunction, kernelFunction )

            if self._rbf :
                center = [list(dataBlock.inputValue( RbfSolver.inputEval ).asDouble3())]
                result = self._rbf.evaluate(center)

                outputHandle = dataBlock.outputValue( RbfSolver.output )
                outputHandle.set3Double( *result[0] )
                        
        
            dataBlock.setClean( plug )

# creator
def nodeCreator():
    return OpenMayaMPx.asMPxPtr( RbfSolver() )
    
# initializer
def nodeInitializer():
    # input
    nAttr = OpenMaya.MFnNumericAttribute()
    RbfSolver.inputCenters = nAttr.create( "centers", "cin", OpenMaya.MFnNumericData.k3Double, 0.0 )
    nAttr.setArray(1)
    nAttr.setStorable(1)

    nAttr = OpenMaya.MFnNumericAttribute()
    RbfSolver.inputValues = nAttr.create( "values", "vin", OpenMaya.MFnNumericData.k3Double, 0.0 )
    nAttr.setArray(1)
    nAttr.setStorable(1)

    nAttr = OpenMaya.MFnNumericAttribute()
    RbfSolver.inputEval = nAttr.create( "input", "in", OpenMaya.MFnNumericData.k3Double, 0.0 )
    nAttr.setStorable(1)

    nAttr = OpenMaya.MFnNumericAttribute()
    RbfSolver.inputForceUpdate = nAttr.create( "update", "update", OpenMaya.MFnNumericData.kBoolean, 0.0 )
    nAttr.setStorable(1)

    nAttr = OpenMaya.MFnNumericAttribute()
    RbfSolver.inputSigma = nAttr.create( "sigma", "sig", OpenMaya.MFnNumericData.kDouble, 1.0 )
    nAttr.setStorable(1)

    enAttr = OpenMaya.MFnEnumAttribute()
    RbfSolver.inputKernel = enAttr.create( "kernel", "k", 0 )
    enAttr.addField('Gaussian', 0)
    enAttr.addField('Multi Quadratic', 1)
    enAttr.addField('Inverse Quadratic', 2)
    enAttr.addField('Inverse Multi Quadratic', 3)
    enAttr.addField('Thin Plate', 4)
    enAttr.setStorable(1)

    enAttr = OpenMaya.MFnEnumAttribute()
    RbfSolver.inputDistance = enAttr.create( "distance", "dis", 0 )
    enAttr.addField('euclidian distance', 0)
    enAttr.addField('angular distance', 1)
    enAttr.setStorable(1)


    # output
    nAttr = OpenMaya.MFnNumericAttribute()
    RbfSolver.output = nAttr.create( "output", "out", OpenMaya.MFnNumericData.k3Double, 0.0 )
    nAttr.setStorable(1)
    nAttr.setWritable(1)
    # add attributes
    RbfSolver.addAttribute( RbfSolver.inputCenters )
    RbfSolver.addAttribute( RbfSolver.inputValues )
    RbfSolver.addAttribute( RbfSolver.inputEval )
    RbfSolver.addAttribute( RbfSolver.inputForceUpdate )
    RbfSolver.addAttribute( RbfSolver.inputSigma )
    RbfSolver.addAttribute( RbfSolver.inputKernel )
    RbfSolver.addAttribute( RbfSolver.inputDistance )
    RbfSolver.addAttribute( RbfSolver.output )
    RbfSolver.attributeAffects( RbfSolver.inputCenters, RbfSolver.output )
    RbfSolver.attributeAffects( RbfSolver.inputValues, RbfSolver.output )
    RbfSolver.attributeAffects( RbfSolver.inputEval, RbfSolver.output )
    RbfSolver.attributeAffects( RbfSolver.inputSigma, RbfSolver.output )
    RbfSolver.attributeAffects( RbfSolver.inputKernel, RbfSolver.output )
    RbfSolver.attributeAffects( RbfSolver.inputDistance, RbfSolver.output )
    RbfSolver.attributeAffects( RbfSolver.inputForceUpdate, RbfSolver.output )
    
# initialize the script plug-in
def initializePlugin(mobject):
    mplugin = OpenMayaMPx.MFnPlugin(mobject)
    try:
        mplugin.registerNode( kPluginNodeTypeName, rbfNodeId, nodeCreator, nodeInitializer )
    except:
        sys.stderr.write( "Failed to register node: %s" % kPluginNodeTypeName )
        raise
        
# uninitialize the script plug-in
def uninitializePlugin(mobject):
    mplugin = OpenMayaMPx.MFnPlugin(mobject)
    try:
        mplugin.deregisterNode( rbfNodeId )
    except:
        sys.stderr.write( "Failed to register node: %s" % kPluginNodeTypeName )
        raise