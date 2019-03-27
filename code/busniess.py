import pandas as pd
import numpy as np
import nltk


business = pd.read_csv("business_subset_train.csv")
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
