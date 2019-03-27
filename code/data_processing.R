library(dplyr)
library(wordcloud2)
word <- read.csv("word_dict.csv")
colnames(word) <- c("word","star1","star2","star3","star4","star5","info")
sum <- word$star1+word$star2+word$star3+word$star4+word$star5
word$sum <- sum  
word_cloud <- word[,c(2,3)]
word_cloud1 <- word_cloud%>%arrange(desc(sum))
word_cloud2 <- word%>%arrange(desc(star1))
word_cloud2 <- word_cloud2[,c(1,8)]
word_cloud3 <- word%>%arrange(desc(star5))
word_cloud3 <- word_cloud3[,c(1,8)]
pic1 <- wordcloud2(word_cloud,minRotation = -pi/3, maxRotation = pi/3,rotateRatio = 0.8)
pic2 <- wordcloud2(word_cloud1,minRotation = -pi/3, maxRotation = pi/3,rotateRatio = 0.8)
pic3 <- wordcloud2(word_cloud2,minRotation = -pi/3, maxRotation = pi/3,rotateRatio = 0.8)
pic4 <- wordcloud2(word_cloud3,minRotation = -pi/3, maxRotation = pi/3,rotateRatio = 0.8)
print(pic1)
print(pic2)
print(pic3)
print(pic4)
letterCloud(word_cloud,word = "Thanks")
