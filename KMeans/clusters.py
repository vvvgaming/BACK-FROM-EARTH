import matplotlib, matplotlib.pyplot as pyplot
import pickle, pandas as pd
import sklearn.cluster, sklearn.preprocessing

alco2019 = pickle.load(open("alco2019.pickle", "rb"))

states = pd.read_csv("states.csv", name=("States", "Standard", "Postal", "Capital"))
columns = ["Wine", "Beer"]

kmeans = sklearn.cluster.KMeans(n_clusters=9)
kmeans.fit(alco2019[columns])
alco2019["Cluster"] = kmeans.labels_
centers = pd.dataFrame(kmeans.cluster_centers_, columns=columns)

matplotlib.style.use("ggplot")

ax = alco2019.plot.scatter(columns[0], columns[1], c="Clusters",
cmap=plt.cm.Accent, s=100)

centers.plot.scatter(columns[0], columns[1], color="red", marker="+",
s=200, ax=ax)

def add_abbr(state):
    _ = ax.annotate(state["Postal"], state[columns], xytext=(1, 5),
    textcoords="offset points", size=8,
    color="darkslategrey")

alco2019withState = pd.concat([alco2019, state.set_index("State")],
axis=1)
