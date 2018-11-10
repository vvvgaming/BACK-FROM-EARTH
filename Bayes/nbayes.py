import math

from collections import defaultdict

class NBayes(object):
    def __init__(self, trainSet):
        self.data = trainSet
        self