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
            tf[docidx] /= np.max(tf[docidx])
            for word in doc:
                df[0, self.word2idx[word] += 1
        idf = np.log(float(self.total)) - np.log(df)
        return np.multiply(tf, idf)


    def get_vec(self, words):
        vec = np.zeros([1, len(self.word2idx)])
        for word in words:
            if word in self.word2idx:
                vec[0, self.word2idx[word]] += 1
        return vec

class NBayes(Corpus):
    def __init__(self, docs, kernel='tfidf'):
        super(NBayes, self).__init__()
        self.kernel = kernel
        self.process_data(docs)
        self.y_prob = {}
        self.c_prob = None

    def train(self):
        if self.kernel == 'tfidf':
            self.feature = self.calc_tfidf()
        else:
            self.feature = self.calc_bow()

        for tag in self.tags:
            self.y_prob[tag] = float(self.tags[tag]) / self.total

        self.c_prob = np.zeros([len(self.tags), len(self.word2idx)])
        Z = np.zeros([len(self.tags), 1])
        for docidx in range(len(self.docs)):
            tid = self.tags.keys().index(self.docs[docidx][0])
            self.c_prob[tid] += self.feature[docidx]
            Z[tid] = np.sum(self.c_prob[tid])
        self.c_prob /= Z 

    def predict(self, sent):
        words = self.tokenizer(sent)
        vec = self.get_vec(words)
        ret, max_score = None, -1.0
        for y, pc in zip(self.y_prob, self.c_prob):
            score = np.sum(vec * pc * self.y_prob[y]) # p(x1....xn|yi)p(yi)
            if score > max_score:
                max_score = score
                ret = y
        return ret, 1 - max_score

if __name__ == '__main__':
    trainSet [("pos", "what are you thinking"),
              ("pos", "How are you feeling"),
              ("pos", "What have done to each other"),
              ("pos", "Whah will do?")
              ]
    nb = NBayes(trainSet)
    nb.train()
    print(nb.predict("When two people love each other and can't make that work. that work. that's the real tragedy"))        
   
   


