import pickle

discontinuities = pickle.load(open(r'D:\Github\python_rnd_collection\new_challenge_old_research\motion_graph\random_walk_animation_discontinuities.dat','rb'))

for i in range(len(discontinuities)-1):
    inertialize_animation(discontinuities[i], discontinuities[i+1], [root, spine, head, left_arm, right_arm, left_leg, right_leg])