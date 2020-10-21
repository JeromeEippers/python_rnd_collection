import numpy as np
import moderngl


def grid(size, steps):
    u = np.repeat(np.linspace(-size, size, steps), 2)
    v = np.tile([-size, size], steps)
    w = np.zeros(steps * 2)
    return np.concatenate([np.dstack([u, w, v]), np.dstack([v, w, u])])


class GridRender(object):
    def __init__(self, ctx, size, steps):
        self.ctx = ctx

        self.program = self.ctx.program(
            vertex_shader='''
                        #version 330
                        uniform mat4 Mvp;
                        in vec3 in_vert;
                        void main() {
                            gl_Position = Mvp * vec4(in_vert, 1.0);
                        }
                    ''',
            fragment_shader='''
                        #version 330
                        out vec4 f_color;
                        void main() {
                            f_color = vec4(0.1, 0.1, 0.1, 1.0);
                        }
                    ''',
        )

        self.program['Mvp']

        vbo = self.ctx.buffer(grid(size, steps).astype('f4'))
        self.vao = self.ctx.simple_vertex_array(self.program, vbo, 'in_vert')

    def render(self, mvp):
        self.program['Mvp'].write(mvp)
        self.vao.render(moderngl.LINES)
