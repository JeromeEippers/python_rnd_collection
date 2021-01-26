import moderngl
import numpy as np


class LineRender(object):
    def __init__(self, ctx):
        self.ctx = ctx

        self.program = self.ctx.program(
            vertex_shader='''
                        #version 430
                        uniform mat4 Mvp;
                        uniform vec3 Pos_a;
                        uniform vec3 Pos_b;
                        in vec3 in_vert;
                        void main() {
                            gl_Position = Mvp * vec4(
                                in_vert * Pos_b + (vec3(1,1,1) - in_vert) * Pos_a,
                                1);
                        }
                    ''',
            fragment_shader='''
                        #version 430
                        uniform vec3 Color;
                        out vec4 f_color;
                        void main() {
                            f_color = vec4(Color , 1);
                        }
                    ''',
        )

        vertices = np.array([
            # x, y ,z
            0, 0, 0, 1, 1, 1,
        ], dtype='f4')

        vbo = self.ctx.buffer(vertices)

        self.vao = self.ctx.vertex_array(
            self.program,
            [
                (vbo, '3f4', 'in_vert')
            ],
        )

    def render(self, mvp, points, color=np.array([1.0, 0.0, 0.0])):
        for i in range(len(points)-1):
            self.program['Mvp'].write(mvp)
            self.program['Color'].write(color.astype('f4'))
            self.program['Pos_a'].write(points[i].astype('f4'))
            self.program['Pos_b'].write(points[i+1].astype('f4'))
            self.vao.render(moderngl.LINES)

