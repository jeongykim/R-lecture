# base R을 이용한 데이터 가공
#install.packages("gapminder")
library(gapminder)
library(dplyr)

glimpse(gapminder) #str과 비슷한 함수

# 각 나라의 기대 수명(lifeExp)
tail(gapminder[,c('country','lifeExp')])
tail(gapminder[,c('country','lifeExp','year')])

# 샘플과 속성의 추출(filtering and selection)
gapminder[1000:1009, c('country','lifeExp','year')]
gapminder[gapminder$country=='Croatia',] # 크로아티아에 해당하는 행만 추출
gapminder[gapminder$country=='Croatia',c('year','pop')] #filtering and selection

# 크로아티아의 1990년도 이후의 기대수명과 인구
gapminder[gapminder$country=='Croatia' & gapminder$year > '1990',c('year','lifeExp','pop')] 

# 행/열 단위의 연산
apply(gapminder[gapminder$country=='Croatia',c('lifeExp','pop')],
      2,mean)

# 연평균 증가율 공식 CAGR = (이후년도 연평균/이전년도 연평균)^1/(이후년도-이전년도)-1

gapminder[gapminder$country=='Croatia',c('year','pop')]

(4493312/3882229)^(1/55)-1 #크로아티아의 1952년~ 2007년 연평균 증가율 공식 / 0.27% 늘어났다고 볼 수 있음

# 함수를 정의하고 apply함수에 입력해도 됨 *peak2peak
peak2peak = function(x, year) {
  return(max(x)-min(x))
}
apply(gapminder[gapminder$country=='Croatia',c('lifeExp','pop')],
      2,peak2peak)

