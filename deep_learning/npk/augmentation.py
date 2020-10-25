import numpy as np
import posquat as pq
import transform as tr
import skeleton


def warp(skel : skeleton.Skeleton, anim, startpose, endpose):

    gpos, gquat = anim
    lpos, lquat = skel.global_to_local(anim)
    npos, nquat = np.zeros_like(gpos), np.zeros_like(gquat)

    indices = [skel.hipsid, skel.leftlegids[-1], skel.rightlegids[-1]]
    gsp, gsq = pq.sub((startpose[0][indices,...], startpose[1][indices,...]), (gpos[0, indices, ...], gquat[0, indices, ...]))
    gep, geq = pq.sub((endpose[0][indices,...], endpose[1][indices,...]), (gpos[-1, indices, ...], gquat[-1, indices, ...]))

    lstartoffset = pq.sub(skel.global_to_local(startpose), (lpos[0, ...], lquat[0, ...]))
    lendoffset = pq.sub(skel.global_to_local(endpose), (lpos[-1, ...], lquat[-1, ...]))

    lenanim = len(anim[0])

    hipsspeed = tr.compute_bone_speed(skel, anim, 'Model:Hips')
    lfspeed = tr.compute_bone_speed(skel, anim, 'Model:LeftFoot')
    rfspeed = tr.compute_bone_speed(skel, anim, 'Model:RightFoot')

    totalhips, totallf, totlarf = np.sum(hipsspeed), np.sum(lfspeed), np.sum(rfspeed)
    th, tlf, trf = 0, 0, 0

    for f in range(lenanim):
        t = float(f)/(lenanim-1)
        th += hipsspeed[f] / totalhips
        tlf += lfspeed[f] / totallf
        trf += rfspeed[f] / totlarf

        loffset = pq.lerp(lstartoffset, lendoffset, t)
        lpos[f, ...], lquat[f, ...] = pq.add((lpos[f, ...], lquat[f, ...]), loffset)

        goffh = pq.lerp((gsp[0], gsq[0]), (gep[0], geq[0]), th)
        gofflf = pq.lerp((gsp[1], gsq[1]), (gep[1], geq[1]), tlf)
        goffrf = pq.lerp((gsp[2], gsq[2]), (gep[2], geq[2]), trf)

        npos[f, indices[0], ...], nquat[f, indices[0], ...] = pq.add((gpos[f, indices[0], ...], gquat[f, indices[0], ...]), goffh)
        npos[f, indices[1], ...], nquat[f, indices[1], ...] = pq.add((gpos[f, indices[1], ...], gquat[f, indices[1], ...]), gofflf)
        npos[f, indices[2], ...], nquat[f, indices[2], ...] = pq.add((gpos[f, indices[2], ...], gquat[f, indices[2], ...]), goffrf)


    gpos, gquat = skel.local_to_global((lpos, lquat))
    #return gpos, gquat
    return skel.foot_ik(
        (npos[..., skel.hipsid, :], nquat[..., skel.hipsid, :]),
        (npos[..., skel.leftlegids[-1], :], nquat[..., skel.leftlegids[-1], :]),
        (npos[..., skel.rightlegids[-1], :], nquat[..., skel.rightlegids[-1], :]),
        (gpos, gquat)
    )


def stretch_displacement(skel : skeleton.Skeleton, anim, pos, quat):
    startpose = anim[0][0, ...], anim[1][0, ...]
    endpose = anim[0][-1, ...], anim[1][-1, ...]

    endpose = skel.global_to_local(endpose)
    endpose[0][0,...] += pos
    endpose[1][0, ...] = pq.quat_mul(quat, endpose[1][0, ...])
    endpose = skel.local_to_global(endpose)
    return warp(skel, anim, startpose, endpose)

