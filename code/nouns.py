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


review = pd.read_csv("American_traditional.csv",low_memory=False)
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
pat_neg = re.compile("(\w+)_NEG")
pos_tag = nltk.pos_tag(word)
nouns = []
for words, pos in pos_tag:
    if (pos == 'NN' or pos == 'NNP' or pos == 'NNS' or pos == 'NNPS'):
        nouns.append(words)
for i in range(len(nouns)):
    nouns[i] = pat_neg.sub('',nouns[i])
pop = []
for i in range(len(nouns)):
    if nouns[i] == '':
        pop.append(i)
nouns = pd.Series(nouns)
nouns = nouns.drop(pop)
nouns = list(nouns)

map = dict((x,y) for x,y in zip(nouns,range(295)))
from sklearn.feature_extraction.text import CountVectorizer
vectorizer = CountVectorizer(vocabulary=map,binary=True)
vectorizer.fit(text2)
print(vectorizer.vocabulary_)
vector = vectorizer.transform(text2)
print(vector.toarray())

stars = review['stars'].astype(int)
from sklearn.linear_model import LinearRegression
clf = LinearRegression()
clf.fit(vector, stars)
noun_final = pd.DataFrame(columns=['word','coeff'])
noun_final['word'] = nouns
noun_final['coeff'] = clf.coef_
ascend = noun_final.sort_values(by='coeff',ascending=False)
descend = noun_final.sort_values(by='coeff')
ascend.to_csv("ascend.csv")
descend.to_csv("descend.csv")