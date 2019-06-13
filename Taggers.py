#how to calculate accuracy for unigram, bigram, backoff and regexp tagger

import nltk
from nltk.corpus import treebank
tb_tagged_sents = treebank.tagged_sents()
tb_sents = treebank.sents()

patterns = [
(r'.*ing$', 'VBG'),               # gerunds
(r'.*ed$', 'VBD'),                # simple past
(r'.*es$', 'VBZ'),                # 3rd singular present
(r'.*ould$', 'MD'),               # modals
(r'.*\'s$', 'NN$'),               # possessive nouns
(r'.*s$', 'NNS'),                 # plural nouns
(r'^-?[0-9]+(.[0-9]+)?$', 'CD'),  # cardinal numbers
(r'.*', 'NN')                     # nouns (default)
]

tb_tags = [tag for (word, tag) in treebank.tagged_words()]
tb_tag = nltk.FreqDist(tb_tags)
#b) i)
print(tb_tag.most_common())
print(len(tb_sents))

#uni
n = int(len(tb_tagged_sents)*0.1)
uni_train_sents = tb_tagged_sents[n:]
uni_test_sents = tb_tagged_sents[:n]

unigram_tagger = nltk.UnigramTagger(uni_train_sents)
uni_accuracy = unigram_tagger.evaluate(uni_test_sents)
print("Unigram Accuracy: ", uni_accuracy)

#bi
j = int(len(tb_tagged_sents)*0.1)
bi_train_sents = tb_tagged_sents[n:]
bi_test_sents = tb_tagged_sents[:n]

bigram_tagger = nltk.BigramTagger(bi_train_sents)
bi_accuracy = bigram_tagger.evaluate(bi_test_sents)
print("Bigram Accuracy: ", bi_accuracy)

#backoff
t0 = nltk.DefaultTagger('NN')
t1 = nltk.UnigramTagger(uni_train_sents, backoff=t0)
t2 = nltk.BigramTagger(bi_train_sents, backoff=t1)
print("Backoff Accuracy: ", t2.evaluate(bi_test_sents))

#regex in place of default tagger
t0 = nltk.RegexpTagger(patterns)
t1 = nltk.UnigramTagger(uni_train_sents, backoff=t0)
t2 = nltk.BigramTagger(bi_train_sents, backoff=t1)
print("Regex Backoff Accuracy: ", t2.evaluate(bi_test_sents))

#NONE POS tag
print(bigram_tagger.tag(bi_test_sents))
