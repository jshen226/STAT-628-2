import pandas as pd
import numpy as np
import nltk
from nltk.corpus import stopwords
from nltk.stem import WordNetLemmatizer
from nltk.stem.porter import PorterStemmer
import textblob
import re

business = pd.read_csv("business_subset_train.csv")
review = pd.read_csv("review_train_subset.csv")
text = review['text']

pattern = r"""(?x)                   
	              (?:[A-Z]\.)+  
                  |[A-Za-z]+(?:[-]\w+)* 
	              |\.\.\.
	              |(?:[?!])  
	            """

pat_is = re.compile("(it|he|she|that|this|there|here)'s", re.I)
pat_s = re.compile("(?<=[a-zA-Z])'s")
pat_not1 = re.compile("(?<=[a-zA-Z])n't")
pat_not2 = re.compile("(?<=[a-zA-Z])n'")
pat_would = re.compile("(?<=[a-zA-Z])'d")
pat_will = re.compile("(?<=[a-zA-Z])'ll")
pat_am = re.compile("(?<=[I|i])'m")
pat_are = re.compile("(?<=[a-zA-Z])'re")
pat_ve = re.compile("(?<=[a-zA-Z])'ve")

porter_stemmer = PorterStemmer()
wordnet_lemmatizer = WordNetLemmatizer()

text1 = list(text)

for i in range(len(text1)):
    text1[i] = text1[i].lower()
    text1[i] = pat_is.sub(" is", text1[i])
    text1[i] = pat_s.sub("", text1[i])
    text1[i] = pat_not1.sub(" not", text1[i])
    text1[i] = pat_not2.sub(" not", text1[i])
    text1[i] = pat_would.sub(" would", text1[i])
    text1[i] = pat_will.sub(" will", text1[i])
    text1[i] = pat_am.sub(" am", text1[i])
    text1[i] = pat_are.sub(" are", text1[i])
    text1[i] = pat_ve.sub(" have", text1[i])
    text1[i] = str(textblob.TextBlob(str(text1[i])).correct())
    text1[i] = nltk.regexp_tokenize(text1[i], pattern)
    text1[i] = [wordnet_lemmatizer.lemmatize(word) for word in text1[i]]
    text1[i] = [wordnet_lemmatizer.lemmatize(word,pos='v') for word in text1[i]]
    print(i)

count = {}

for i in range(len(text1)):
    sentence = text1[i]
    j = 0
    while j < len(sentence):
        word = sentence[j]
        if word in ['not','never','no','hardly','seldom']:
            if (j+1) < len(sentence):
                word = sentence[j] + " " + sentence[j+1]
                j = j + 1
        if word not in count:
            count[word] = 1
        else:
            count[word] += 1
        j= j + 1


print("The length of dictionary is:",len(count.keys()))
#The length of dictionary is: 6475
sorted(count.items(),key=lambda item:item[1],reverse=True)

count_value = np.array(list(count.values()))
count_key = np.array(list(count.keys()))
count_key = count_key[count_value.astype(int)>=5]

len(count_key)
#1950
count_new = {}
for word in count_key:
    count_new[word] = count[word]

star = review['stars']

star_count = pd.DataFrame(columns=('WORD', '1STAR', '2STAR' ,'3STAR', '4STAR', '5STAR'))
index = 0
for word in count_new:
    new_line = [word,0,0,0,0,0]
    for i in range(len(text1)):
        sentence1 = text1[i]
        j = 0
        while j < len(sentence1):
            word2 = sentence1[j]
            print(word2)
            if word2 in ['not','never','no','hardly','seldom']:
                if (j + 1) < len(sentence1):
                    word2 =sentence1[j] + " " + sentence1[j + 1]
                    j = j + 1
            if word == word2:
                new_line[int(star[i])] += 1
            j += 1
    star_count.loc[index] = new_line
    index += 1

review_count = pd.DataFrame(columns=(['index']+list(count_key)+['STAR']))
for k in range(len(text1)):
    new_line = np.zeros(1952)
    new_line[0] = k
    new_line[1951] = int(star[k])
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
review_count = review_count.astype(int)
review_count.to_csv('review_count.csv')
star_count.to_csv('star_count.csv')
star_count = star_count.drop('x_square',axis=1)

word_dist = star_count[['1STAR', '2STAR' ,'3STAR', '4STAR', '5STAR']]
star_count_mean = word_dist.mean(axis=0)
word_sum = word_dist.sum(axis=1)

star_count1 = star_count.copy()
star_count1['1STAR'] = star_count1['1STAR']/star_count_mean[0]
star_count1['2STAR'] = star_count1['2STAR']/star_count_mean[1]
star_count1['3STAR'] = star_count1['3STAR']/star_count_mean[2]
star_count1['4STAR'] = star_count1['4STAR']/star_count_mean[3]
star_count1['5STAR'] = star_count1['5STAR']/star_count_mean[4]

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
    x = (a - a.mean()).dot(a - a.mean()) / a.mean()
    x_square.append(x)

star_count['x_square'] = x_square
star_count = star_count.sort_index(by='x_square',ascending=False)
star_count.to_csv('star_count.csv')

categories = business[['business_id','state','latitude','longitude','categories']]
categories = categories[categories['categories'].notnull()]
dictionary = set()
for sentence in categories['categories']:
    temp = sentence.split(',')
    for i in range(len(temp)):
        dictionary.add(temp[i])

len(dictionary)
cat_dictionary = {}
for word in dictionary:
    cat_dictionary[word] = 0
    for sentence in categories['categories']:
        temp = sentence.split(',')
        for i in range(len(temp)):
            if word  == temp[i]:
                cat_dictionary[word] += 1
cat_dictionary = sorted(cat_dictionary.items(),key=lambda item:item[1],reverse=True)

cat = pd.DataFrame(cat_dictionary)
cat.to_csv("cat.csv")