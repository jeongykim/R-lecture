women
plot(women)

str(cars)

# 두 줄을 선택한 후 상단에 있는 'Run' 버튼을 누르면 한꺼번에 실행됨
a <- 2
b <- a+2

# 작업 디렉토리 지정
getwd()
setwd('/workspace/R')
getwd()

library(dplyr)
library(ggplot2)
search() #현재 설치 되어있는 패키지를 알려줌

str(iris)
head(iris) # Default 는 6
head(iris, 10)
tail(iris) # 끝에서 6개 보여줌
plot(iris)

# 두 속성의 상관 관계
plot(iris$Petal.Length, iris$Petal.Width, col=iris$Species, pch=17)

# tips -csv download
tips = read.csv('https://raw.githubusercontent.com/mwaskom/seaborn-data/master/tips.csv')
head(tips)
str(tips)

# 요약통계
summary(tips)

# ggplot2 그림 그리기
tips %>% ggplot(aes(size))+geom_histogram() #빈도 수 나타냄 , 히스토그램
tips %>% ggplot(aes(total_bill,tip)) +geom_point() #산점도 그리기 , 산점도
tips %>% ggplot(aes(total_bill,tip)) +geom_point(aes(col=day))
tips %>% ggplot(aes(total_bill,tip)) +geom_point(aes(col=day,pch=sex),size=3)
tips %>% ggplot(aes(total_bill,tip)) +geom_point(aes(col=day,pch=time),size=3)

