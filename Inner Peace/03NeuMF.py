import numpy as np

import theano
import theano.tensor as T
import keras
from keras import backend as K
from keras import initializations
from keras.regularizers import l1, l2, l1l2
from keras.model import Sequential, Mo