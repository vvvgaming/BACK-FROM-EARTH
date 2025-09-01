from scipy import stats
from scipy.stats import t as t_dist
from scipy.stats import chi2

from abtesting_test import *

print(t_dist.cdf(-2, 20))
print(t_dist.cdf(2, 20))

print(chi2.cdf(23.6, 12))
print(1 - chi2.cdf(23.6, 12))


def Slice_2D(List_2D, start_row, end_row, start_col, end_col):



	to_append = []
	for l in range(start_row, end_row):
		to_append.append(list_2D[l][start_col:end_col])


	return to_append



def get_avg(nums):



def get_stdev()






