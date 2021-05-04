# 와인 데이터 

getwd()
setwd('/Workspace/R/data')
getwd()
wines <- read.table('wine.data.txt', header=F, sep =",")
names(wines) <- c("target","Alcohol","Malicacid","Ash","Alcalinityofash","Magnesium","Totalphenols","Flavanoids","Nonflavanoidphenols",
                  "Proanthocyanins","Colorintensity","Hue","OD280OD315ofdilutedwines","Proline")

library(rpart)
library(caret)
library(rpart.plot)

wines
str(wines)
wines$target <- factor(wines$target) #목표변수를 Factor로 변환
str(wines) 

#의사결정나무
set.seed(2021)
train_index <- createDataPartition(wines$target, p = 0.8, list=F)
wines_train <- wines[train_index,]
wines_test <- wines[-train_index,]

#모델링
dtc1 <- rpart(target~., wines_train)

#예측
pred1 <- predict(dtc1, wines_test, type='class')

#평가
confusionMatrix(pred1,wines_test$target)

# 0.9118의 정확도를 보임

#랜덤포레스트
library(randomForest)
set.seed(2021)
train_index <- createDataPartition(wines$target, p = 0.8, list=F)
wines_train2 <- wines[train_index,]
wines_test2 <- wines[-train_index,]

#모델링
dtc2 <- randomForest(target~., wines_train2)

#예측
pred2 <- predict(dtc2, wines_test2, type='class')

#평가
confusionMatrix(pred2,wines_test2$target)
# 랜덤 포레스트는 0.9706의 정확도를 보임

#신경망 모형
set.seed(2021)
train_index <- createDataPartition(wines$target,p=0.8,list=F)
wines_train3 <- wines[train_index,]
wines_test3 <- wines[-train_index,]

library(caret)
library(e1071)

svc1 <- svm(target~., wines_train3)
pred3 <- predict(svc1, wines_test3, type='class')
table(pred3, wines_test3$target)
confusionMatrix(pred3, wines_test3$target) 
# 1
library(class)
k <- knn(wines_train3[, 1:14], wines_test3[, 1:14], 
         wines_train3$target, k=5)
k
wines_test3$target
confusionMatrix(k, wines_test3$target)
#0.7059의 정확도가 나옴