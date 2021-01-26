import numpy as np
import moderngl



class ScreenLineRender(object):
    def __init__(self, ctx, window):
        self.ctx = ctx

        self.program = self.ctx.program(
            vertex_shader='''
                        #version 430
                        uniform vec4 Pts;
                        in vec2 in_vert;
                        void main() {
                            gl_Position = vec4(
                                Pts.x * (1.0-in_vert.x) + Pts.z * (in_vert.x), 
                                Pts.y * (1.0-in_vert.y) + Pts.w * (in_vert.y), 
                                0, 1);
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
        self.window_size = window.window_size
        vertices = np.array([
            # x, y
            0, 0,
            1, 1,
        ], dtype='f4')

        vbo = self.ctx.buffer(vertices)

        self.vao = self.ctx.vertex_array(
            self.program,
            [
                (vbo, '2f4', 'in_vert')
            ],
        )

    def render(self, x1_screen, x2_screen, y1, y2, color=np.array([1.0, 0.0, 0.0])):
        self.program['Color'].write(color.astype('f4'))
        pts = np.zeros(4)
        pts[0] = x1_screen * 2.0 - 1.0
        pts[1] = -(y1 / self.window_size[1] * 2.0 - 1.0)
        pts[2] = x2_screen * 2.0 - 1.0
        pts[3] = -(y2 / self.window_size[1] * 2.0 - 1.0)
        self.program['Pts'].write(pts.astype('f4'))
        self.vao.render(moderngl.LINES)
