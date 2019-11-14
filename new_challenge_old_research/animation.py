import numpy as np
import pickle


def load_animation(path):
    """
    Return an animation as :
    ( keycount,
        [(bonename, [np.matrix, np.matrix, ...]), () ...]
    )
    """
    
    animation = pickle.load(open(path,'rb'))
    
    #convert matrix in numpy matrices
    #format of the picle is just a list of tuples with :
    #[ (bonename, [matrix, matrix, ...]), () ]
    
    tracks = []
    for track in animation:
        keys = [np.array([
                    m[0:4],
                    m[4:8],
                    m[8:12],
                    m[12:16]]) for m in track[1]]
        tracks.append((track[0], keys))
        
    return (len(tracks[0][1]), tracks)
    
    
def save_animation(path, tracks_buffer):
    
    tracks = []
    for track in tracks_buffer:
        keys = [m.flatten().tolist() for m in track[1]]
        tracks.append((track[0], keys))
        
    x = pickle.dumps(tracks, protocol=2)
    with open(path, 'wb') as f:
        f.write(x)
    