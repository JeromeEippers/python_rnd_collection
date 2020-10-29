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
                        in vec2 in_vert;
                        in vec2 in_texcoord_0;
                        out vec2 v_texcoord_0;   
                        void main() {
                            gl_Position = vec4(Position + in_vert, 0, 0);
                            v_texcoord_0 = in_texcoord_0 + in_vert;
                        }
                    ''',
            fragment_shader='''
                        #version 430
                        uniform vec3 Color;
                        uniform sampler2D Texture;
                        in vec2 v_texcoord_0;
                        out vec4 f_color;
                        void main() {
                            f_color = vec4(texture(Texture, v_texcoord_0).g,Color.r,1,1);
                        }
                    ''',
        )

        vertices = np.array([
            # x, y, u, v
             0, 0, 0, 0,
             0, 1, 0, 1,
             1, 1, 1, 1,
             1, 0, 1, 0,
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


    def render(self, text, pos=np.zeros(2), color=np.zeros(3)):
        self.program['Position'].write(pos.astype('f4'))
        self.program['Color'].write(color.astype('f4'))
        self.program['Texture'] = 0

        self.texture.use()
        self.ctx.enable(moderngl.BLEND)
        self.ctx.blend_func = moderngl.SRC_ALPHA, moderngl.ONE_MINUS_SRC_ALPHA
        self.ctx.blend_equation = moderngl.FUNC_ADD
        self.vao.render(moderngl.TRIANGLE_FAN)
        self.ctx.disable(moderngl.BLEND)

