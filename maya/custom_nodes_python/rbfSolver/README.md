# RBF Solver

This is an rbf solver implemented in pure python without any libraries.
It can blend 3d centers and 3d values.

It supports euclidian distances and angular distance for the distance fonction.

And the kernel can be:
* Gaussian
* MultiQuadratic
* InverseQuadratic
* MultiInverseQuadratic
* ThinPlate

### test

RbfSolver_populate_scene_test can be used to create a test scene in maya.

### status

The logic of the implementation can be found in the Math notebook called "rbf".

Implemented in maya 2018.
