import matplotlib, matplotlib.pyplot as pyplot
import pickle, pandas as pd
import sklearn.cluster, sklearn.preprocessing

alco2024 = pickle.load(open("alco2024.pickle", "rb"))

states = pd.read_csv("states.csv", name = ("States", "Standard", "Postal", "Capital"))
columns = ["Wine", "Beer"]

kmeans = sklearn.cluster.KMeans(n_cluster = 28)
kmeans.fit(alco2024[colums])
alco2024["Cluster"] = kmeans.labels_
centers = p