import numpy as ny
import matplotlib.pyplot as plt

plt.rcParams['font.sans-serif'] = 'SimHei'
plt.rcParams['axes.unicode_minus'] = False
data = np.load('.../data/测试数据.npz')
name = data['columns']
values = data['values']
label = ['第一产业','第二产业',' 第三产业']
plt.figure(fisize=(6,5))
plt.bar(range(3),values[-1,3:6],width = 0.5)
plt.xlabel('产业')
plt.ylabel('生产总值（亿元）')
plt.xticks(range(3),label)
plt.title('一季度国民生产总值')
plt.savefig('.../tmp/一季度国民生产总值.png')
plt.show()

matplotlib.pyplot.pie(x, explode, labels=None,colors, autopct=None,
pctdistance=0.6, shadow=False, labeldistance=1.1, startangle=None,
radius=None, counterclock=True, wegeprops=None, textprops=None, center=(0,0),
frame=False, hold=None, data=None)

plt.figure(figsize=(6,6))
lable=['第一产业','第二产业','第三产业']
explode = [0.01,0.01,0.01]
plt.pie(values[-1,3:6],explode=explode,labels=label,autopct='%1.1f%%')
plt.title('一季度国民生产总值')
plt.savefig('.../tmp/一季度国民生产总值.png')
plt.show()

#Prim Algorithm
minimumSpainningTree(graph):
    mark all vertices and edges as unvisited
    mark some vertex, say v,  as visited
    for all the vertices:
        find the least weight edge from a visited vertex to an
        unvisited vertex, say w
        mark the edge and was visited
        

#topological sort
topologicalSort(graph g):
    stack = LinkedStack()
    mark all vertices in the graph as unvisited
    for each vertex, v, in the graph:
        if v is unvisited:
           dfs(g, v, stack)
    return stack


dfs(graph, v, stack):
    mark v as visited
    for each vertex, w, adjacent to v:
        if w is unvisited:
            dfs(grap, w, stack)

    stack.push(v)


#Dijkstra Algorithm
Do
  
    Find the vertex F that is not yet included and has the minimal
    distance in the results grid
    Mark F as included
    For each other vertex T not included
        If there is an edge from F to T
        Set new distance + edge's weight
        If new distance < T's distance in the results grid
           Set T's distance to new distance
           Set T's parent in the results grid to F
While at least one vertex is not included

#Back tracking
Create an empty stack
Push the starting state onto the stack
While the stack is not empty
    Pop the stack and examine the state
    If the state represents an ending state
       Return SUCCESSFUL CONCLUSION
    Else if the state has not been visited previously
         Mark the state as visited
         Push onto the stack all unvisited adjacent states
Return UNSUCCESSFUL CONCLUSION        

Instantiate a stack
Locate the character "P" in the grid
Push its location onto the stack
While the stack is not empty
    Pop a location, (row, colum), off the stack
    If the grid contains "T" at this location, then
       A path has been found
       Return True
    Else if this location does not contain a dot
        Place a dot in the grid at this location
        Examine the adjacent cells to this one and
        for each one that contains a space,
            push its location onto the stack
Return False

#CRNN
for i, filter_size in enumerate(filter_sizes):
    with tf.name_scope('conv-pool-%s' % filter_size):
        num_before = (filter_size-1) // 2
        num_after = (filter_size-1) - num_before
        pad_before = tf.concat([self.pad] * num_before, 1)
        pad_after = tf.concat([self.pad] * num_post, 1)
        emb_padding = tf.concat([pad_before, embedding, pad_after], 1)
        filter_shape = [filter_size, embedding_size, 1, num_filters]
        w = tf.Variable(tf.truncated_normal(filter_shape, stddev = 0.1), name = 'W')
        b = tf.Variable(tf.constant(0.1, shape = [num_filters]), name = 'b')
        conv = tf.nn.conv2d(emb_padding, w, strides = [1,1,1,1], padding = 'VALID', name = 'conv')
        h = tf.nn.relu(tf.nn.bias_add(conv,b), name = 'relu')
        pooled = tf.nn.max_pool(h, ksize = [1, max_pool_size, 1, 1], strides = [1, max_pool_size, 1, 1], padding = 'SAME', name = 'pool')
        pooled = tf.reshape(pooled, [-1, reduce, num_filters])
        pooled_concat.append(pooled)

pooled_concat = tf.concat(pooled_concat, 2)
pooled_concat = tf.nn.dropout(pooled_concat, self.drop_keep_prob)
lstm_cell = tf.contrib.rnn.GRUcell(num_units = hidden_unit)
lstm_cell = tf.contrib.rnn.DropoutWrapper(lstm_cell, output_keep_prob = self.dropout_keep_prob)
self._initial_state = lstm_cell.zero_state(self.batch_size, tf.float32)
inputs = [tf.squeeze(input_, [1]) for input_ in tf.split(pooled_concat, num_or_size_splits = int(reduce), axis = 1)]
outputs, state = tf.contrib.rnn.static_rnn(lstm_cell, inputs, initial_state = self._initial_state, sequence_length = self.context_len)

 #includ <stdio.h>
 int main()
 {
     int i, a;
     a = 0;
     #pragma omp parallel for
     for(i = 0; i < 10; i++)
         a = a + i;
     printf("a1 = %d\n", a);
     a = 0;
     #pragma omp parallel for reduction(+:a)
     for(i = 1; i < 100; i++)
         a = a + i;
         printf("a2 = %d\n", a);
         return 0;


 }

 #coding: utf-8
 import os
 import time
 import random
 import jiebaq
 import nltk
 import sklearn
 from sklearn.naive_bayes import MultinomialNB
 import numpy as np
 import pylab as pl
 import matplotlib as plt

 def MakeWordsSet(words_file):
     words_set = set()
     with open(words_file, 'r') as fp:
         for line in fp.readlines():
             word = line.strip().decode("utf-8")
             if len(word) > 0 and not in words_set:
                 words_set.add(word)
    return words_set

def TextProcessing(folder_path, test_size = 0.2):
    folder_list = os.listdir(folder_path)
    data_list = []
    class_list = []

    for folder in folder_list:
        new_folder_path = os.path.join(folder_path, folder)
       files = os.listdir(new_folder_path)

       j = 1
       for file in files:
           if j > 100
           break
        with open(os.path.join(new_folder_path, file), 'r') as fp:
            raw = fp.read()

            word_cut = jieba.cut(raw, cut_all = F)