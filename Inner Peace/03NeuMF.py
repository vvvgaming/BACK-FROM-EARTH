import numpy as np

import theano
import theano.tensor as T
import keras
from keras import backend as K
from keras import initializations
from keras.regularizers import l1, l2, l1l2
from keras.model import Sequential, Model
from keras.layers.core import Dense, Lambda, Activation
from keras.layers import Embedding, Input, Dense, merge, Reshape, Merge, Flatten, Dropout
from keras.optimizers import Adagrad, Adam, SGD, RMSprop
from evaluate import evaluate_model
from Dataset import Dataset
from time import time
import sys
import GMF, MLP
import argparse


def parse_args():
	parser = argparse.ArgumentParser(description = "Run NeuMF.")
	parser.add_argument('--path', nargs = '?', default = 'Data/', help = 'Input data path.')
	parser.add_argument('--dataset', nargs = '?', default = 'ml-1m', help = 'Choose a dataset.')
	parser.add_argument('--epchos', type = int, default = 100, help = 'Number of epchos.')
	parser.add_argument('--batch_size', type = int, default = 256, help = 'Batch size.')
	parser.add_argument('--num_factors', type = int, default = 8, help = 'Embedding size of MF model.')
	parser.add_argument("--layers', nargs = '?', default = '[64, 32, 16, 8]', help = 'MLP layers. Note that the first layer is the concatenation of user and item embeddings. So layers[0]/2 is the embedding size.")
	parser.add_argument('--reg_mf', type = float, default = 0, help = 'Regularization for MF embeddings.')
	parser.add_argument('--reg_layers', nargs = '?', default = '[0, 0, 0, 0]', help = "Regularization for each MLP layer. reg_layer[0] is the regularization for embeddings.")
	parser.add_argument('--num_neg', type = int, default = 4, help = 'Number of negative instances to pair with a positive instance.')
	parser.add_argument('--lr', type = float, default = 0.001, help = 'Learning')

