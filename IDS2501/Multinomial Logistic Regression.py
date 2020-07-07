import numpy as np
import pandas as pd
from datetime import datetime, date, timedelta
from scipy.stats import skew
from scipy.special import boxcoxlp
from scipy.stats import boxcox_normmax
from sklearn.linear_model import ElasticNetCV, LassoCV, RidgeCV, Ridge, Lasso, ElasticNet
from sklearn.ensemble import GradientBoostingRegressor, RandomForestRegressor,RandomForestClassifier
from sklearn.feature_selection import mutual_info_regression
from sklearn.svm import SVR, LinearSVC
from sklearn.pipeline import make_pipeline,Pipeline
from sklearn.preprocessing import RobustScaler, LabelEncoder
from sklearn.model_selection import KFold, cross_val_score, train_test_split
from sklearn.metrics import mean_squared_error
from sklearn.model_selection import GridSearchCV
from sklearn.model_selection import train_test_split
from tqdm import tqdm
from xgboost import XGBRegressor
import xgboost as xgb
from lightgbm import LGBMRegressor
import lightgbm as lgb
import os
import re
import seaborn as sns
import matplotlib.pyplot as plt
import hyperopt
import re
from collections import Counter
from operator import itemgetter
import time
from itertools import product
import datetime as dt
import calendar
import gc

RANDOM_SEED = 42
# 引入中文字体
from matplotlib.font_manager import FontProperties
myfont = FontProperties(fname="/home/aistudio/NotoSansCJKsc-Light.otf", size=12)


PATH = './data'