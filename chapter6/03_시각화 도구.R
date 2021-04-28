# 시각화 도구
library(dplyr)
library(ggplot2)
library(gapminder)

# 1. plot
head(cars)
plot(cars, type='p', main = 'cars') # p - point, main= title
plot(cars, type='l', main = 'cars') # l - line, main= title
plot(cars, type='b', main = 'cars') # b - both point and line
plot(cars, type='h', main = 'cars') # h - histogram

x <- gapminder %>% 
  filter(year==1952 & continent=='Asia') %>% 
  mutate(gdp=gdpPercap*pop) %>% 
  select(country, gdp) %>% 
  arrange(desc(gdp)) %>% 
  head()
pie(x$gdp, x$country)
barplot(x$gdp,names.arg = x$country)

# 3. matplot
matplot(iris[,1:4], type = 'l')
legend('topleft',
       names(iris)[1:4],
       lty=c(1:4),
       col=c(1:4))

# 4. histogram
hist(cars$speed)
hist(iris$Sepal.Length)

## ggplot2 라이브러리
# geom_histogram
gapminder %>% 
  filter(year==2007) %>% 
  ggplot(aes(lifeExp, col=continent)) +    #col=continent: 영역별 색깔
  geom_histogram()

gapminder %>% 
  filter(year==2007) %>% 
  ggplot(aes(lifeExp, col=continent)) +    #col=continent: 영역별 색깔
  geom_histogram(position = 'dodge')

# 2. geom_boxplot
gapminder %>% 
  filter(year==2007) %>% 
  ggplot(aes(continent,lifeExp,col=continent)) +
  geom_boxplot()

# 3. scale_x_log10(),scale_y_log10()
par(mfrow=c(4,4))
ggplot(gapminder, aes(gdpPercap,lifeExp,col=continent)) +
  geom_point(alpha=0.2)
ggplot(gapminder, aes(gdpPercap,lifeExp,col=continent)) +
  geom_point(alpha=0.2) +
  scale_x_log10()

# 4. coord_flip()
gapminder %>% 
  filter(continent=='Africa') %>% 
  ggplot(aes(country,lifeExp)) +
  geom_bar(stat='identity')

gapminder %>% 
  filter(continent=='Africa') %>% 
  ggplot(aes(country,lifeExp,col=country)) +
  geom_bar(stat='identity') +
  coord_flip()

# 5. scale_fill_brewer()
library(RColorBrewer)
display.brewer.all()

# 기본 팔레트
gapminder %>% 
  filter(lifeExp >70) %>% 
  group_by(continent) %>% 
  summarise(n=n_distinct(country)) %>% 
  ggplot(aes(continent,n)) +
  geom_bar(stat='identity', aes(fill=continent))

# Spectral 팔레트
gapminder %>% 
  filter(lifeExp >70) %>% 
  group_by(continent) %>% 
  summarise(n=n_distinct(country)) %>% 
  ggplot(aes(continent,n)) +
  geom_bar(stat='identity', aes(fill=continent)) +
  scale_fill_brewer(palette='Spectral')

# Blues pallet 
gapminder %>% 
  filter(lifeExp >70) %>% 
  group_by(continent) %>% 
  summarise(n=n_distinct(country)) %>% 
  ggplot(aes(continent,n)) +
  geom_bar(stat='identity', aes(fill=continent)) +
  scale_fill_brewer(palette='Blues')

# RdBu pallet 
gapminder %>% 
  filter(lifeExp >70) %>% 
  group_by(continent) %>% 
  summarise(n=n_distinct(country)) %>% 
  ggplot(aes(continent,n)) +
  geom_bar(stat='identity', aes(fill=continent)) +
  scale_fill_brewer(palette='RdBu')

# 그래프 표시 순서
gapminder %>% 
  filter(lifeExp >70) %>% 
  group_by(continent) %>% 
  summarise(n=n_distinct(country)) %>% 
  ggplot(aes(reorder(continent,n),n)) +        #오름차순으로 그려주는것
  geom_bar(stat='identity', aes(fill=continent)) +
  scale_fill_brewer(palette='Blues')

gapminder %>% 
  filter(lifeExp >70) %>% 
  group_by(continent) %>% 
  summarise(n=n_distinct(country)) %>% 
  ggplot(aes(reorder(continent,-n),n)) +      #내림차순으로 그려주는것
  geom_bar(stat='identity', aes(fill=continent)) +
  scale_fill_brewer(palette='Blues')

