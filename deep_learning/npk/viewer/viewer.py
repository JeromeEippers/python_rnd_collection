from pathlib import Path

import moderngl
import moderngl_window as mglw
from moderngl_window.scene.camera import KeyboardCamera
from . import meshrender, axisrender, gridrender, groundfootrender, projectedgroundshadowrender, textrender
from pathlib import Path
import pickle
import numpy as np


class ViewerWindow(mglw.WindowConfig):
    aspect_ratio = 16 / 9
    resource_dir = Path(__file__).parent.parent.resolve() / 'resources'
    title = "Viewer"

    keyboard_callbacks = []

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.camera = KeyboardCamera(self.wnd.keys, fov=50.0, aspect_ratio=self.wnd.aspect_ratio, near=1.0, far=5000.0)
        self.camera.set_position(0, 200, 300)
        self.camera.set_rotation(-90, -20)
        self.camera.velocity = 200
        self.camera_enabled = False

        self.wnd.mouse_exclusivity = False

    def key_event(self, key, action, modifiers):
        keys = self.wnd.keys

        for callback in self.keyboard_callbacks:
            callback(self, keys, key, action, modifiers)

        self.camera.key_input(key, action, modifiers)

        if action == keys.ACTION_PRESS:
            if key == keys.SPACE:
                self.timer.toggle_pause()

    def mouse_press_event(self, x: int, y: int, button: int):

        if button == 1:
            self.camera_enabled = True

    def mouse_release_event(self, x: int, y: int, button: int):
        if button == 1:
            self.camera_enabled = False

    def mouse_drag_event(self, x: int, y: int, dx: int, dy: int):
        if self.camera_enabled:
            self.camera.rot_state(-dx, -dy)

    def mouse_scroll_event(self, x_offset: float, y_offset: float):
        pass  # self.camera.zoom_state(y_offset)

    def resize(self, width: int, height: int):
        self.camera.projection.update(aspect_ratio=self.wnd.aspect_ratio)

    def render(self, time: float, frametime: float):
        self.ctx.enable_only(moderngl.DEPTH_TEST | moderngl.CULL_FACE)


class Viewer(ViewerWindow):

    draw_callbacks = []


    def __init__(self, **kwargs):
        super().__init__(**kwargs)

        # default renderes
        self.axisrender = axisrender.AxisRender(self.ctx, 10)
        self.gridrender = gridrender.GridRender(self.ctx, 1000, 20)
        self.textrender = textrender.TextRender(self.ctx, self)

        # offset timer
        self.internalTimer = 0

        for r in self.draw_callbacks:
            r.ctx = self.ctx
            r.resource_dir = self.resource_dir
            r.register()


    def reset_timer(self):
        self.internalTimer = 0


    def render(self, time: float, frametime: float):

        self.internalTimer += frametime

        self.ctx.enable_only(moderngl.DEPTH_TEST | moderngl.CULL_FACE)
        self.ctx.clear(0.6,0.6,0.6)

        mvp = self.camera.projection.matrix * self.camera.matrix
        self.gridrender.render(mvp)

        m = np.eye(4, 4)
        self.axisrender.render(mvp, [m])

        for r in self.draw_callbacks:
            r.render(self.camera, self.internalTimer, frametime)

        self.ctx.disable(moderngl.DEPTH_TEST | moderngl.CULL_FACE)
        self.textrender.render('aa')

class Draw(object):

    def __init__(self):
        self.ctx = None
        self.resource_dir = None

    def register(self):
        pass

    def render(self, time: float, frametime: float):
        pass


class CharacterDraw(Draw):

    def __init__(self, drawSkeleton, vertices, indices, skinningindices, skinningweights, skeleton, animation=None):
        super().__init__()
        self.drawSkeleton = drawSkeleton
        self.vertices = vertices
        self.indices = indices
        self.skinningindices = skinningindices
        self.skinningweights = skinningweights
        self.skeleton = skeleton
        self.animation = animation or []

    def register(self):

        self.axisrender = axisrender.AxisRender(self.ctx, 3)

        self.meshrender = meshrender.SkinnedMeshRenderer(
            self.ctx,
            self.vertices, self.indices, self.skinningindices, self.skinningweights, self.skeleton
        )

        self.shadowrender = projectedgroundshadowrender.SkinnedProjectedMeshRenderer(
            self.ctx,
            self.vertices, self.indices, self.skinningindices, self.skinningweights, self.skeleton
        )



    def render(self, camera, time: float, frametime: float):
        self.ctx.enable_only(moderngl.DEPTH_TEST | moderngl.CULL_FACE)

        mvp = camera.projection.matrix * camera.matrix

        framecount = len(self.animation)
        if framecount > 0:
            frame = int((time * 30) % framecount)
            bones = self.animation[frame, :, :, :]
        else:
            bones = self.skeleton.initialpose

        self.meshrender.render(mvp, bones)
        self.shadowrender.render(mvp, bones)

        if self.drawSkeleton :
            self.ctx.disable(moderngl.DEPTH_TEST)
            self.axisrender.render(mvp, bones)

        self.ctx.enable(moderngl.DEPTH_TEST)




class FootGroundDraw(Draw):

    def __init__(self, skeleton, animation=None, leftfootcoloranimation=None, rightfootcoloranimation=None):
        super().__init__()
        self.skeleton = skeleton
        self.animation = animation or []
        self.leftfootcoloranimation = leftfootcoloranimation
        self.rightfootcoloranimation = rightfootcoloranimation

    def register(self):

        self.groundfootrender = groundfootrender.GroundFootRender(self.ctx)

    def render(self, camera, time: float, frametime: float):
        self.ctx.enable_only(moderngl.DEPTH_TEST | moderngl.CULL_FACE)

        mvp = camera.projection.matrix * camera.matrix
        framecount = len(self.animation)
        frame = 0
        if framecount > 0:
            frame = int((time * 30) % framecount)
            bones = self.animation[frame, :, :, :]
        else:
            bones = self.skeleton.initialpose

        color = np.zeros(3)
        if self.leftfootcoloranimation is not None:
            color = self.leftfootcoloranimation[frame]
        self.groundfootrender.render(mvp, bones[self.skeleton.boneid('Model:LeftFoot')], color)

        color = np.zeros(3)
        if self.rightfootcoloranimation is not None:
            color = self.rightfootcoloranimation[frame]
        self.groundfootrender.render(mvp, bones[self.skeleton.boneid('Model:RightFoot')], color)
