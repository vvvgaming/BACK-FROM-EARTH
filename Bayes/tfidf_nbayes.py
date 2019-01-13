import jieba
import numpy as np
from collections import defaultdict

class Corpus(object):
    def __init__(self):
        self.word2idx = {}
        self.tags = defaultdict(int)
        self.docs = []
        self.total = 0

    def tokenizer(self, docs)
        return jieba.lcut(sent)



def process_data(self, docs):
    vocabs = set()
    for tag, doc in docs:
        words = self.tokenizer(doc)
        if 


