import moderngl
import numpy as np


class Timeline(object):
    def __init__(self, ctx, window):
        self.ctx = ctx

        self.program = self.ctx.program(
            vertex_shader='''
                        #version 430
                        in vec2 in_vert;
                        void main() {
                            gl_Position = vec4(in_vert, 0, 1);
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
        self.programtick = self.ctx.program(
            vertex_shader='''
                                #version 430
                                uniform float Position;
                                in vec2 in_vert;
                                void main() {
                                    gl_Position = vec4(Position + in_vert.x, in_vert.y, 0, 1);
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
             -1.0, -1.0,
             1.0, -1.0,
             1.0, -0.9,
             -1.0, -0.9,
        ], dtype='f4')

        vbo = self.ctx.buffer(vertices)

        self.vao = self.ctx.vertex_array(
            self.program,
            [
                (vbo, '2f4', 'in_vert')
            ],
        )

        vertices = np.array([
            # x, y
            0, -1.0,
            0, -0.9,
        ], dtype='f4')

        vbo = self.ctx.buffer(vertices)

        self.vaotick = self.ctx.vertex_array(
            self.programtick,
            [
                (vbo, '2f4', 'in_vert')
            ],
        )


    def is_mouse_in(self, x, y):
        if y > self.window_size[1] * 0.95:
            return True
        return False

    def mouse_timeline_percent(self, x, y):
        return x / self.window_size[0]


    def render(self, time_percent, color=np.zeros(3)):
        self.ctx.disable(moderngl.DEPTH_TEST)
        self.program['Color'].write(color.astype('f4'))
        self.vao.render(moderngl.TRIANGLE_FAN)

        self.programtick['Color'].write(np.array([1.0, 0.0, 0.0]).astype('f4'))
        self.programtick['Position'] = time_percent * 2.0 - 1.0
        self.vaotick.render(moderngl.LINES)

