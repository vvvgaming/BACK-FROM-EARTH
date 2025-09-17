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



	pass


def get_stdev(nums):


	pass


def get_standard_error(a, b):


	pass


def get_2_sample_df(a, b):


	pass

def get_t_score(a, b):


	pass


def perform_2_sample_t_test(a, b):



	pass


def get_expected_grid(observed_grid):



	pass


def df_chi2(observed_grid):



	pass

def chi2_value(observed_grid):



	pass

def perform_chi2_homogeneity_test(observed_grid):

	











