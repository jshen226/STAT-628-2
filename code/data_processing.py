import pandas as pd
import numpy as np
import nltk
from nltk.corpus import stopwords
from nltk.corpus import brown
from nltk.stem import WordNetLemmatizer
from nltk.stem.porter import PorterStemmer
#import textblob
import re
import nltk.sentiment


positive = list(pd.read_csv('positive-words.txt',header=None,names=["p"])['p'])
negative = list(pd.read_csv('negative-words.txt',encoding = "ISO-8859-1",header=None,names=['n'])['n'])

business = pd.read_csv("business_subset_train.csv")

review = pd.read_csv("chinese.csv",low_memory=False)
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

#brown_review = list(brown.words(categories='reviews'))
#brown_review = list(set([word.lower() for word in brown_review]))


pattern = r"""(?x)                   
	              (?:[A-Z]\.)+  
                  |[A-Za-z]+(?:[-]\w+)* 
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
pos = []
nega = []
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
    sentence = text1[i]
#    pos.append(0)
#    nega.append(0)
 #   for j in range(len(sentence)):
 #       if sentence[j] in positive:
 #           pos[i] += 1
 #       elif sentence[j] in negative:
 #           nega[i] += 1
    text1[i] = [porter_stemmer.stem(word) for word in text1[i]]
    text1[i] = [wordnet_lemmatizer.lemmatize(word,pos='v') for word in text1[i]]
    print(i)

count = {}

for i in range(len(text1)):
    sentence = text1[i]
    j = 0
    temp = set()
    while j < len(sentence):
        word = sentence[j]
        if word not in count:
            count[word] = 1
        elif word not in temp:
            count[word] += 1
        temp.add(word)
        j= j + 1
    print(i)

print("The length of dictionary is:",len(count.keys()))
#The length of dictionary is: 245344
sorted(count.items(),key=lambda item:item[1],reverse=True)

count_value = np.array(list(count.values()))
count_key = np.array(list(count.keys()))
count_key = count_key[count_value.astype(int)>=20000]

len(count_key)
#1917

count_new = {}
for word in count_key:
    count_new[word] = count[word]

stars = review['stars'].astype(int)


star_count = pd.DataFrame(columns=('WORD', '1STAR', '2STAR' ,'3STAR', '4STAR', '5STAR'))
index = 0
for word in count_new:
    new_line = [word,0,0,0,0,0]
    for i in range(len(text1)):
        sentence1 = text1[i]
        j = 0
        c = 0
        while j < len(sentence1):
            word2 = sentence1[j]
            if word == word2:
                c += 1
            j += 1
        if c > 0:
            new_line[stars[i]] += 1
    star_count.loc[index] = new_line
    index += 1
    print(index)

word_dist = star_count[['1STAR', '2STAR' ,'3STAR', '4STAR', '5STAR']]
word_sum = word_dist.sum(axis=1).astype(int)

review_count = pd.DataFrame(columns=(['index']+list(count_key)+['STAR']))
for k in range(len(text1)):
    new_line = np.zeros(len(count_key)+2)
    new_line[0] = k
    new_line[len(count_key)+1] = int(stars[k])
    sentence = text1[k]
    for n,word in enumerate(count_key):
        i = 0
        while i < len(sentence):
            word2 = sentence[i]
            if word2 in ['not','never','no','hardly','seldom']:
                if (i + 1) < len(sentence):
                    word2 =sentence[i] + " " + sentence[i + 1]
                    i = i + 1
            if word == word2:
                new_line[n+1] += 1
            i = i + 1
    review_count.loc[k] = new_line
    print(k)

############################################
star_count_sum = [120749,82588,111062,205062,326480]
class feature_selection():
    def __init__(self, x, star):
        self.x = x
        self.star = star
    def cal_entropy(self,dist):
        d1 = [num/sum(dist[0]) for num in dist[0]]
        d2 = [num/sum(dist[1]) for num in dist[1]]
        a = sum([-1*value*np.log2(value) for value in d1 if value > 0])
        b = sum([-1*value*np.log2(value) for value in d2 if value > 0])
        p1 = sum(dist[0])/(sum(dist[0])+sum(dist[1]))
        p2 = 1 - p1
        return p1*a+p2*b
    def to_list(self,word):
        yes = [0,0,0,0,0]
        no = [0,0,0,0,0]
        for i in range(len(self.x)):
            temp = 0
            sentence = self.x[i]
            j = 0
            while j < len(sentence):
                word2 = sentence[j]
                if word2 in ['not', 'never', 'no', 'hardly', 'seldom']:
                    if (j + 1) < len(sentence):
                        word2 = sentence[j] + " " + sentence[j + 1]
                        j = j + 1
                if word == word2:
                    temp = 1
                j += 1
            if temp == 1:
                yes[self.star[i]-1] += 1
            else:
                no[self.star[i]-1] += 1
        return [yes,no]
    def info_gain(self,word,total_entropy):
        dist = self.to_list(word)
        entropy = self.cal_entropy(dist)
        return (total_entropy - entropy)

### 3. INFORMATION GAIN ###

# Codes are from Stackoverflow
# https://stackoverflow.com/questions/25462407/fast-information-gain-computation
# Time: very fast
def information_gain(X, y):
    def _calIg():
        entropy_x_set = 0
        entropy_x_not_set = 0
        for c in classCnt:
            probs = classCnt[c] / float(featureTot)
            entropy_x_set = entropy_x_set - probs * np.log(probs)
            probs = (classTotCnt[c] - classCnt[c]) / float(tot - featureTot)
            entropy_x_not_set = entropy_x_not_set - probs * np.log(probs)
        for c in classTotCnt:
            if c not in classCnt:
                probs = classTotCnt[c] / float(tot - featureTot)
                entropy_x_not_set = entropy_x_not_set - probs * np.log(probs)
        return entropy_before - ((featureTot / float(tot)) * entropy_x_set
                                 + ((tot - featureTot) / float(tot)) * entropy_x_not_set)

    tot = X.shape[0]
    classTotCnt = {}
    entropy_before = 0
    for i in y:
        if i not in classTotCnt:
            classTotCnt[i] = 1
        else:
            classTotCnt[i] = classTotCnt[i] + 1
    for c in classTotCnt:
        probs = classTotCnt[c] / float(tot)
        entropy_before = entropy_before - probs * np.log(probs)

    nz = X.T.nonzero()
    pre = 0
    classCnt = {}
    featureTot = 0
    information_gain = []
    for i in range(0, len(nz[0])):
        if (i != 0 and nz[0][i] != pre):
            for notappear in range(pre + 1, nz[0][i]):
                information_gain.append(0)
            ig = _calIg()
            information_gain.append(ig)
            pre = nz[0][i]
            classCnt = {}
            featureTot = 0
        featureTot = featureTot + 1
        yclass = y[nz[1][i]]
        if yclass not in classCnt:
            classCnt[yclass] = 1
        else:
            classCnt[yclass] = classCnt[yclass] + 1
    ig = _calIg()
    information_gain.append(ig)

    return np.asarray(information_gain)

star_count_scale = [num/sum(star_count_sum) for num in star_count_sum]
entropy = sum([-1*value*np.log2(value) for value in star_count_scale])
select = feature_selection(text1,stars)
select.to_list('bill')
import time
start = time.time()
select.info_gain('bill',entropy)
end = time.time()
print(end-start)

info_gain = np.zeros(462)

for i in range(len(count_key)):
    info_gain[i] = select.info_gain(count_key[i],entropy)
    print(i)
star_count_info = star_count.copy()
star_count_info['info'] = info_gain[:461]
star_count_info = star_count_info.sort_values(by='info',ascending=False)
star_count_info.to_csv("star_count_info.csv")
############################################
#############################################
from sklearn.feature_selection import RFE
from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier

X = np.array(review_count.iloc[:,1:1170])
Y = np.array(stars)
names = count_key
lr = DecisionTreeClassifier()
#rank all features, i.e continue the elimination until the last one
rfe = RFE(lr, n_features_to_select=1)

rfe.fit(X,Y)
print(sorted(zip(map(lambda x: round(x, 4), rfe.ranking_), names)))

###########################################################

review_count = review_count.astype(int)
review_count.to_csv('review_count.csv')
star_count.to_csv('star_count.csv')

star_count = star_count.drop('x_square',axis=1)



star_count1 = star_count.copy()

def count(text,word,stars):
    star=[[],[],[],[],[]]
    for i in range(len(text)):
        j=0
        review = text[i]
        count = 0
        while j < len(review):
            word2 = review[j]
            if word2 in ['not', 'never', 'no', 'hardly', 'seldom']:
                if (j + 1) < len(review):
                    word2 = review[j] + " " + review[j + 1]
                    j = j + 1
            if word == word2:
                count += 1
            j += 1

        star[stars[i]-1].append(count)
    return star


a=count(text1,"service",stars)
len(a)


#star_count1['1STAR'] = star_count1['1STAR']/star_count_mean[0]
#star_count1['2STAR'] = star_count1['2STAR']/star_count_mean[1]
#star_count1['3STAR'] = star_count1['3STAR']/star_count_mean[2]
#star_count1['4STAR'] = star_count1['4STAR']/star_count_mean[3]
#star_count1['5STAR'] = star_count1['5STAR']/star_count_mean[4]

word_dist = star_count1[['1STAR', '2STAR' ,'3STAR', '4STAR', '5STAR']]
word_sum = word_dist.sum(axis=1)

for i in range(len(word_sum)):
    temp = star_count1.loc[i]
    temp[1:] = temp[1:]/word_sum[i]

star_count2 = star_count1.copy()
star_count2 = star_count2.drop('WORD',axis=1)



x_square = []
for i in range(star_count2.shape[0]):
    a = star_count2.loc[i]
    x = np.var(a)
    x_square.append(x)

star_count['x_square'] = x_square
star_count = star_count.sort_values(by='x_square',ascending=False)
star_count.to_csv('star_count.csv')

categories = business[['business_id','state','latitude','longitude','categories']]
categories = categories[categories['categories'].notnull()]
dictionary = set()
for sentence in categories['categories']:
    temp = sentence.split(',')
    for i in range(len(temp)):
        if temp[i][0] == ' ':
            temp[i] = temp[i][1:]
        dictionary.add(temp[i])

len(dictionary)
cat_dictionary = {}
for word in dictionary:
    cat_dictionary[word] = 0
    for sentence in categories['categories']:
        temp = sentence.split(',')
        for i in range(len(temp)):
            if temp[i][0] == ' ':
                temp[i] = temp[i][1:]
            if word  == temp[i]:
                cat_dictionary[word] += 1
cat_dictionary = sorted(cat_dictionary.items(),key=lambda item:item[1],reverse=True)

cat = pd.DataFrame(cat_dictionary)
cat.to_csv("cat.csv")

import matplotlib
import matplotlib.pyplot as plt


star_count_info = pd.read_csv("star_count_info.csv")
dat_plot = star_count_info[['info']]
dat_plot.index = range(461)
dat_plot.plot()
plt.show()