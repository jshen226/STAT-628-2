import pandas as pd
import numpy as np
import nltk
import json
import nltk
from nltk.corpus import stopwords
from nltk.stem import WordNetLemmatizer
from nltk.stem.porter import PorterStemmer
#import textblob
import re
import nltk.sentiment

ourfile = '/Users/dulize/Downloads/review_test.json'
out = []
with open(ourfile, 'r') as fh:
    for line in fh:
        d = json.loads(line)
        out.append(d)

review = pd.DataFrame(out)

review.to_csv("train.csv",index=False)
text = review['text']

stops = stopwords.words('english')
keep = ['he','she','it','they','their','few','most','more','all','any',
        'some','no','nor','not','only','than','very',"don't",'aren',
        "aren't",'couldn',"couldn't",'didn',"didn't",'doesn',"doesn't",
        'hadn',"hadn't",'hasn',"hasn't",'haven',"haven't",'isn',"isn't",
        'mightn',"mightn't",'mustn',"mustn't",'needn',"needn't",'shan',
        "shan't",'shouldn',"shouldn't",'wasn',"wasn't",'weren',"weren't",
        'won',"won't",'wouldn',"wouldn't"]
stops.extend([";",".",":"])
for word in keep:
    stops.remove(word)

pattern = r"""(?x)                   
	              (?:[A-Za-z]\.)+  
                  |[A-Za-z]+(?:[-_]\w+)* 
	              |\.\.\.
	              |(?:[?!;.:])  
	            """

pat_is = re.compile("((?<=it|he)|(?<=she)|(?<=that|this|here)|(?<=there))'s")
pat_s = re.compile("(?<=[a-zA-Z])'s")
pat_wont = re.compile("wo(n't|n)")
pat_shan = re.compile("sha(n't|n)")
pat_not = re.compile("(?<=[a-zA-Z])(n't|n')")
pat_would = re.compile("(?<=[a-zA-Z])'d")
pat_will = re.compile("(?<=[a-zA-Z])'ll")
pat_am = re.compile("(?<=[I|i])'m")
pat_are = re.compile("(?<=[a-zA-Z])'re")
pat_ve = re.compile("(?<=[a-zA-Z])'ve")
pat_th = re.compile("(\d+)(th|st|nd|rd)")
pat_comma = re.compile(",")
pat_neg = re.compile("(\w+)_NEG")


porter_stemmer = PorterStemmer()
wordnet_lemmatizer = WordNetLemmatizer()
text1 = list(text)
text2 = text1.copy()
str = ' '
for i in range(len(text1)):
    if pd.isnull(text1[i]):
        continue
    text1[i] = text1[i].lower()
    text1[i] = pat_shan.sub("shall not",text1[i])
    text1[i] = pat_wont.sub("will not",text1[i])
    text1[i] = pat_th.sub("",text1[i])
    text1[i] = pat_is.sub(" is", text1[i])
    text1[i] = pat_s.sub("", text1[i])
    text1[i] = pat_not.sub(" not", text1[i])
    text1[i] = pat_would.sub(" would", text1[i])
    text1[i] = pat_will.sub(" will", text1[i])
    text1[i] = pat_am.sub(" am", text1[i])
    text1[i] = pat_are.sub(" are", text1[i])
    text1[i] = pat_ve.sub(" have", text1[i])
    text1[i] = pat_comma.sub(".", text1[i])
#   text1[i] = str(textblob.TextBlob(str(text1[i])).correct())
    text1[i] = nltk.regexp_tokenize(text1[i], pattern)
    text1[i] = nltk.sentiment.util.mark_negation(text1[i])
    text1[i] = [word for word in text1[i] if not word in stops]
#    sentence = text1[i]
#    pos.append(0)
#    nega.append(0)
 #   for j in range(len(sentence)):
 #       if sentence[j] in positive:
 #           pos[i] += 1
 #       elif sentence[j] in negative:
 #           nega[i] += 1
 #   text1[i] = [porter_stemmer.stem(word) for word in text1[i]]
 #   text1[i] = [wordnet_lemmatizer.lemmatize(word,pos='v') for word in text1[i]]
    text2[i] = str.join(text1[i])
    print(i)

train_set = pd.DataFrame(text2)
train_set.to_csv('train_set.csv')

text3 = pd.read_csv('train_set.csv',index_col=None)
text3 = text3.iloc[:,1]
text2 = list(text3)
stars = review['stars']
#3170346 is nan,delete
print(np.argwhere(np.isnan(stars)))
hhh=[]
for i in range(len(text3)):
    if pd.isnull(text3[i]):
        hhh.append(i)
    print(i)
#2733591,5083914
text2 = text3.drop(hhh)
stars = stars.drop(hhh)

map = dict((x,y) for x,y in zip(word,range(295)))
from sklearn.feature_extraction.text import CountVectorizer
vectorizer = CountVectorizer(vocabulary=map,binary=True)
vectorizer.fit(text2)
print(vectorizer.vocabulary_)
vector = vectorizer.transform(text2)
print(vector.toarray())

import sklearn
from sklearn.naive_bayes import MultinomialNB
X_train, X_test, y_train, y_test = sklearn.model_selection.train_test_split(vector, stars,test_size=0.2)
clf = MultinomialNB()
clf.fit(X_train, y_train)
pre_NB = clf.predict(X_test)
res = [pre_NB[i] - y_test.iloc[i] for i in range(y_test.shape[0])]
print((sum(x ** 2 for x in res) / len(res)) ** 0.5)


from sklearn import svm
clf = svm.SVC()
clf.fit(vector, stars)
pre_NB = clf.predict(vector)
res = [pre_NB[i] - y_test.iloc[i] for i in range(y_test.shape[0])]
print((sum(x ** 2 for x in res) / len(res)) ** 0.5)

from sklearn.linear_model import LinearRegression
clf = LinearRegression()
from sklearn.linear_model import LogisticRegression
clf = LogisticRegression()

final = pd.DataFrame(columns=['ID','Expected'])
final['ID']=range(1321274)
final['ID']=final['ID']+1
final['Expected']=pre_NB
final.to_csv('submit.csv',index=False)