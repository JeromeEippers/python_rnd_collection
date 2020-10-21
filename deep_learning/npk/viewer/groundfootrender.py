import moderngl
import numpy as np


class GroundFootRender(object):
    def __init__(self, ctx):
        self.ctx = ctx

        self.program = self.ctx.program(
            vertex_shader='''
                        #version 430
                        uniform mat4 Mvp;
                        uniform mat4 Model;
                        uniform vec3 Color;
                        in vec3 in_vert;
                        out vec3 v_color;    
                        void main() {
                            gl_Position = Model * vec4(in_vert, 1.0);
                            gl_Position.y = 0;
                            gl_Position = Mvp * gl_Position;
                            v_color = Color;
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
            # x, y ,z
             0, -8, -8,
             0, -8, 8,
             0, 25, 8,
             0, 25, -8,
        ], dtype='f4')

        vbo = self.ctx.buffer(vertices)

        self.vao = self.ctx.vertex_array(
            self.program,
            [
                (vbo, '3f4', 'in_vert')
            ],
        )

    def render(self, mvp, model, color=np.zeros(3)):
        self.program['Mvp'].write((mvp).astype('f4'))
        self.program['Model'].write((model).astype('f4'))
        self.program['Color'].write((color).astype('f4'))
        self.vao.render(moderngl.TRIANGLE_FAN)
