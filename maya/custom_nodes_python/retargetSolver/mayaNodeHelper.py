
import maya.api.OpenMaya as OpenMaya
import mtypes as t
from mayamatrix import mayaToMatrix, matrixToMaya


def create_capsule_compound(classtype, name):
        mComp = OpenMaya.MFnCompoundAttribute()
        compound = mComp.create(name, name)
        mComp.array = False
        mComp.storable = True
        mComp.writable = True

        mAttr = OpenMaya.MFnMatrixAttribute()
        matrix = mAttr.create( name + "Matrix", name + "Matrix" )
        setattr(classtype, name + "Matrix", matrix)
        mAttr.array = False
        mAttr.storable = True
        mAttr.writable = True

        nAttr = OpenMaya.MFnNumericAttribute()
        radius = nAttr.create( name + "Radius", name + "Radius", OpenMaya.MFnNumericData.kDouble, 0.5 )
        setattr(classtype, name + "Radius", radius)
        nAttr.array = False
        nAttr.storable = True
        nAttr.writable = True

        nAttr = OpenMaya.MFnNumericAttribute()
        height = nAttr.create( name + "Height", name + "Height", OpenMaya.MFnNumericData.kDouble, 1.0 )
        setattr(classtype, name + "Height", height)
        nAttr.array = False
        nAttr.storable = True
        nAttr.writable = True

        classtype.addAttribute(matrix)
        classtype.addAttribute(radius)
        classtype.addAttribute(height)

        mComp.addChild(matrix)
        mComp.addChild(radius)
        mComp.addChild(height)

        classtype.addAttribute(compound)

        return compound



def get_capsule_datablock(classtype, name, dataBlock, pq=None):
    if pq == None:
        matrix = mayaToMatrix(dataBlock.inputValue( getattr(classtype, name+"Matrix" )).asMatrix())
        pq = t.PosQuat.fromMatrix(matrix)
    radius = dataBlock.inputValue( getattr(classtype, name+"Radius" )).asDouble()
    height = dataBlock.inputValue( getattr(classtype, name+"Height" )).asDouble()

    return t.Capsule(
        pq,
        radius,
        height
    )
