import scipy.sparse as sp
import numpy as np

class Dataset(object):

	def __init__(self, path):

		self.trainMatrix = self.load_rating_file_as_matrix(path + ".train.rat")