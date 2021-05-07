# IMDB 영화평 감성분석
#install.packages('text2vec')
library(text2vec) #감성분석
library(caret) # 훈련 테스트 분할할때
library(tm) #doc 쓸때

str(movie_review)
head(movie_review)

# 8:2 비율로 훈련/테스트 데이터셋 분할
set.seed(2021)
train_list <- createDataPartition(y=movie_review$sentiment,
                                  p=0.8, list=F)
mtrain <- movie_review[train_list,]
mtest <- movie_review[-train_list,]

# 훈련 데이터셋에 대해 DTM구축
# 테스트 데이터셋에 대해서도 동일하게 적용해야 함
doc <- Corpus(VectorSource(mtrain$review))
doc <- tm_map(doc, content_transformer(tolower))  # 소문자 변환
doc <- tm_map(doc, removeNumbers)                 # 숫자 제거
stop_words <- c(stopwords('en'),'<br />')
doc <- tm_map(doc, removeWords, stop_words)       # 불용어 제거
doc <- tm_map(doc, removePunctuation)             # 구둣점 제거
doc <- tm_map(doc, stripWhitespace)               # 앞뒤 공백 제거

dtm <- DocumentTermMatrix(doc,
                          control = list(weighting=weightTf)) # weightTf는 tongue frequency 말의 횟수가 많으면 더 강력한 힘을 가짐,
#weightTfIdf는 문서 내 반복한게 많으면 힘의 효력이 하나도 없음
#control=list(tokenize = BigramTokenizer) 이건 N그램 사용하는 코드
dim(dtm)
inspect(dtm)
dtm_tfidf <- DocumentTermMatrix(doc,
                                control = list(weighting=weightTfIdf))
inspect(dtm_tfidf)

# 모델링이 가능한 형태로 DTM을 변환
dtm_small <- removeSparseTerms(dtm,0.9)
dim(dtm_small)
X <- as.matrix(dtm_small)
dataTrain <- as.data.frame(cbind(mtrain$sentiment,X))
head(dataTrain)
colnames(dataTrain)[1] <- 'y' # V1이름 바꾸기
dataTrain$y <- as.factor(dataTrain$y) # 종속변수 factor형 변환
str(dataTrain)

# Decision Tree로 학습
library(rpart)
dt = rpart(y~.,dataTrain)
printcp(dt)

# 테스트 데이터셋으로 모델 성능 평가
docTest <- Corpus(VectorSource(mtest$review))
docTest <- tm_map(docTest, content_transformer(tolower))  # 소문자 변환
docTest <- tm_map(docTest, removeNumbers)                 # 숫자 제거
#stop_words <- c(stopwords('en'),'<br />')
docTest <- tm_map(docTest, removeWords, stop_words)       # 불용어 제거
docTest <- tm_map(docTest, removePunctuation)             # 구둣점 제거
docTest <- tm_map(docTest, stripWhitespace)               # 앞뒤 공백 제거

dtmTest <- DocumentTermMatrix(docTest,
                              control = list(dictionary=dtm_small$dimnames$Terms))
dim(dtmTest)
inspect(dtmTest)

# Sentiment(y)와 DTM_Test를 묶어서 데이터프레임 형성
X <- as.matrix(dtmTest)
dataTest <- as.data.frame(cbind(mtest$sentiment,X))
colnames(dataTest)[1] <- 'y' # V1이름 바꾸기
dataTest$y <- as.factor(dataTest$y) # 종속변수 factor형 변환

#학습했던 모델로 예측 
dt_pred <- predict(dt, dataTest, type='class')
table(dt_pred, dataTest$y)

################
# SVM 으로 훈련
################
library(e1071)

svc <- svm(y~., dataTrain)
sv_pred <- predict(svc, dataTest, type='class')
table(sv_pred, dataTest$y)

###########################
#Tf-Idf로 변환
###########################
dtm_tfidf <- DocumentTermMatrix(doc,
                                control = list(weighting=weightTfIdf))
inspect(dtm_tfidf)

# 모델링이 가능한 형태로 DTM을 변환
dtm_small_tfidf <- removeSparseTerms(dtm,0.9)
dim(dtm_small_tfidf)

# Sentiment(y)와 DTM을 묶어서 데이터프레임을 형성
X <- as.matrix(dtm_small_tfidf)
dataTrain <- as.data.frame(cbind(mtrain$sentiment,X))
head(dataTrain)
colnames(dataTrain)[1] <- 'y' # V1이름 바꾸기
dataTrain$y <- as.factor(dataTrain$y) # 종속변수 factor형 변환
str(dataTrain)

# Decision Tree로 학습
dtm_tfidf <- rpart(y~.,dataTrain)

# Test dataset
dtmTest_tfidf <- DocumentTermMatrix(docTest,
                              control = list(dictionary=dtm_small_tfidf$dimnames$Terms,
                                             weighting=weightTfIdf))
X <- as.matrix(dtmTest_tfidf)
dataTest <- as.data.frame(cbind(mtest$sentiment,X))
colnames(dataTest)[1] <- 'y' # V1이름 바꾸기
dataTest$y <- as.factor(dataTest$y) # 종속변수 factor형 변환

# 예측
dt_pred_tfidf <- predict(dtm_tfidf, dataTest, type='class')
table(dt_pred_tfidf, dataTest$y)


