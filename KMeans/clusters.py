import matplotlib, matplotlib.pyplot as pyplot
import pickle, pandas as pd
import sklearn.cluster, sklearn.preprocessing

alco2019 = pickle.load(open("alco2019.pickle", "rb"))

states = pd.read_csv("states.csv", name=("States", "Standard", "Postal", "Capital"))
colums = ["Wine", "Beer"]