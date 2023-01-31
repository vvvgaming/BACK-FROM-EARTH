import numpy as np
import theano.tensor as T
import keras
from keras import backend as K
from keras import initializations
from keras.models import Sequential, Model, load_model, save_model
from keras.layers.core import Dense, Lambda, Activation
from keras.layers import Embedding, Input, Dense, merge, Reshape, Merge, Flatten
from keras.optimizers import Adagrad, Adam, SGD, RMSprop
from keras.regularizers import l2
from Dataset import Dataset
from evaluate import evaluate_model
from time import time
import multiprocessing as mp
import sys
import math
import argparse


def parse_args():
	parser = argparse.ArgumentParser(description = "Run GMF.")
	parser.add_argument('--path', nargs = '?', default = 'Data/', help = 'Input data path.')
	parser.add_argument('--dataset', nargs = '?', default = 'ml-1m', help = 'Choose a dataset.')
	parser.add_argument('--epochs', type = int, default = 100, help = 'Number of epochs.')
	parser.add_argument('--batch_size', type = int, default = 256, help = 'Batch size.')
	parser.add_argument('--num_factors', type = int, default = 8, help = 'Embedding size.')
	parser.add_argument('--regs', nargs = '?', default = '[0,0]', help = "Regularization for user and item embeddings.")
	parser.add_argument('--num_neg', type = int, default = 4, help = 'Number of negative instances to pair with a positive instance.')
	parser.add_argument('--lr', type = float, default = 0.001, help = 'Learning rate.')
	parser.add_argument('--learner', nargs = '?', default = 'adam', help = 'Specify an optimizer: adagrad, adam, rmsprop, sgd')
	parser.add_argument('--verbose', type = int, default = 1, help = 'Show performance per X iterations')
	parser.add_argument('--out', type = int, default = 1, help = 'Whether to save the trained model.')
	return parser.parse_args()

def init_normal(shape, name = None):
	return initializations.normal(shape, scale = 0.1, name = name)

def get_model(num_user, num_item, latent_dim, regs = [0, 0]):

	user_input = Input(shape = (1,), dtype = 'int32', name = 'user_input')
	item_input = Input(shape = (1,), dtype = 'int32', name = 'item_input')

	MF_Embedding_User = Embedding(input_dim = num_users, output_dim = latent_dim, name = 'user_embedding',
		init = init_normal, W_regularizer = l2(regs[0]), input_length = 1)
	MF_Embedding_Item = Embedding(input_dim = num_items, output_dim = latent_dim, name = 'item_embedding',
		init = init_normal, W_regularizer = l2(regs[1]), input_length = 1)

	user_latent = Flatten()(MF_Embedding_User(user_input))
	item_latent = Flatten()(MF_Embedding_Item(item_input))


	predict_vector = merge([user_latent, item_latent], mode = 'mul')

	prediction = Dense(1, activation = 'sigmoid', init = 'lecun_uniform', name = 'prediction')(predict_vector)

	model = Model(input = [user_input, item_input], output = prediction)

	return model


def get_train_instances(train, num_negatives):
	user_input, item_input, labels = [],[],[]
	num_users = train.shape[0]
	for (u, i) in train.keys():
		user_input.append(u)
		item_input.append(i)
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
	args = parse_args()
	num_factors = args.num_factors
	regs = eval(args.regs)
	num_negatives = args.num_neg
	learner = args.learner
	learning_rate = args.lr
	epochs = args.epochs
	batch_size = args.batch_size
	verbose = args.verbose

	topK = 10
	evaluation_threads = 1
	print("GMF arguments: %s" %(args))
	model_out_file = 'Pretrain/%s_GMF_%d_%d.h5' %(args.dataset, num_factors, time())

	t1 = time()
	dataset = Dataset(args.path +args.dataset)
	train, testRatings, testNegatives = dataset.trainMatrix, dataset.testRatings, dataset.testNegatives
	num_users, num_items = train.shape
	print("Load data done [%.1f s]. #user = %d, #item = %d, #train = %d, #test = %d")
	      %(time()-t1, num_users, num_items, train.nnz, len(testRatings)))

    model = get_model(num_users, num_items, num_factors, regs)
    if learner.lower() == 'adagrad':
    	model.compile(optimizer = Adagrad(lr = learning_rate), loss = 'binary_crossentropy')
    elif learner.lower() == 'rmsprop':
    	model.compile(optimizer = RMSprop(lr = learning_rate), loss = 'binary_crossentropy')
    elif learner.lower() == 'adam':
    	model.compile(optimizer = Adam(lr = learning_rate), loss = 'binary_crossentropy')
    else:
    	model.compile(optimizer = SGD(lr = learning_rate), loss = 'binary_crossentropy')


    t1 = time()
    (hits, ndcgs) = evaluate_model(model, testRatings, testNegatives, topK, evaluation_threads)
    hr, ndcg = np.array(hits).mean(), np.array(ndcgs).mean()

    print('Init: HR = %.4f, NDCG = %.4f\t [%.1f s]' % (hr, ndcg, time() - t1))


    best_hr, best_ndcg, best_iter = hr, ndcg, -1
    for epoch in xrang(epochs):
    	t1 = time()

    	user_input, item_input, labels = get_train_instances(train, num_negatives)


    	hist = model.fit([np.array(user_input), np.array(item_input)],
    		              np.array(labels),
    		              batch_size = batch_size, nb_epoch = 1, verbose = 0, shuffle = True)

    	t2 = time()

    	if epoch %verbose == 0:
    		(hits, ndcgs) = evaluate_model(model, testRatings, topK, evaluation_threads)
    		hr, ndcg, loss = np.array(hits).mean(), np.array(ndcgs), hist.history['loss'][0]
    		print('Interation %d [%.1f s]: HR = %.4f, NDCG = %.4f, loss = %.4f [%.1f s]'
    			% (epoch, t2 - t1, hr, ndcg, loss, time() - t2))

    		if hr > best_hr:
    			best_hr, best_ndcg, best_iter = hr, ndcg, epoch
    			if args.out > 0:
    				model.save_weights(model_out_file, overwrit)














