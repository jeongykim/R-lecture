# dplyr 라이브러리를 이용한 데이터 가공
# filter, select, arrange, group_by&summarize, mutate
# %>% 
library(dplyr)
library(gapminder)

# 1. select - 원하는 열을 추출 
select(gapminder, country,year,lifeExp)
select(gapminder, country,year,lifeExp) %>% head()
select(gapminder, country,year,lifeExp) %>% head(10)

# 2. filter - 원하는 행을 추출
filter(gapminder,country=="Croatia") 
filter(gapminder,country=="Croatia"& year>2000)
filter(gapminder,continent=="Europe"& year==2007)

# 3. arrange - 정렬, 디폴트 값은 오름차순
europe_pop <- filter(gapminder,continent=="Europe"& year==2007)
arrange(europe_pop, lifeExp)
arrange(europe_pop, desc(lifeExp)) # desc는 내림차순

# 3-2 아프리카 대륙에서 평균 수명이 가장 긴 나라 5곳
africa_pop <- filter(gapminder,continent=="Africa"&year==2007)
arrange(africa_pop,desc(lifeExp)) %>% head(5)

# 3-3 한번에 하기
gapminder %>% 
  filter(continent=="Africa"&year==2007) %>%
  arrange(desc(lifeExp)) %>% 
  head(5)

# 4. group_by 와 summarize
summarize(africa_pop,pop_avg=mean(pop)) # 2007년 아프리카 국가별 평균 인구 수
summarise(group_by(gapminder, continent), pop_avg=mean(pop)) # 전체 국가별 평균 인구수
summarise(group_by(gapminder, country),life_avg=mean(lifeExp)) 

# 4-2 변수 저장하고 summarise 사용하기
asia_pop <- gapminder %>% filter(continent=='Asia')
summarise(group_by(asia_pop,country),life_avg=mean(lifeExp)) 
summarise(group_by(asia_pop,country),life_avg=mean(lifeExp))%>% 
  arrange(desc(life_avg)) %>% 
  head(5)

# 4-3 한방에 하기
gapminder %>% 
  filter(continent=='Asia') %>% 
  group_by(country) %>% 
  summarise(life_avg=mean(lifeExp)) %>% 
  arrange(desc(life_avg)) %>% 
  head(5)

# 4-4 2007 인구수 5000만 이상인 국가중 기대수명이 가장 큰 Top 5 국가

gapminder %>% 
  filter(pop>=50000000 & year == '2007') %>%  # 50000000 대신에 5e7을 넣어도 됨
  group_by(country) %>% 
  summarise(life_avg=mean(lifeExp)) %>% 
  arrange(desc(life_avg)) %>% 
  head(5)

# 5. mutate 함수 사용하기 - mpg 자료 활용

# 5-2 mpg(mile-per-gallon)
#install.packages('ggplot2')
library(ggplot2)
head(mpg)

# 5-3 구성 displ=배기량,cyl=실린더개수, cty=연비, hwy=하이웨이의 평균연비
str(mpg) # 자료 구조 보기
glimpse(mpg) # 자료 구조 보기
summary(mpg) # 요약 통계량 보기

# 5-4 통합연비 변수
mpg$total <- (mpg$cty + mpg$hwy) /2 # 평균 연비 구하는 식
head(mpg)
mean(mpg$total)
summary(mpg$total)
hist(mpg$total)

# 5-5 평균연비가 20 이상이면 합격, 아니면 불합격
mpg$test <- ifelse(mpg$total>=20, 'pass', 'fail')
table(mpg$test)
qplot(mpg$test)

# 5-6 평균연비가 30 이상이면 A등급, 20 이상이면 B등급, 아니면 C등급
mpg$grade <- ifelse(mpg$total>=30, 'A',
                    ifelse(mpg$total>=20, 'B', 'C'))
table(mpg$grade)
qplot(mpg$grade)

# 5-7 mutata
mpg <- mpg %>% 
  mutate(grade2= ifelse(mpg$total>=30, 'A',
                        ifelse(mpg$total>=20, 'B', 'C'))) 

table(mpg$grade2)


# 연습문제 6-2
mpg %>% 
  filter(manufacturer %in% c('audi', 'toyota')) %>% 
  group_by(manufacturer) %>% 
  summarise(avg_cty=mean(cty)) %>% 
  arrange(desc(avg_cty))



