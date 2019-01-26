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


    def calc_bow(
   


