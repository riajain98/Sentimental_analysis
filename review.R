
dataset = read.csv("APR.csv")
#dataset

library('tm')
library('SnowballC')

dataset$reviews.rating = factor(dataset$reviews.rating, levels = c(1,2,3,4,5))

corpus = VCorpus(VectorSource(dataset$reviews.text))
corpus = tm_map(corpus, content_transformer(tolower))
corpus = tm_map(corpus, removeNumbers)
corpus = tm_map(corpus, removePunctuation)
corpus = tm_map(corpus, removeWords, stopwords())
corpus = tm_map(corpus, stemDocument)
corpus = tm_map(corpus, stripWhitespace)

library('caTools')
set.seed(123)
split = sample.split(corpus, SplitRatio = 0.75)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

#Feature Scaling
#training_set[2] = scale(training_set[2])
#test_set[2] = scale(test_set[2])

#Fitting Random Foreest Classification to training set
library(randomForest)
classifier = randomForest(x = training_set,
                          y = corpus,
                          ntrees = 100)

#Predicting the test set result






