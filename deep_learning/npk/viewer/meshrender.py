import moderngl
import numpy as np


class SkinnedMeshRenderer(object):

    def __init__(self, ctx, vertices, indices, boneids, weights, skeleton):
        self.ctx = ctx
        self.skeleton = skeleton

        self.program = self.ctx.program(
            vertex_shader='''
                #version 430
                uniform mat4 Mvp;
                uniform mat4 Bones[32];

                in vec3 in_vert;
                in vec3 in_normal;

                in vec4 in_skinIndices;
                in vec4 in_skinWeights;

                out vec3 v_normal;
                void main() {

                    vec4 vert = vec4(in_vert , 1.0);
                    vec4 norm = vec4(in_normal , 0.0);
                    vec4 accumulated = vec4(0,0,0,1);
                    vec4 accumulatedN = vec4(0,0,0,0);

                    accumulated += Bones[int(in_skinIndices.x)] * vert * in_skinWeights.x;
                    accumulated += Bones[int(in_skinIndices.y)] * vert * in_skinWeights.y;
                    accumulated += Bones[int(in_skinIndices.z)] * vert * in_skinWeights.z;
                    accumulated += Bones[int(in_skinIndices.w)] * vert * in_skinWeights.w;
                    
                    accumulatedN += Bones[int(in_skinIndices.x)] * norm * in_skinWeights.x;
                    accumulatedN += Bones[int(in_skinIndices.y)] * norm * in_skinWeights.y;
                    accumulatedN += Bones[int(in_skinIndices.z)] * norm * in_skinWeights.z;
                    accumulatedN += Bones[int(in_skinIndices.w)] * norm * in_skinWeights.w;

                    gl_Position = Mvp * vec4(accumulated.xyz , 1.0);
                    v_normal = accumulatedN.xyz;
                }
            ''',
            fragment_shader='''
                #version 430
                in vec3 v_normal;
                out vec4 f_color;
                void main() {
                    float skyN = clamp(v_normal.y + 0.2, 0, 1);
                    float bounceN = clamp(-v_normal.y + 0.2, 0, 1);
                    float middle = clamp(1.0- (skyN+bounceN), 0,1);
                    vec3 sky_color = vec3(.6,.6,.7) * skyN;
                    vec3 middle_color = vec3(.4,.4,.3) * middle;
                    vec3 bounce_color = vec3(.2,.2,.2) * bounceN;
                    f_color = vec4(sky_color + bounce_color + middle_color, 1.0);
                }
            ''',
        )

        vbo = self.ctx.buffer(vertices.flatten().astype('f4'))
        ibo = self.ctx.buffer(indices)
        sibo = self.ctx.buffer(boneids.flatten().astype('i4'))
        swbo = self.ctx.buffer(weights.flatten().astype('f4'))

        self.vao = ctx.vertex_array(
            self.program,
            [
                (vbo, '3f4 3f4', 'in_vert', 'in_normal'),
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
