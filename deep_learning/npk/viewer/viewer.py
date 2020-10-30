from pathlib import Path

import moderngl
import moderngl_window as mglw
from moderngl_window.scene.camera import KeyboardCamera
from . import meshrender, axisrender, gridrender, groundfootrender, projectedgroundshadowrender, textrender
from pathlib import Path
import numpy as np


class ViewerWindow(mglw.WindowConfig):
    aspect_ratio = 16 / 9
    resource_dir = Path(__file__).parent.parent.resolve() / 'resources'
    title = "Viewer"

    widgets = []

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.camera = KeyboardCamera(self.wnd.keys, fov=50.0, aspect_ratio=self.wnd.aspect_ratio, near=1.0, far=5000.0)
        self.camera.set_position(0, 200, 300)
        self.camera.set_rotation(-90, -20)
        self.camera.velocity = 200
        self.camera_enabled = False
        self.wnd.mouse_exclusivity = False

        # default renderes
        self.axisrender = axisrender.AxisRender(self.ctx, 10)
        self.gridrender = gridrender.GridRender(self.ctx, 1000, 20)
        self.textrender = textrender.TextRender(self.ctx, self)

        # offset timer
        self.internalTimer = 0

        for widget in self.widgets:
            widget.register(self)

    def reset_timer(self):
        self.internalTimer = 0

    def key_event(self, key, action, modifiers):
        keys = self.wnd.keys

        for widget in self.widgets:
            if widget.key_event(key, action, modifiers):
                return

        self.camera.key_input(key, action, modifiers)

        if action == keys.ACTION_PRESS:
            if key == keys.SPACE:
                self.timer.toggle_pause()

    def mouse_press_event(self, x: int, y: int, button: int):
        for widget in self.widgets:
            if widget.mouse_press_event(x, y, button):
                return

        if button == 1:
            self.camera_enabled = True

    def mouse_release_event(self, x: int, y: int, button: int):
        for widget in self.widgets:
            if widget.mouse_release_event(x, y, button):
                return

        if button == 1:
            self.camera_enabled = False

    def mouse_drag_event(self, x: int, y: int, dx: int, dy: int):
        for widget in self.widgets:
            if widget.mouse_drag_event(x, y, dx, dy):
                return

        if self.camera_enabled:
            self.camera.rot_state(-dx, -dy)

    def mouse_scroll_event(self, x_offset: float, y_offset: float):
        for widget in self.widgets:
            if widget.mouse_scroll_event(x_offset, y_offset):
                return

    def resize(self, width: int, height: int):
        for widget in self.widgets:
            widget.resize(width, height)
        self.camera.projection.update(aspect_ratio=self.wnd.aspect_ratio)

    def render(self, time: float, frametime: float):
        self.internalTimer += frametime

        self.ctx.enable_only(moderngl.DEPTH_TEST | moderngl.CULL_FACE)
        self.ctx.clear(0.6, 0.6, 0.6)

        mvp = self.camera.projection.matrix * self.camera.matrix
        self.gridrender.render(mvp)

        m = np.eye(4, 4)
        self.axisrender.render(mvp, [m])

        for widget in self.widgets:
            widget.render(self.internalTimer, frametime)

        self.ctx.disable(moderngl.DEPTH_TEST | moderngl.CULL_FACE)
        for widget in self.widgets:
            texts = widget.texts(self.internalTimer, frametime)
            for text, position, color in texts:
                self.textrender.render(text, position, color)


class Widget(object):

    def __init__(self):
        self.ctx = None
        self.resource_dir = None
        self.window = None
        self.parent = None
        self.widgets = []

    def register(self, window, parent=None):
        self.window = window
        self.parent = parent
        self.resource_dir = window.resource_dir
        self.ctx = window.ctx
        for widget in self.widgets:
            widget.register(window, self)

    def pre_render(self, time: float, frametime: float):
        for widget in self.widgets:
            widget.pre_render(time, frametime)

    def render(self, time: float, frametime: float):
        for widget in self.widgets:
            widget.render(time, frametime)

    def texts(self, time: float, frametime: float):
        """ get the list of texts to print on screen
        [(text, position, color), (...)]"""
        texts = []
        for widget in self.widgets:
            texts += widget.texts(time, frametime)
        return texts

    def key_event(self, key, action, modifiers):
        for widget in self.widgets:
            if widget.key_event(key, action, modifiers):
                return True
        return False

    def mouse_press_event(self, x: int, y: int, button: int):
        for widget in self.widgets:
            if widget.mouse_press_event(x, y, button):
                return True
        return False

    def mouse_release_event(self, x: int, y: int, button: int):
        for widget in self.widgets:
            if widget.mouse_release_event(x, y, button):
                return True
        return False

    def mouse_drag_event(self, x: int, y: int, dx: int, dy: int):
        for widget in self.widgets:
            if widget.mouse_drag_event(x, y, dx, dy):
                return True
        return False

    def mouse_scroll_event(self, x_offset: float, y_offset: float):
        for widget in self.widgets:
            if widget.mouse_scroll_event(x_offset, y_offset):
                return True
        return False

    def resize(self, width: int, height: int):
        for widget in self.widgets:
            widget.resize(width, height)


class CharacterWidget(Widget):

    def __init__(self, drawSkeleton, vertices, indices, skinningindices, skinningweights, skeleton, animation=None):
        super().__init__()
        self.drawSkeleton = drawSkeleton
        self.vertices = vertices
        self.indices = indices
        self.skinning_indices = skinningindices
        self.skinning_weights = skinningweights
        self.skeleton = skeleton
        self.animation = animation or []
        self.left_foot_color_anim = None
        self.right_foot_color_anim = None
        self.axis_render = None
        self.mesh_render = None
        self.shadow_render = None
        self.ground_foot_render = None

    def register(self, window):
        super().register(window)

        self.axis_render = axisrender.AxisRender(self.ctx, 3)

        self.mesh_render = meshrender.SkinnedMeshRenderer(
            self.ctx,
            self.vertices, self.indices, self.skinning_indices, self.skinning_weights, self.skeleton
        )

        self.shadow_render = projectedgroundshadowrender.SkinnedProjectedMeshRenderer(
            self.ctx,
            self.vertices, self.indices, self.skinning_indices, self.skinning_weights, self.skeleton
        )

        self.ground_foot_render = groundfootrender.GroundFootRender(self.ctx)

    def render(self, time: float, frametime: float):
        self.ctx.enable_only(moderngl.DEPTH_TEST | moderngl.CULL_FACE)

        mvp = self.window.camera.projection.matrix * self.window.camera.matrix

        framecount = len(self.animation)
        if framecount > 0:
            frame = int((time * 30) % framecount)
            bones = self.animation[frame, :, :, :]
        else:
            bones = self.skeleton.initialpose

        self.mesh_render.render(mvp, bones)
        self.shadow_render.render(mvp, bones)

        color = np.zeros(3)
        if self.left_foot_color_anim is not None:
            color = self.left_foot_color_anim[frame]
        self.ground_foot_render.render(mvp, bones[self.skeleton.boneid('Model:LeftFoot')], color)

        color = np.zeros(3)
        if self.right_foot_color_anim is not None:
            color = self.right_foot_color_anim[frame]
        self.ground_foot_render.render(mvp, bones[self.skeleton.boneid('Model:RightFoot')], color)

        if self.drawSkeleton:
            self.ctx.disable(moderngl.DEPTH_TEST)
            self.axis_render.render(mvp, bones)

        self.ctx.enable(moderngl.DEPTH_TEST)
        super().render(time, frametime)

    def change_animation(self, animation, left_foot_color_anim=None, right_foot_color_anim=None):
        self.animation = animation
        self.left_foot_color_anim = left_foot_color_anim
        self.right_foot_color_anim = right_foot_color_anim

