import matplotlib, matplotlib.pyplot as pyplot
import pickle, pandas as pd
import sklearn.cluster, sklearn.preprocessing

alco2024 = pickle.load(open("alco2024.pickle", "rb"))

states = pd.read_csv("states.csv", nam)