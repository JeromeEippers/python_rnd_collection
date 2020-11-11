import moderngl
import numpy as np


class AxisRender(object):
    def __init__(self, ctx, scale=10):
        self.ctx = ctx

        self.program = self.ctx.program(
            vertex_shader='''
                        #version 430
                        uniform mat4 Mvp;
                        in vec3 in_vert;
                        in vec3 in_color;
                        out vec3 v_color;    
                        void main() {
                            gl_Position = Mvp * vec4(in_vert, 1.0);
                            v_color = in_color;
                        }
                    ''',
            fragment_shader='''
                        #version 430
                        in vec3 v_color;
                        out vec4 f_color;
                        void main() {
                            f_color = vec4(v_color, 1.0);
                        }
                    ''',
        )

        vertices = np.array([
            # x, y ,z red, green, blue
            0, 0, 0, 1, 0, 0,
            scale, 0, 0, 1, 0, 0,
            0, 0, 0, 0, 1, 0,
            0, scale, 0, 0, 1, 0,
            0, 0, 0, 0, 0, 1,
            0, 0, scale, 0, 0, 1,
        ], dtype='f4')

        vbo = self.ctx.buffer(vertices)

        self.vao = self.ctx.vertex_array(
            self.program,
            [
                (vbo, '3f4 3f4', 'in_vert', 'in_color')
            ],
        )

    def render(self, mvp, globalBoneMatrices=None):
        if globalBoneMatrices is None:
            self.program['Mvp'].write(mvp)
            self.vao.render(moderngl.LINES)
        else:
            for b in globalBoneMatrices:
                self.program['Mvp'].write((mvp * b).astype('f4'))
                self.vao.render(moderngl.LINES)
