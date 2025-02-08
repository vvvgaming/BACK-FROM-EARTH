import math
import heapq
import multiprocessing
import numpy as np
from time import time

_model = None
_testRatings = None
_testNegatives = None
_K = None

def evaluate_model(model, testRatings, testNegatives, k, num_thread):
	global _model
	global _testRatings
	global _testNegatives
	global _K
	_model = model
	_testRatings = testRatings
	_testNegatives = testNegatives
	_K = K

	hit, ndcgs = [],[]
	if(num_thread > 1):
		pool = multiprocessing.Pool(processes = num_t)