import pandas as pd
import numpy as np
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
#The length of dictionary is: 211683
count = sorted(count.items(),key=lambda item:item[1],reverse=True)

word_dict = pd.DataFrame(count)
word_dict = word_dict.iloc[:5000,:]
word_dict.to_csv("word_dict.csv")

count_value = np.array(list(count.values()))
count_key = np.array(list(count.keys()))
count_key = count_key[count_value.astype(int)>=4000]

len(count_key)
#1767


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


import matplotlib.pyplot as plt

star_count_info = pd.read_csv("star_count_info.csv")
dat_plot = star_count_info[['info']]
dat_plot.index = range(461)
dat_plot.plot()
plt.show()

