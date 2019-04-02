rm(list = ls())
library(car)

setwd("C:/Users/kitty/Desktop/Stat628/Module2due19.03.04_03.25")
attributes=read.csv("clean_attributes.csv",header=T)
attributes=attributes[,-1]
head(attributes)
attach(attributes)
star=american_traditional_star


star[which(goodforkids==goodforkids[!duplicated(goodforkids)][1])]
star[which(goodforkids==goodforkids[!duplicated(goodforkids)][3])]

t.test(star[which(goodforkids==goodforkids[!duplicated(goodforkids)][1])],star[which(goodforkids==goodforkids[!duplicated(goodforkids)][3])])


anova(lm(star~goodforkids))
boxplot(star~goodforkids)

anova(lm(star~noiselevel))
boxplot(star~noiselevel)

anova(lm(star~attributes[,4]))

attributes1=attributes[,-c(40,65,67)]
p=c()
p[1]=0
for(i in 2:ncol(attributes1)){
  p[i]=anova(lm(star~attributes1[,i]))$`Pr(>F)`[1]
}

colnames(attributes1)[65]
acceptsinsurance[!duplicated(acceptsinsurance)]
byob[!duplicated(byob)]
restaurantscounterservice[!duplicated(restaurantscounterservice)]

a=c(3,1,6,8,10)
order(a)
sort(a)

outcome=cbind(colnames(attributes1)[order(p)],sort(p))

outcome[1:20,]


