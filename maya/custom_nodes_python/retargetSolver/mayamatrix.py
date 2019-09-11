import maya.api.OpenMaya as OpenMaya
import mtypes as t

def mayaToMatrix(mayam):
    return t.Matrix([[mayam[r*4+c] for c in range(4)] for r in range(4)])

def matrixToMaya(matrix):
    return OpenMaya.MMatrix(matrix._values)