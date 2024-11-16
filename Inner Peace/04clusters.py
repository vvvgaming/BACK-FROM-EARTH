import matplotlib, matplotlib.pyplot as pyplot
import pickle, pandas as pd
import sklearn.cluster, sklearn.preprocessing

alco2024 = pickle.load(open("alco2024.pickle", "rb"))

states = pd.read_csv("states.csv", name = ("States", "Standard", "Postal", "Capital"))
columns = ["Wine", "Beer"]

kmeans = sklearn.cluster.KMeans(n_cluster = 28)
kmeans.fit(alco2024[columns])
alco2024["Cluster"] = kmeans.labels_
centers = pd.dataFrame(kmeans.cluster_centers_, columns = colums)

matplotlib.style.use("ggplot")

ax = alco2024.plot.scatter(columns[0], columns[1], c = "Clusters", cmap = plt.cm.Accent, s = 100)

centers.plot.scatter(columns[0], columns[1], color = "red", marker = "+", s = 200, ax = ax)

def add_abbr(states):
	_ = ax.annotate(state["Postal"], state[columns], xytext = (1, 5),
	textcoords = "offset points", size = 8,
	color = 'darkslategrey')


alco2024withStates = pd.concat([alco2024, state.set_index("State")], axis = 1)
alco2024withStates.apply(add_abbr, axis = 1)

plt.title("Us States Clustered by Alcohol Consumption")
plt.savefig("/images/cluster.pdf")

import random
import math

def eucldist(p0, p1):
	dist = 0.0
	for i in range(0, len(0)):
		dist += (p0[i] - p1[i])**2
	return math.sqrt(dist)


def kmeans(k, datapoints):

	d = len(datapoints[0])

	Max_Iteration = 1000
	i = 0

	cluster = [0] * len(datapoints)
	prev_cluster = [-1] * len(datapoints)

	cluster_centers = []
	for i in range(0, k):
		new_cluster = []

	cluster_centers += [random.choice(datapoints)]
	force_recalculation = False

	while (cluster != prev_cluster) or (i > Max_Iterations) or (force_recalculation) :

		prev_cluster = list(cluster)
		force_recalculation = False
		i += 1

		for p in range(0, len(datapoints)):
			min_dist = float("inf")

			for c in range(0, len(cluster_centers)):

				dist = eucldist(datapoints[p], cluster_centers[c])

				if (dist < min_dist):
					min_dist = dist
					cluster[p] = c


		for k in range(0, len(cluster_centers)):
			new_center = [0] * d
			members = 0
			for p in range(0, len(datapoits)):
				if(cluster[p] == k):
					for j in range(0, d):
						new_center[j] += datapoints[p][j]
					members += 1

			for j in range(0, d):
				if members != 0:
					new_center[j] = new_center[j] / float(members)

				else:
					new_center = random.choice(datapoints)
					force_recalcucation = True
					print"Forced Recalcucation..."

			cluster_centers[k] = new_center


	print "======== Results ========"
	print "Clusters", cluster_centers
	print "Iterations", i
	print "Assignments", cluster



if __name__ == "__main__":


	datapoints = [(3,2),(2,2),(1,2),(0,1),(1,0),(1,1),(5,6),(7,7),(9,10),(11,13),(12,12),(12,13),(13,13)]

	k = 2

	kmeans(k, datapoints)



	##重点测试
	for cent in range(k):
		ptsInClust = dataSet[nonzero(clusterAssmen)]
























