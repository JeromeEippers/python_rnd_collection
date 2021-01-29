from pathlib import Path

import moderngl
import moderngl_window as mglw
from moderngl_window.scene.camera import KeyboardCamera
from . import meshrender, axisrender, gridrender, groundfootrender, projectedgroundshadowrender, textrender, timelinerender, screenlinerender, linerender
from pathlib import Path
import numpy as np
from .. import posquat as pq


class ViewerWindow(mglw.WindowConfig):
    aspect_ratio = 16 / 9
    resource_dir = Path(__file__).parent.parent.resolve() / 'resources'
    title = "Viewer"

    widgets = []
    fps = 30.0

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
        self.internalFrame = 0
        self.playbackward = False

        for widget in self.widgets:
            widget.register(self)

    def find_widget(self, cls):
        for widget in self.widgets:
            if isinstance(widget, cls):
                return widget
            sub_widget = self.find_widget(cls)
            if sub_widget is not None:
                return sub_widget
        return None

    def reset_timer(self):
        self.internalTimer = 0
        self.internalFrame = 0

    def key_event(self, key, action, modifiers):
        keys = self.wnd.keys

        for widget in self.widgets:
            if widget.key_event(key, action, modifiers):
                return

        self.camera.key_input(key, action, modifiers)

        if action == keys.ACTION_PRESS:
            if key == keys.SPACE:
                self.internalTimer = float(self.internalFrame) / self.fps
                self.timer.toggle_pause()
            if key == keys.R:
                self.playbackward = not self.playbackward
            if key == keys.P:
                self.internalFrame += 1
            if key == keys.O:
                self.internalFrame -= 1

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
        if self.playbackward:
            self.internalTimer -= frametime
        else:
            self.internalTimer += frametime
        self.internalTimer = max(0, self.internalTimer)
        # update internal frame only if we have a proper frametime
        # this is to avoid rounding errors when we control frame by frame
        if self.timer.is_running and self.internalTimer > 1e-6:
            self.internalFrame = int(self.internalTimer * self.fps)
            self.internalFrame += 1 if (self.internalTimer * self.fps) - self.internalFrame > 0.5 else 0

        for widget in self.widgets:
            widget.pre_render(self.internalFrame, frametime)

        self.ctx.enable_only(moderngl.DEPTH_TEST | moderngl.CULL_FACE)
        self.ctx.clear(0.6, 0.6, 0.6)

        mvp = self.camera.projection.matrix * self.camera.matrix
        self.gridrender.render(mvp)

        m = np.eye(4, 4)
        self.axisrender.render(mvp, [m])

        for widget in self.widgets:
            widget.render(self.internalFrame, frametime)

        self.ctx.disable(moderngl.DEPTH_TEST | moderngl.CULL_FACE)
        for widget in self.widgets:
            texts = widget.texts(self.internalFrame, frametime)
            for text, position, color in texts:
                self.textrender.render(text, position, color)


class Widget(object):

    def __init__(self, widgets=None):
        self.ctx = None
        self.resource_dir = None
        self.window = None
        self.parent = None
        self.widgets = [] if widgets is None else widgets

    def find_widget(self, cls):
        for widget in self.widgets:
            if isinstance(widget, cls):
                return widget
            sub_widget = self.find_widget(cls)
            if sub_widget is not None:
                return sub_widget
        return None


    def register(self, window, parent=None):
        self.window = window
        self.parent = parent
        self.resource_dir = window.resource_dir
        self.ctx = window.ctx
        for widget in self.widgets:
            widget.register(window, self)

    def pre_render(self, frame: float, frametime: float):
        for widget in self.widgets:
            widget.pre_render(frame, frametime)

    def render(self, frame: float, frametime: float):
        for widget in self.widgets:
            widget.render(frame, frametime)

    def texts(self, frame: float, frametime: float):
        """ get the list of texts to print on screen
        [(text, position, color), (...)]"""
        texts = []
        for widget in self.widgets:
            texts += widget.texts(frame, frametime)
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



class TimelineWidget(Widget):
    def __init__(self, animation=None, ticks=None, ranges=None, widgets=None):
        super().__init__(widgets=widgets)
        self.timeline_render = None
        self.is_active = False
        self.current_active_frame = 0
        self.animation = [] if animation is None else animation
        # [(frame, color, text), (...)...]
        self.ticks = [] if ticks is None else ticks
        # [(start_frame, end_frame, y_pos_percentage, height_percentage, color), ...]
        self.ranges = [] if ranges is None else ranges

    def register(self, window, parent=None):
        super().register(window, self)
        self.timeline_render = timelinerender.TimelineRender(self.ctx, window)

    def _validate_timing(self):
        framecount = len(self.animation)
        while framecount > 0 and self.window.internalFrame >= framecount:
            self.window.internalFrame -= framecount
            self.window.internalTimer = self.window.internalFrame / self.window.fps

    def pre_render(self, frame: float, frametime: float):
        if self.is_active :
            self.window.internalFrame = self.current_active_frame

        self._validate_timing()

        super().pre_render(self.window.internalFrame, frametime)

    def render(self, frame: float, frametime: float):
        color = np.zeros(3)
        if self.is_active:
            color += 0.1

        timing = 0
        framecount = len(self.animation)

        self.timeline_render.render_background(color)

        if framecount > 0:
            framelen = framecount-1

            # ranges
            for start, end, y, height, col in self.ranges:
                self.timeline_render.render_range(
                    float(start) / float(framelen),
                    float(end) / float(framelen),
                    y,
                    height,
                    col
                )

            # timeline tick
            tick_color = color + 0.2
            for tick_frame in range(1, framecount):
                self.timeline_render.render_time(float(tick_frame) / float(framelen), color=tick_color)

            # ticks
            for tick_frame, col, _ in self.ticks:
                self.timeline_render.render_tick(float(tick_frame) / float(framelen), color=col)

            # time tick
            self.timeline_render.render_time(float(frame) / float(framelen))

        super().render(frame, frametime)

    def _set_frame(self, x):
        framelen = len(self.animation) - 1
        frame_ratio = self.timeline_render.mouse_timeline_percent(x, 0) * framelen
        frame = int(frame_ratio)
        frame += 1 if frame_ratio - frame > 0.5 else 0
        self.current_active_frame = frame

    def mouse_press_event(self, x: int, y: int, button: int):
        if button == 1:
            if self.timeline_render.is_mouse_in(x, y):
                self.is_active = True
                self._set_frame(x)
                self._validate_timing()
                return True
        return super().mouse_press_event(x, y, button)

    def mouse_release_event(self, x: int, y: int, button: int):
        if button == 1:
            self.is_active = False
            self._validate_timing()
        return super().mouse_release_event(x, y, button)

    def mouse_drag_event(self, x: int, y: int, dx: int, dy: int):
        if self.is_active:
            self._set_frame(x)
            self._validate_timing()
            return True
        return super().mouse_drag_event(x, y, dx, dy)

    def texts(self, frame: float, frametime: float):
        """ get the list of texts to print on screen
        [(text, position, color), (...)]"""
        currentframe = 0
        framecount = len(self.animation)
        y = 24
        texts = []
        for frame_tick, color, text in self.ticks:
            if frame_tick == frame:
                texts += [(text, np.array([5, y]), color)]
                y += 16
        return texts + super().texts(frame, frametime)




class CharacterWidget(Widget):

    def __init__(self, drawSkeleton, vertices, indices, skinningindices, skinningweights, skeleton, animation=None,
                 widgets=None):
        super().__init__(widgets=widgets)
        self.drawSkeleton = drawSkeleton
        self.vertices = vertices
        self.indices = indices
        self.skinning_indices = skinningindices
        self.skinning_weights = skinningweights
        self.skeleton = skeleton
        self.animation = [] if animation is None else animation
        self.color_animation = None
        self.left_foot_color_anim = None
        self.right_foot_color_anim = None
        self.axis_render = None
        self.mesh_render = None
        self.shadow_render = None
        self.ground_foot_render = None
        self.timeline = TimelineWidget(animation)
        self.widgets.append(self.timeline)

    def register(self, window, parent=None):
        super().register(window, self)

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

    def render(self, frame: float, frametime: float):
        self.ctx.enable_only(moderngl.DEPTH_TEST | moderngl.CULL_FACE)

        mvp = self.window.camera.projection.matrix * self.window.camera.matrix

        framecount = len(self.animation)
        if framecount > 0:
            bones = self.animation[frame, :, :, :]
        else:
            bones = self.skeleton.initialpose

        color = np.ones(3)
        if self.color_animation is not None:
            color = self.color_animation[frame]

        self.mesh_render.render(mvp, bones, color)
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
        super().render(frame, frametime)

    def texts(self, frame: float, frametime: float):
        """ get the list of texts to print on screen
        [(text, position, color), (...)]"""
        return [('frame {}'.format(frame), np.array([5, 5]), np.zeros(3))] + super().texts(frame, frametime)

    def change_animation(self, animation,
                         color_animation=None,
                         left_foot_color_anim=None,
                         right_foot_color_anim=None,
                         timeline_ticks=None,
                         timeline_ranges=None):
        self.animation = animation
        self.color_animation = color_animation
        self.left_foot_color_anim = left_foot_color_anim
        self.right_foot_color_anim = right_foot_color_anim
        self.timeline.animation = animation
        self.timeline.ticks = [] if timeline_ticks is None else timeline_ticks
        self.timeline.ranges = [] if timeline_ranges is None else timeline_ranges


class AnimationDictionaryWidget(Widget):

    def __init__(self, animation_dictionary: dict = None, widgets=None):
        super().__init__(widgets=widgets)
        self.animation_dictionary = animation_dictionary or dict()
        self.current_animation = 'Bindpose'

    def register(self, window, parent=None):
        super().register(window, self)
        self.update_animation()

    def set_animation_dictionary(self, animation_dictionary: dict):
        self.animation_dictionary = animation_dictionary
        self.current_animation = 'Bindpose'

    def animation(self, anim_name):
        if anim_name in self.animation_dictionary:
            return self.animation_dictionary[anim_name]
        return []

    def set_current_animation(self, anim_name):
        if anim_name in self.animation_dictionary:
            self.current_animation = anim_name
            # do not update animation if we are not registered yet
            if self.window:
                self.update_animation()

    def body_color_animation(self, anim_name):
        return None

    def left_foot_color_animation(self, anim_name):
        return None

    def right_foot_color_animation(self, anim_name):
        return None

    def timeline_ticks(self, anim_name):
        # return [(frame, color, text), ...]
        return None

    def timeline_ranges(self, anim_name):
        # return [(start_frame, end_frame, y_pos_percentage, height_percentage, color), ...]
        return None

    def _set_next_id(self):
        if len(self.animation_dictionary.keys()) > 0:
            index = 0
            if self.current_animation in self.animation_dictionary:
                index = list(self.animation_dictionary.keys()).index(self.current_animation)
                index += 1
                index = index % len(self.animation_dictionary.keys())
            self.current_animation = list(self.animation_dictionary.keys())[index]

    def _set_previous_id(self):
        if len(self.animation_dictionary.keys()) > 0:
            index = 0
            if self.current_animation in self.animation_dictionary:
                index = list(self.animation_dictionary.keys()).index(self.current_animation)
                index -= 1
                index = index % len(self.animation_dictionary.keys())
            self.current_animation = list(self.animation_dictionary.keys())[index]

    def key_event(self, key, action, modifiers):
        keys = self.window.wnd.keys

        if action == keys.ACTION_PRESS:
            switch_anim = False
            if key == keys.RIGHT:
                self._set_next_id()
                switch_anim = True
            if key == keys.LEFT:
                self._set_previous_id()
                switch_anim = True

            if switch_anim:
                self.window.reset_timer()
                self.update_animation()

        return super().key_event(key, action, modifiers)

    def update_animation(self):
        animation = self.animation(self.current_animation)
        if len(animation) > 0:
            animation = pq.pq_to_pose(animation)

        body = self.body_color_animation(self.current_animation)
        ltfoot = self.left_foot_color_animation(self.current_animation)
        rtfoot = self.right_foot_color_animation(self.current_animation)
        ticks = self.timeline_ticks(self.current_animation)
        ranges = self.timeline_ranges(self.current_animation)

        if self.window:
            self.window.find_widget(CharacterWidget).change_animation(animation, body, ltfoot, rtfoot, ticks, ranges)

        # forward update animation command
        for widget in self.widgets:
            widget.update_animation()

    def texts(self, frame: float, frametime: float):
        """ get the list of texts to print on screen
        [(text, position, color), (...)]"""
        return [(self.current_animation, np.array([100, 5]), np.zeros(3))] + super().texts(frame, frametime)


class RawAnimationDisplayWidget(Widget):

    def __init__(self, animation=None, widgets=None):
        super().__init__(widgets=widgets)
        self.animation = [] if animation is None else animation
        self.axis_render = None
        self.timeline = TimelineWidget(animation)
        self.widgets.append(self.timeline)

    def register(self, window, parent=None):
        super().register(window, self)

        self.axis_render = axisrender.AxisRender(self.ctx, 3)

    def render(self, frame: float, frametime: float):
        self.ctx.enable_only(moderngl.DEPTH_TEST | moderngl.CULL_FACE)

        mvp = self.window.camera.projection.matrix * self.window.camera.matrix

        framecount = len(self.animation)
        if framecount > 0:
            bones = self.animation[frame, :, :, :]
            self.ctx.disable(moderngl.DEPTH_TEST)
            self.axis_render.render(mvp, bones)

        self.ctx.enable(moderngl.DEPTH_TEST)
        super().render(frame, frametime)

    def texts(self, frame: float, frametime: float):
        """ get the list of texts to print on screen
        [(text, position, color), (...)]"""
        return [('frame {}'.format(frame), np.array([5, 5]), np.zeros(3))] + super().texts(frame, frametime)

    def change_animation(self, animation):
        self.animation = animation


class PlotWidget(Widget):
    def __init__(self, y, w, color=np.array([0.0, 0.0, 0.0]), plots=None, widgets=None):
        super().__init__(widgets=widgets)
        self.y = y
        self.w = w
        self.plots = [] if plots is None else plots
        self.plot_render = None
        self.plots_min = 0
        self.plots_max = 0
        self.plot_len = 0
        self.color = color
        self.set_plots(self.plots)

    def set_plots(self, plots):
        self.plots = plots
        self.plot_len = len(self.plots)
        if self.plot_len > 0:
            self.plots_min = np.min(self.plots)
            self.plots_max = np.max(self.plots)

    def register(self, window, parent=None):
        super().register(window, self)
        self.plot_render = screenlinerender.ScreenLineRender(self.ctx, window)

    def render(self, frame: float, frametime: float):
        self.ctx.disable(moderngl.DEPTH_TEST)

        # axis
        self.plot_render.render(0, 1, self.y + self.w * 0.5, self.y + self.w * 0.5, np.array([0.3, 0.3, 0.3]))

        # draw plot
        for i in range(0, self.plot_len-1, 1):
            self.plot_render.render(
                i/(self.plot_len-1),
                (i+1)/(self.plot_len-1),
                self.y + (self.plots[i] - self.plots_min) / (self.plots_max - self.plots_min + 1e-8) * self.w,
                self.y + (self.plots[i+1] - self.plots_min) / (self.plots_max - self.plots_min + 1e-8) * self.w,
                self.color
            )


class PlotHistogramWidget(PlotWidget):

    def render(self, frame: float, frametime: float):
        self.ctx.disable(moderngl.DEPTH_TEST)

        # draw plot
        for i in range(0, self.plot_len, 1):
            self.plot_render.render(
                i/(self.plot_len-1),
                i/(self.plot_len-1),
                self.y + (self.plots[i] - self.plots_min) / (self.plots_max - self.plots_min + 1e-8) * self.w,
                self.y,
                self.color
            )


class LineWidget(Widget):
    def __init__(self, color=np.array([0.0, 0.0, 0.0]), points=None, widgets=None):
        super().__init__(widgets=widgets)
        self.points = [] if points is None else points
        self.line_render = None
        self.color = color

    def set_points(self, points=None):
        self.points = [] if points is None else points

    def register(self, window, parent=None):
        super().register(window, self)
        self.line_render = linerender.LineRender(self.ctx)

    def render(self, frame: float, frametime: float):
        self.ctx.disable(moderngl.DEPTH_TEST)
        if len(self.points) > 1:
            mvp = self.window.camera.projection.matrix * self.window.camera.matrix
            for i in range(0, len(self.points), 2):
                self.line_render.render(mvp, self.points[i:i+2], self.color)


class TrajectoryWidget(Widget):
    def __init__(self, color=np.array([0.0, 0.0, 0.0]), points=None, widgets=None):
        super().__init__(widgets=widgets)
        self.points = [] if points is None else points
        self.line_render = None
        self.color = color

    def set_points(self, points=None):
        self.points = [] if points is None else points

    def register(self, window, parent=None):
        super().register(window, self)
        self.line_render = linerender.LineRender(self.ctx)

    def render(self, frame: float, frametime: float):
        self.ctx.disable(moderngl.DEPTH_TEST)
        if len(self.points) > 1:
            mvp = self.window.camera.projection.matrix * self.window.camera.matrix
            self.line_render.render(mvp, self.points, self.color)