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

data_user_byday = data_user.groupby(['report_date'])['total_purchase_amt','total_redeem_amt'].sum().sort_values(['report_date']).reset_index()
data_user_byday.head()

##

#定义模型
def FB(data: pd.DataFrame) -> pd.DataFrame:

    df = pd.DataFrame({
        'ds':data.report_date,
        'y':data.total_purchase_amt,
    })

    df['cap'] = data.total_purchase_amt.values.max()
    df['floor'] = data.total_purchase_amt.values.min()

    m = Prophet(
        changepoint_prior_scale = 0.5
        daily_seasonality = False
        yearly_seasonality = True
        weekly_seasonality = True
        growth = 'logistic'
    )

    m.add_country_holiday(country_name = 'CN')

    m.fit(df)

    future = m.make_future_dataframe(periods = 30, freq = 'D')
    future['cap'] = data.total_purchase_amt.values.max()
    future['floor'] = data.total_purchase_amt.values.min()

    forecast = m.predict(future)
    
    fig = m.plot_components(forecast)
    fig1 = m.plot(forecast)

    return forecast

    result_purchase = FB(data_user_byday)




    def FB(data: pd.DataFrame) -> pd.DataFrame:

            df = pd.DataFrame({
    'ds': data.report_date,
    'y': data.total_redeem_amt,
    })
    
    df['cap'] = data.total_redeem_amt.values.max()
    df['floor'] = data.total_redeem_amt.values.min()

    m = Prophet(
        changepoint_prior_scale=0.05, 
        daily_seasonality=False,
        yearly_seasonality=True, #年周期性
        weekly_seasonality=True, #周周期性
        growth="logistic",
    )
    
    m.add_country_holidays(country_name='CN')#中国所有的节假日    
    
    m.fit(df)
    
    future = m.make_future_dataframe(periods=30, freq='D')#预测时长
    future['cap'] = data.total_redeem_amt.values.max()
    future['floor'] = data.total_redeem_amt.values.min()

    forecast = m.predict(future)
    
    fig = m.plot_components(forecast)
    fig1 = m.plot(forecast)
    
    return forecast
    
result_redeem = FB(data_user_byday)

    
result_purchase.tail()


data_comp = pd.read_csv('comp_predict_table.csv', header = None)
data_comp.head()

data_day[]
for i in range(20140901,20140931):
    data_day.append(i)


data_comp = pd.DataFrame(columns = [0, 1, 2])

data_comp[0] = data_day
data_comp[1] = result_purchase.yhat.values[-30:]
data_comp[2] = result_redeem.yhat.values[-30:]
data_comp

data_comp.to_csv('tc_comp_predict_table.csv', header = None, index = False)