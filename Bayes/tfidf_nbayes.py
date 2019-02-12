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
        if len(words) == 0:
           continue
        self.tags[tag] += 1
        self.total += 1
        self.docs.append((tag,words))
        vocabs.update(words)
    vocabs = list(vocabs)
    self.word2idx = dict(zip(vocabs, range(len(vocabs))))


def calc_bow(self):
    bow = np.zeros([self.total, len(self.word2idx)])

    for docidx, (tag, doc) in enumerate(self.docs):
        for word in doc:
            bow[docidx, self.word2idx[word]] += 1
       return bow


def calc_tfidf(self):
    tf = self.calc_bow()
    df = np.ones([1, len(self.word2idx)])

    for docidx, (tag, doc) in enumberate(self.docs):
   
   


