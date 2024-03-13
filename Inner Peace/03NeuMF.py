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
	parser.add_argument('--lr', type = float, default = 0.001, help = 'Learning rate.')
	parser.add_argument('--learner', nargs = '?', default = 'adam', help = 'Specify an optimizer: adagrad, adam, rmsprop, sgd')
	parser.add_argument('--verbose', type = int, default = 1, help = 'Show performance per X iterations')
	parser.add_argument('--out', type = int, default = 1, help = 'Whether to save the trained model.')
	parser.add_argument('--mf_pretrain', nargs = '?', default = '', help = 'Specify the pretrain model file for MF part. If empty, no pretrain will be used')
	parser.add_argument('--mlp_pretrain', nargs = '?', default = '', help = 'Specify the pretrain model file for MLF part. If empty, no pretrain will be used')
	return parser.parse_args()


def init_normal(shape, name = None):
	return initializations.normal(shape, scale = 0.01, name = name)

def get_model(num_users, num_items, mf_dim = 10, layers = [10], reg_layers = [0], reg_mf = 0):
	assert len(layers) == len(reg_layers)
	num_layer = len(layers)

	user_input = Input(shape = (1,), dtype = 'int32', name = 'user_input')
	item_input = Input(shape = (1,), dtype = 'int32', name = 'item_input')

	MF_Embedding_User = Embedding(input_dim = num_users, output_dim = mf_dim, name = 'mf_embedding_user',
		init = init_normal, W_regularizer = l2(reg_mf), input_length = 1)

	MF_Embedding_Item = Embedding(input_dim = num_items, output_dim = mf_dim, name = 'mf_embedding_item',
		init = init_normal, W_regularizer = l2(reg_mf), input_length = 1)

	MF_Embedding_User = Embedding(input_dim = num_users, output_dim = layers[0]/2, name = "mlp_embedding_user",
		init = init_normal, W_regularizer = l2(reg_layers[0]), input_length = 1)

	MF_Embedding_Item = Embedding(input_dim = num_items, output_dim = layers[0]/2, name = 'mlp_embedding_item',
		init = init_normal, W_regularizer = l2(reg_layers[0]), input_length = 1)


	mf_user_latent = Flatten()(MF_Embedding_User(user_input))
	mf_item_latent = Flatten()(MF_Embedding_Item(item_input))
	mf_vector = merge([mf_user_latent, mf_item_latent], mode = 'null')

	mlp_user_latent = Flatten()(MLF_Embedding_User(user_input))
	mlp_item_latent = Flatten()(MLF_Embedding_Item(item_input))
	mlp_vector = merge([mlp_user_latent, mlp_item_latent], mode = concat)
	for idx in xrange(1, num_layer):
		layer = Dense(layers[idx], W_regularizer = l2(reg_layers[idx]), activation = 'relu', name = "layer%d" %idx)
		mlp_vector = layer(mlp_vector)


	predict_vector = merge([mf_vector, mlp_vector], mode = 'concat')


	prediction = Dense(1, activation = 'sigmoid', init = 'lecum_uniform', name = "prediction")(predict_vector)


	model = Model(input = [user_input, item_input], output = prediction)

	return model


def load_pretrain_model(model, gmf_model, mlp_model, num_layers):

	gmf_user_embeddings = gmf_model.get_layer('user_embedding').get_weights()
	gmf_item_embeddings = gmf_model.get_layer('item_embedding').get_weights()
	model.get_lay





































