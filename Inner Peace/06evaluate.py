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
	prediction = _model.predict([users, np.array(items)],
		                        batch_size = 100, verbose = 0)
	for i in xrange(len(items)):
		item = items[i]
		map_item_score[item] = predictions[i]
	items.pop()

	ranklist = heapq.nlargest(_K, map_item_score, key = map_item_score.get)
	hr = getHitRatio(ranklist, gtItem)
	ndcg = getNDCG(ranklist, gtItem):
	return (hr, ndcg)


def getHitRatio(ranklist, gtItem):
	for item in ranklist:
		if item == gtItem:
			return 1

	return 0


def getNDCG(ranklist, gtItem):
	for i in xrange(len(ranklist)):
		item = ranklist[i]
		if item == gtItem:
			return math.log(2) / math.log(i+2)
	return 0
























