import numpy as np

import animation_framework as fw


class FootPhaseWidget(fw.viewer.Widget):
    '''
    This is used as sub widget of ExtendedAnimDictionaryWidget !
    '''
    def __init__(self, widgets=None):
        super().__init__(widgets=widgets)
        self.left_fit = fw.viewer.PlotHistogramWidget(164, 32, color=np.array([0, 0, 1]))
        self.left_contact = fw.viewer.PlotWidget(100, 32, color=np.array([0, 0, 0]))
        self.left_sinus = fw.viewer.PlotWidget(132, 32, color=np.array([1, 0, 0]))

        self.widgets.append(self.left_fit)
        self.widgets.append(self.left_contact)
        self.widgets.append(self.left_sinus)


    def update_animation(self):
        if self.parent.current_animation in self.parent.animation_dictionary:
            animation = self.parent.animation_dictionary[self.parent.current_animation]

            # TODO use the attributes to get the data to plot


class MotionMatchingFeatureDBDebug(fw.viewer.Widget):
    '''
    This is used as sub widget of ExtendedAnimDictionaryWidget !
    '''
    def __init__(self, widgets=None):
        super().__init__(widgets=widgets)
        self.line_widget = fw.viewer.LineWidget(color=np.array([1, 0, 0]))
        self.widgets.append(self.line_widget)

    def update_animation(self):
        if self.parent.current_animation in self.parent.animation_dictionary:
            animation = self.parent.animation_dictionary[self.parent.current_animation]
            features = animation.attribute('mm_features')
            self.line_widget.set_points([])

            if features is not None:
                features = features.data
                features_count = len(features)
                if features_count > 0:
                    points = np.zeros((4 * features_count, 3))
                    for i in range(features_count):
                        points[i * 4, :] = features[i, 0, :]
                        points[i * 4 + 1, :] = features[i, 1, :]
                        points[i * 4 + 2, :] = features[i, 0, :]
                        points[i * 4 + 3, :] = features[i, 2, :]
                    self.line_widget.set_points(points)



def motionmatching_debug_widget(db):

    widget = fw.viewer.AnimationDictionaryWidget(
        animation_dictionary={'{}_{}'.format(i, anim.name): anim for i, anim in enumerate(db.clips)},
        widgets=[
            MotionMatchingFeatureDBDebug(),
            FootPhaseWidget()
        ])
    return widget


def animations_widget(animations):
    widget = fw.viewer.AnimationDictionaryWidget(
        animation_dictionary={'{}_{}'.format(i, anim.name): anim for i, anim in enumerate(animations)},
        widgets=[
            MotionMatchingFeatureDBDebug(),
            #FootPhaseWidget()
        ])
    return widget


def animation_simple_widget(animations):
    widget = fw.viewer.AnimationDictionaryWidget(
        animation_dictionary={'{}_{}'.format(i, anim.name): anim for i, anim in enumerate(animations)},
        widgets=[
        ])
    return widget