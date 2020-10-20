from pathlib import Path

import moderngl
import moderngl_window as mglw
from moderngl_window.scene.camera import  KeyboardCamera
import numpy as np


class OrbitCameraWindow(mglw.WindowConfig):
    """Base class with built in 3D orbit camera support"""

    aspect_ratio = 16 / 9
    resource_dir = Path(__file__).parent.parent.resolve() / 'resources'
    title = "Viewer"

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.camera =  KeyboardCamera(self.wnd.keys, fov=50.0, aspect_ratio=self.wnd.aspect_ratio, near=1.0, far=5000.0)
        self.camera.set_position(0,200,300)
        self.camera.set_rotation(-90,-20)
        self.camera.velocity = 200
        self.camera_enabled = False

        self.wnd.mouse_exclusivity = False

    def key_event(self, key, action, modifiers):
        keys = self.wnd.keys

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
        pass #self.camera.zoom_state(y_offset)

    def resize(self, width: int, height: int):
        self.camera.projection.update(aspect_ratio=self.wnd.aspect_ratio)

    def render(self, time: float, frametime: float):
        self.ctx.enable_only(moderngl.DEPTH_TEST | moderngl.CULL_FACE)
