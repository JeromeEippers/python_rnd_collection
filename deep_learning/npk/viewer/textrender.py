import moderngl
import numpy as np
from PIL import Image


class TextRender(object):
    def __init__(self, ctx, window):
        self.ctx = ctx

        self.program = self.ctx.program(
            vertex_shader='''
                        #version 430
                        uniform vec2 Position;
                        uniform vec2 Uv;
                        in vec2 in_vert;
                        in vec2 in_texcoord_0;
                        out vec2 v_texcoord_0;   
                        void main() {
                            gl_Position = vec4(Position + in_vert, 0, 1);
                            v_texcoord_0 = in_texcoord_0 + Uv;
                        }
                    ''',
            fragment_shader='''
                        #version 430
                        uniform vec3 Color;
                        uniform sampler2D Texture;
                        in vec2 v_texcoord_0;
                        out vec4 f_color;
                        void main() {
                            f_color = vec4(Color.rgb, texture(Texture, v_texcoord_0).r);
                        }
                    ''',
        )

        with open(str(window.resource_dir / 'font.csv'), 'r') as f:
            csv = f.readlines()

        self.t_width = float(csv[0].split(',')[-1])
        self.t_height = float(csv[1].split(',')[-1])
        self.c_width = float(csv[2].split(',')[-1])
        self.c_height = float(csv[3].split(',')[-1])
        self.first_char = int(csv[4].split(',')[-1])
        self.f_height = float(csv[6].split(',')[-1])
        self.f_widths = [
            float(csv[i].split(',')[-1]) for i in range(8, 264)
        ]

        self.uratio = self.t_width / self.c_width
        self.vratio = self.t_height / self.c_height

        self.window_size = window.window_size
        x = self.c_width / window.window_size[0]
        y = self.c_height / window.window_size[1]
        u = self.c_width / self.t_width
        v = self.c_height / self.t_height
        vertices = np.array([
            # x, y, u, v
             0, 0, 0, 0,
             x, 0, u, 0,
             x, -y, u, v,
             0, -y, 0, v,
        ], dtype='f4')

        vbo = self.ctx.buffer(vertices)

        self.vao = self.ctx.vertex_array(
            self.program,
            [
                (vbo, '2f4 2f4', 'in_vert', 'in_texcoord_0')
            ],
        )

        img = Image.open(str(window.resource_dir / 'font.bmp'))
        self.texture = self.ctx.texture(img.size, 3, img.tobytes())
        self.sampler = self.ctx.sampler(texture=self.texture, filter=(moderngl.NEAREST, moderngl.NEAREST))



    def render(self, text, pos=np.zeros(2), color=np.zeros(3)):
        position = pos.copy()

        self.program['Color'].write(color.astype('f4'))
        self.program['Texture'] = 0

        self.sampler.use()
        self.ctx.enable(moderngl.BLEND)
        self.ctx.blend_func = moderngl.SRC_ALPHA, moderngl.ONE_MINUS_SRC_ALPHA
        self.ctx.blend_equation = moderngl.FUNC_ADD
        for t in text:
            uv = np.array([
                ((ord(t)-self.first_char) % self.uratio)/self.uratio,
                ((ord(t)-self.first_char) // self.uratio)/self.vratio])
            self.program['Position'].write(position.astype('f4'))
            self.program['Uv'].write(uv.astype('f4'))
            self.vao.render(moderngl.TRIANGLE_FAN)
            position[0] += self.f_widths[(ord(t)-self.first_char)] / self.window_size[0]
        self.ctx.disable(moderngl.BLEND)

