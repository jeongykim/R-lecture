getwd()
setwd("/workspace/r")
getwd()

avocado <- read.csv('avocado.csv')
glimpse(avocado)
str(avocado)
library(ggplot2)

#Total.Volume - 판매량

# 지역별 평균 판매량과 가격
avocado %>% 
  group_by(region) %>% 
  summarize(P_avg = mean(AveragePrice),V_avg = mean(Total.Volume))

# 지역별 연도별 평균 판매량과 가격
avocado %>% 
  group_by(region,year) %>% 
  summarize(P_avg = mean(AveragePrice),V_avg = mean(Total.Volume))

# 지역별 연도별 유기농여부 평균 판매량과 가격
avocado %>% 
  group_by(region,year,type) %>% 
  summarize(P_avg = mean(AveragePrice),V_avg = mean(Total.Volume))

# 그래프 시각화 하기 avocado 총 판매량의 연도별 변화
#library(ggplot2)
avocado %>% 
  group_by(region,year,type) %>% 
  summarize(P_avg = mean(AveragePrice),V_avg = mean(Total.Volume)) %>% 
  filter(region !="TotalUS") %>% 
  ggplot(aes(year,V_avg, col = type)) +
  geom_line() +
  facet_wrap(~region)

x_avg <- avocado %>% 
  group_by(region,year,type) %>% 
  summarize(P_avg = mean(AveragePrice),V_avg = mean(Total.Volume)) 
arrange(x_avg, desc(V_avg)) %>% head(10)

x_avg <- x_avg %>% 
  filter(region != "TotalUS")
arrange(x_avg, desc(V_avg)) %>% head(10)

avocado %>% 
  filter(region =="California"&year==2018) %>% 
  select(region, Date, AveragePrice, Total.Volume, type)

# 연도별이 아닌 월별 집계
install.packages("lubridate")
library(lubridate)
library(dplyr)
year('2021-04-26')
month('2021-04-26')
day(as.Date('2021-04-26'))
wday('2021-04-26')

m_avg <- avocado %>%
  group_by(region, year, month(Date), type) %>%
  summarize(P_avg=mean(AveragePrice),V_avg=mean(Total.Volume))
head(m_avg)
