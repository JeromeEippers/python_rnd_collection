from pathlib import Path
import pickle

from .viewer import viewer

from . import inertialize
from . import fbxreader
from . import modifier
from . import modifier_displacement
from . import posquat
from . import skeleton
from . import utilities

resource_dir = Path(__file__).parent.resolve() / 'resources'

# global so we don't reload the character all the time
g_vertices, g_indices, g_skinningindices, g_skinningweights, g_skeleton = None, None, None, None, None

def get_character_constructor_parameters():
    global g_vertices, g_indices, g_skinningindices, g_skinningweights, g_skeleton

    # LOAD CHARACTER
    if g_skeleton != None:
        return g_vertices, g_indices, g_skinningindices, g_skinningweights, g_skeleton

    try:
        g_vertices, g_indices, g_skinningindices, g_skinningweights, g_skeleton = pickle.load(
            open(str(resource_dir / 'simplified_man_average.dump'), 'rb'))
    except Exception:
        reader = fbxreader.FbxReader(str(resource_dir / 'simplified_man_average.fbx'))
        x = pickle.dumps(
            (*reader.vertices_and_indices(),
             *reader.skinning_indices_weights(),
             reader.skeleton())
        )
        with open(str(resource_dir / 'simplified_man_average.dump'), 'wb') as f:
            f.write(x)

    return g_vertices, g_indices, g_skinningindices, g_skinningweights, g_skeleton


def get_skeleton():
    return get_character_constructor_parameters()[4]


def run_main_window(widgets=None, widgets_addon=None):

    if widgets is None:
        widgets = [viewer.CharacterWidget(True, *get_character_constructor_parameters())]

    #create widget
    viewer.ViewerWindow.widgets.extend(widgets)
    if widgets_addon is not None:
        viewer.ViewerWindow.widgets.extend(widgets_addon)

    #run
    viewer.mglw.run_window_config(viewer.ViewerWindow)
