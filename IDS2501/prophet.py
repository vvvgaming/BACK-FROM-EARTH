import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from fbprophet import Prophet
from fbprophet.diagnostics import cross_validation
from fbprophet.diagnostics import performance_metrics
from fbprophet.plot import plot_cross_validation_metrics
import warnings
warnings.filterwarnings('ignore')

data_user = pd.read_csv('user_balance_table.csv')
data_user['report_date'] = pd.to_datetime(data_user['report_date'], format = '%Y%m%d')
data_user.head()

data_user_byday = data_user.groupby