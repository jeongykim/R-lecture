library(RCurl)
library(XML)
library(stringr)

html <- readLines('https://en.wikipedia.org/wiki/Data_science')
html <- htmlParse(html, asText=T)
doc <- xpathSApply(html,'//p',xmlValue)
length(doc)
doc[1]
doc[2]
doc[3]
corpus <- doc[2:3]

# 모두 소문자로 변경
corpus <- tolower(corpus)
corpus[1]

# 숫자 제거
# 숫자 표현하는 정규식 : '\\d' , '[[:digit:]]
corpus <- gsub('\\d','', corpus)
corpus

# 구둣점 제거 : , [[:punct:]]
corpus <- gsub('[[:punct:]]','', corpus)
corpus
# 또 다른 방법
#corpus <- gsub("[\\\\!\"#$%&'()*+,./:;<=>?@[\\^\\]_`{|}~-]", 
#               "", corpus, perl = T)

# 끝에 있는 공백 제거
corpus <- gsub('\n', ' ', corpus) 
corpus <- str_trim(corpus, side='right')

# 불용어 제거
stopwords <- c('a', 'the', 'and', 'in', 'of','to','but')
words <- str_split(corpus, ' ') # 결과가 list
unlist(words) #여러개의 list 엘리먼트를 하나의 벡터로 만듦

l <- list() # 빈 리스트 생성
for (word in unlist(words)) {
  if (!word %in% stopwords) { #불용어를 제외한 나머지를 가져온다.
    l <- append(l,word)
  }
}
corpus <- paste(l, collapse = ' ') #리스트 안에 내용 붙이기
corpus

# %notin%연산을 따로 만들어서 if구문에다가 넣어서 하기

'%notin%' <- Negate(`%in%`)

stopwords <- c('a', 'the', 'and', 'in', 'of','to','but')
words <- str_split(corpus, ' ') # 결과가 list
unlist(words) #여러개의 list 엘리먼트를 하나의 벡터로 만듦

l <- list() # 빈 리스트 생성
for (word in unlist(words)) {
  if (word %notin% stopwords) { #불용어를 제외한 나머지를 가져온다.
    l <- append(l,word)
  }
}
corpus <- paste(l, collapse = ' ') #리스트 안에 내용 붙이기
corpus


