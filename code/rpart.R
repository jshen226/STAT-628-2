require(rpart)
require(rpart.plot)
df <- read.csv('clean_attributes.csv', header = T, na.strings=c())
df <- df[, -1]
#The missing rate of all the attributes is around 0.5
sum(is.na(df)) / (5693*68)
df1 <- df[, -which(apply(df, 2, function(x){
  sum(is.na(x)) / 5693
}) > 0.5)]
#After deleting columns with missing rate > 0.5, the total missing rate reduces to 0.165
sum(is.na(df1)) / (5693*37)
tree <- rpart(american_traditional_star ~ ., method = 'anova', data = df1,
              control = list(maxdepth = 3, cp = 0))
rpart.plot(tree)