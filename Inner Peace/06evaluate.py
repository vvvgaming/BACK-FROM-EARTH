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
		pool = multiprocessing.Pool(processes = num_thread)
		res = pool.map(eval_one_rating, rang(len(_testRatings)))
		pool.close()
		pool.join()
		hits = [r[0] for r in res]
		ndcgs = [r[1] for r in res]
		return (hits, ndcgs)

	for idx in xrange(len(_testRatings)):
		(hr, ndcg) = eval_one_rating(idx)
		hits.append(hr)
		ndcgs.append(ndcg)

	return (hits, ndcgs)


def eval_one_rating(idx):
	rating = _testRatings[idx]
	items = _testNegatives[idx]
	u = rating[0]
	gtItem = rating[1]
	items.append(gtItem)


	map_item_score = {}
	users = np.full(len(items), u, dtype = 'int32')
	
























