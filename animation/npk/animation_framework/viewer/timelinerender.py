import moderngl
import numpy as np


class TimelineRender(object):
    def __init__(self, ctx, window):
        self.ctx = ctx

        fragment = '''
                        #version 430
                        uniform vec3 Color;
                        out vec4 f_color;
                        void main() {
                            f_color = vec4(Color , 1);
                        }
                    '''

        self.program = self.ctx.program(
            vertex_shader='''
                        #version 430
                        in vec2 in_vert;
                        void main() {
                            gl_Position = vec4(in_vert, 0, 1);
                        }
                    ''',
            fragment_shader=fragment,
        )
        self.program_tick = self.ctx.program(
            vertex_shader='''
                                        #version 430
                                        uniform float Position;
                                        in vec2 in_vert;
                                        void main() {
                                            gl_Position = vec4(Position + in_vert.x, in_vert.y, 0, 1);
                                        }
                                    ''',
            fragment_shader=fragment,
        )
        self.program_range = self.ctx.program(
            vertex_shader='''
                                                #version 430
                                                uniform vec4 Area;
                                                in vec2 in_vert;
                                                void main() {
                                                    gl_Position = vec4(
                                                        Area.x * (1.0-in_vert.x) + Area.y * (in_vert.x), 
                                                        (in_vert.y * Area.w) + Area.z, 
                                                        0, 1);
                                                }
                                            ''',
            fragment_shader=fragment,
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

        self.vao_time = self.ctx.vertex_array(
            self.program_tick,
            [
                (vbo, '2f4', 'in_vert')
            ],
        )

        vertices = np.array([
            # x, y
            -0.005, -1.0,
            0.005, -1.0,
            0.005, -0.9,
            -0.005, -0.9,
        ], dtype='f4')

        vbo = self.ctx.buffer(vertices)

        self.vao_tick = self.ctx.vertex_array(
            self.program_tick,
            [
                (vbo, '2f4', 'in_vert')
            ],
        )

        vertices = np.array([
            # x, y
            0, 0,
            1, 0,
            1, 1,
            0, 1,
        ], dtype='f4')

        vbo = self.ctx.buffer(vertices)

        self.vao_range = self.ctx.vertex_array(
            self.program_range,
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

    def render_background(self, color=np.zeros(3)):
        self.ctx.disable(moderngl.DEPTH_TEST)
        self.program['Color'].write(color.astype('f4'))
        self.vao.render(moderngl.TRIANGLE_FAN)

    def render_time(self, time_percent, color=np.array([1.0, 0.0, 0.0])):
        self.program_tick['Color'].write(color.astype('f4'))
        self.program_tick['Position'] = time_percent * 2.0 - 1.0
        self.vao_time.render(moderngl.LINES)

    def render_tick(self, time_percent, color=np.array([1.0, 0.0, 0.0])):
        self.program_tick['Color'].write(color.astype('f4'))
        self.program_tick['Position'] = time_percent * 2.0 - 1.0
        self.vao_tick.render(moderngl.TRIANGLE_FAN)

    def render_range(self, start_percent, end_percent, y, height, color=np.array([1.0, 1.0, 0.0])):
        self.program_range['Color'].write(color.astype('f4'))
        area = np.zeros(4)
        area[0] = start_percent * 2.0 - 1.0
        area[1] = end_percent * 2.0 - 1.0
        area[2] = -0.9 - (y+height) * 0.1
        area[3] = height * 0.1
        self.program_range['Area'].write(area.astype('f4'))
        self.vao_range.render(moderngl.TRIANGLE_FAN)
