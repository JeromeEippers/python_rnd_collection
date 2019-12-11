import numpy as np

class RealignMatrix(object):
    
    @staticmethod
    def get_M_aligned_to_x(M, x):
        x = x/np.linalg.norm(x)
        z = np.cross(x, M[1][:3])
        z = z/np.linalg.norm(z)
        y = np.cross(z, x)
        y = y/np.linalg.norm(y)
        return np.array([x.tolist()+[0],y.tolist()+[0],z.tolist()+[0],M[3]], dtype=float)

    @staticmethod
    def get_M_aligned_to_y(M, y):
        y = y/np.linalg.norm(y)
        x = np.cross(y, M[2][:3])
        x = x/np.linalg.norm(x)
        z = np.cross(x, y)
        z = z/np.linalg.norm(z)
        return np.array([x.tolist()+[0],y.tolist()+[0],z.tolist()+[0],M[3]], dtype=float)

    @staticmethod
    def get_M_aligned_to_z(M, z):
        z = z/np.linalg.norm(z)
        y = np.cross(z, M[0][:3])
        y = y/np.linalg.norm(y)
        x = np.cross(y, z)
        x = x/np.linalg.norm(x)
        return np.array([x.tolist()+[0],y.tolist()+[0],z.tolist()+[0],M[3]], dtype=float)
    
    
    def __init__(self, M, local_vectors):
        I = np.array([[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]], dtype=float)
        
        #get the main axis of the vectors
        self._aligned_axis = np.argmax(local_vectors*local_vectors, axis=1)
        
        #compute all the local aligned matrix :
        self._aligned_matrices = []
        self._local_parent_matrices = []
        for axis, vector in zip(self._aligned_axis, local_vectors):
            matrix = [self.get_M_aligned_to_x, self.get_M_aligned_to_y, self.get_M_aligned_to_z][axis](M, vector)
            matrix[3][:3] = M[3][:3]
            self._aligned_matrices.append(np.dot(M, np.linalg.inv(matrix)))
            
    def solve_from_local_vectors(self, M, local_vectors):
        alignedMatrices = [
            np.dot(
                matrix,
                [self.get_M_aligned_to_x, self.get_M_aligned_to_y, self.get_M_aligned_to_z][axis](M, vector)
            ) 
            for axis, matrix, vector in zip(self._aligned_axis, self._aligned_matrices, local_vectors)
        ]
        
        result_matrix = alignedMatrices[0]
        
        if len(alignedMatrices)>1:
            result_matrix = np.sum(alignedMatrices, axis=0)
            x = result_matrix[0][:3]
            y = result_matrix[1][:3]
            x = x/np.linalg.norm(x)
            y = y/np.linalg.norm(y)
            z = np.cross(x, y)
            y = np.cross(z, x)
            result_matrix = np.array([x.tolist()+[0],y.tolist()+[0],z.tolist()+[0],[0,0,0,1]], dtype=float)
            
        result_matrix[3][:3] = M[3][:3]
        return result_matrix
    