from viewer import meshrender, orbitwindow, axisrender, grid
import fbxreader
import moderngl
from pathlib import Path
import pickle


class Main(orbitwindow.OrbitCameraWindow):

    def __init__(self, **kwargs):
        super().__init__(**kwargs)

        self.axisrender = axisrender.AxisRender(self.ctx, 10)
        self.gridrender = grid.GridRender(self.ctx, 1000, 20)

        resource_dir = Path(__file__).parent.resolve() / 'resources'

        '''
        reader = fbxreader.FbxReader(str(resource_dir / 'simplified_man_average.fbx'))
        x = pickle.dumps(
            (*reader.vertices_and_indices(),
            *reader.skinning_indices_weights(),
            reader.skeleton())
        )
        with open(str(resource_dir / 'simplified_man_average.dump'), 'wb') as f:
            f.write(x)
        '''

        vertices, indices, skinningindices, skinningweights, skeleton = pickle.load(open(str(resource_dir / 'simplified_man_average.dump'), 'rb'))
        self.meshrender = meshrender.SkinnedMeshRenderer(
            self.ctx,
            vertices, indices, skinningindices, skinningweights, skeleton
        )

        self.skeleton = skeleton
        #self.animations = reader.animation_dictionary()


    def render(self, time: float, frametime: float):
        self.ctx.enable_only(moderngl.DEPTH_TEST | moderngl.CULL_FACE)
        self.ctx.clear(1.0, 1.0, 1.0)

        mvp = self.camera.projection.matrix * self.camera.matrix

        self.gridrender.render(mvp)

        #frames = len(self.animations['Take 001'])-1
        #frame = int((time * 30) % frames)
        #bones = self.skeleton.globalpose(self.animations['Take 001'][frame, :, :, :])
        bones = self.skeleton.initialpose

        self.meshrender.render(mvp, bones)

        self.ctx.disable(moderngl.DEPTH_TEST)
        self.axisrender.render(mvp)
        self.axisrender.render(mvp, bones)

Main.run()
