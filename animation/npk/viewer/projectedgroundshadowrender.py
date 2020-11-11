import moderngl
import numpy as np


class SkinnedProjectedMeshRenderer(object):

    def __init__(self, ctx, vertices, indices, boneids, weights, skeleton):
        self.ctx = ctx
        self.skeleton = skeleton

        self.program = self.ctx.program(
            vertex_shader='''
                #version 430
                uniform mat4 Mvp;
                uniform mat4 Bones[32];

                in vec3 in_vert;

                in vec4 in_skinIndices;
                in vec4 in_skinWeights;

                void main() {

                    vec4 vert = vec4(in_vert , 1.0);
                    vec4 accumulated = vec4(0,0,0,1);

                    accumulated += Bones[int(in_skinIndices.x)] * vert * in_skinWeights.x;
                    accumulated += Bones[int(in_skinIndices.y)] * vert * in_skinWeights.y;
                    accumulated += Bones[int(in_skinIndices.z)] * vert * in_skinWeights.z;
                    accumulated += Bones[int(in_skinIndices.w)] * vert * in_skinWeights.w;

                    accumulated.y = 0;
                    
                    gl_Position = Mvp * vec4(accumulated.xyz , 1.0);
                }
            ''',
            fragment_shader='''
                #version 430

                out vec4 f_color;
                void main() {

                    f_color = vec4(.2, .2, .23, 1.0);
                    gl_FragDepth = 0.999;
                }
            ''',
        )

        positions_only = vertices[:, :3]

        vbo = self.ctx.buffer(positions_only.flatten().astype('f4'))
        ibo = self.ctx.buffer(indices)
        sibo = self.ctx.buffer(boneids.flatten().astype('i4'))
        swbo = self.ctx.buffer(weights.flatten().astype('f4'))

        self.vao = ctx.vertex_array(
            self.program,
            [
                (vbo, '3f4', 'in_vert'),
                (sibo, '4i4', 'in_skinIndices'),
                (swbo, '4f4', 'in_skinWeights')
            ],
            ibo
        )

    def render(self, mvp, globalBoneMatrices):
        skinpose = np.zeros([32, 4, 4])
        for i in range(len(self.skeleton.bindpose)):
            skinpose[i, :, :] = np.dot(self.skeleton.bindpose[i], globalBoneMatrices[i])

        self.program['Mvp'].write(mvp)
        self.program['Bones'].write((skinpose.flatten()).astype('f4'))

        self.vao.render(moderngl.TRIANGLES)
