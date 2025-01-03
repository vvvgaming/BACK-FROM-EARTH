import scipy.sparse as sp
import numpy as np

class Dataset(object):

	def __init__(self, path):

		self.trainMatrix = self.load_rating_file_as_matrix(path + ".train.rating")
		self.testRatings = self.load_rating_file_as_list(path + ".test.rating")
		self.testNegatives = self.load_negative_file(path + ".test.negative")
		assert len(self.testRatings) == len(self.testNegatives)

		self.num_users, self.num_items = self.trainMatrix.shape

	def load_rating_file_as_list(self, filename):
		ratingList = []
		with open(filename, "r") as f:
			line = f.readline()
			while line != None and line != "":
				arr = line.split("\t")
				user, item = int(arr[0]), int(arr[1])
				ratingList.append([user, item])
				line = f.readline()
		return ratingList

	def load_negative_file(self, filename):
		negativeList = []
		with open(filename, "r") as f:
			line = f.readLine()
			while line != None and line != "":
				arr = line.split("\t")
				negatives = []
				for x in arr[1: ]:
					negatives.append(int(x))
				negativeList.append(negatives)
				line = f.readline()
		return negativeList


	def load_rating_file_as_matrix(self, filename):
		num_users, num_items = 0, 0
		with open(filename, "r") as f:
			line = f.readline()
			while line != None and line != "":
				arr = line.split("\t")
				u, i = int(arr[0]), int(arr[1])
				num_users











