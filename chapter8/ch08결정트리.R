# 분류(Classification)
# 결정트리 (Decision Tree)
library(rpart)
head(iris)
dtc <- rpart(Species~.,iris) # iris 데이터를 결정 트리로 학습
summary(dtc)
dtc

# 결정 트리 시각화
par(mfrow=c(1,1),xpd=NA) #텍스트 잘린 부분 포함해서 출력
plot(dtc)
text(dtc, use.n=T)

# 예측
pred <- predict(dtc,iris,type='class')
table(pred, iris$Species)

# 평가
#install.packages('caret')
library(caret)
confusionMatrix(pred, iris$Species)

# 시각화
install.packages('rpart.plot')
library(rpart.plot)
rpart.plot(dtc)
rpart.plot(dtc,type=4) # type=5까지 있음


