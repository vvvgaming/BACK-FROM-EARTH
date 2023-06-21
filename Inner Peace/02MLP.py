import numpy as np

import theano
import theano.tensor as T
import keras
from keras import backend as K
from keras import initializations
from keras.regularizers import l2, activity_l2
from keras.models import Sequential, Graph, Model
from keras.layers.core import Dense, Lambda, Activation
from keras.layers import Embedding, Input, Dense, merge, Reshape, Merge, Flatten, Dropout
from keras.constraints import maxnorm
from keras.optimizers import Adagrad, Adam, SGD, RMSprop
from evaluate import evaluate_model
from Dataset import Dataset
from time import time
import sys
import argparse
import multiprocessing as mp


def parse_args():
	parser = argparse.ArgumentParser(description = "Run MLP.")
	parser.add_argument('--path', nargs = '?', default = 'Data/', help = 'Input data path.')
	parser.add_argument('--dataset', nargs = '?', default = 'ml-1m', help = 'Choose a dataset.')
	parser.add_argument('--epochs', type = int, default = 100, help = 'Number of epochs.')
	parser.add_argument('--batch_size', type = int, default = 256, help = 'Batch size.')
	parser.add_argument('--layers', nargs = '?', default = '[64, 32, 16, 8]', help = "Size of each layer. Note that the concatenation of user and item embedding. So layers[0]/2 is the embedding size.")
	parser.add_argument('--reg_layers', nargs = '?', default = '[0,0,0,0]', help = "Regularization for each layer")
	parser.add_argument('--num_neg', type = int, default = 4, help = 'Number of negatives instances to pair with a positive instances.)
	parser.add_argument('--lr', type = float, default = 0.001, help = 'Learning rate.')
	parser.add_argument('--learner', nargs = '?', default = 'adam', help = 'Specify an optimizer: adagrad, adam, rmsprop, sgd')
	parser.add_argument('--verbose', type = int, default = 1, help = 'Show performance per X iterations')
	parser.add_argument('--out', type = int, default = 1, help = 'Whether to save the trained model.')
	return parser.parse_args()

def init_normal(shape, name = None):
	return initializations.normal(shape, scale = 0.01, name = name)

def get_model(num_user, num_items, layers = [20,10], reg_layers = [0,0]):
	assert len(layers) == len(reg_layers)
	num_layer = len(layers)

	user_input = Input(shape = (1,), dtype = 'int32', name = 'user_input')
	item_input = Input(shape = (1,), dtype = 'int32', name = 'item_input')

	MLP_Embedding_User = Embedding(input_dim = num_users, output_dim = layers[0]/2, name = 'user_embedding',
		init = init_normal, W_regularizer = l2(reg_layers[0]), input_length = 1)
	MLP_Embedding_Item = Embedding(input_dim = num_items, output_dim = layers[0]/2, name = 'item_embedding',
		init = init_normal, W_regularizer = l2(reg_layers[0]), input_length = 1)


	user_latent = Flatten()(MLP_Embedding_User(user_input))
	item_latent = Flatten()(MLP_Embedding_Item(item_input))

	vector = merge([user_latent, item_latent], mode = 'concat')

	for idx in xrange(1, num_layer):
		layer = Dense(layers[idx], W_regularizer = l2(reg_layers[idx]), activation = 'relu', name = 'layer%d' %idx)
		vector = layer(vector)


		prediction = Dense(1, activation = 'sigmoid', init = 'lecum_uniform', name = 'prediction')(vector)


		model = Model(input = [user_input, item_input], output = prediction)


		return model


def get_train_instances(train, num_negatives):
	user_input, item_input, labels = [],[],[]
	num_users = train.shape[0]
	for (u, i) in train.keys():

		user_input.append(u)
		item_input.append(j)
		labels.append(1)

		for t in xrange(num_negatives):
			j = np.random.randint(num_items)
			while train.has_key((u, j)):
				j = np.random.randint(num_items)
			user_input.append(u)
			item_input.append(j)
			labels.append(0)


	return user_input, item_input, labels


if __name__ == '__main__':
	args = parser_args()
	path = args.path
	dataset = args.dataset
	layers = eval(args.layers)
	reg_layers = eval(args.reg_lay)



























