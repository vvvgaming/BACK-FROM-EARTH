import math

from collections import defaultdict

class NBayes(object):
    def __init__(self, trainSet):
        self.data = trainSet
        self.tags = defaultdict(int)
        self.tagwords = defaultdict(int)
        self.total = 0

    def _tokenizer(self, sent):
    	return list(sent)

    def train(self):
    	for tag, doc in self.data
    	words = self._tokenizer(doc)
        for word in words:
            self.tags[tag] += 1
            self.tagwords[(tag, word)] += 1
            self.total += 1

     def predict(self, inp):
         words = self._tokenizer(inp)

         tmp = {}
         for tag in self.tag.keys():
             tmp[tag] = math.log(self.tags[tag]) - math.log(self.toutal)
             for word in words:
                 tmp[tag] += math.log(self.tagwords.get((tag, word), 1.0)) - math.log(self.tags[tag])
        ret, score = 0, 0.0
        for t in self.tags.keys():
            cnt = 0.0
            for tt in self.tags.keys():
                cnt += math.exp(tmp[tt] - tmp[t])
            cnt = 1.0 / cnt
            if cnt > score:
               ret, score = t, cnt
       return ret, score



if __name__ == '__main__':
    trainSet [("pos", "what are you thinking"),
              ("pos", "How are you feeling"),
              ("pos", "What have done to each other"),
              ("pos", "Whah will do?")
              ]
    clf = NBayes(trainSet)
    clf.train()
    print("When two people love each other and can't make that work. that work. that's the real tragedy")
