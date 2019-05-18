import numpy as ny
import matplotlib.pyplot as plt

plt.rcParams['font.sans-serif'] = 'SimHei'
plt.rcParams['axes.unicode_minus'] = False
data = np.load('.../data/测试数据.npz')
name = data['columns']
values = data['values']
label = ['第一产业','第二产业',' 第三产业']
plt.