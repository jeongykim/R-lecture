# 다음 책 검색 kakao openAPI 
library(httr)
library(jsonlite)
kakao_api_key <- readLines('OpenAPI/kakao_api_key.txt',encoding = 'UTF-8')
kakao_api_key

base_url <- 'https://dapi.kakao.com/v3/search/book'
keyword <- URLencode(iconv('데이터 분석', to='UTF-8'))
keyword
query <- paste0('target=title&query=', keyword)
url <- paste(base_url, query, sep='?')
url
auth_key <- paste('KakaoAK', kakao_api_key)
auth_key
res <- GET(url, add_headers('Authorization'=auth_key))  #사이트에서 get 방식으로 요청했기에 get으로 함 post면 post
res
result <- fromJSON(as.character(res))
class(result) #결과는 리스트
result
df <- as.data.frame(result)
View(df)

#결과가 리스트이기 때문에 매트릭스로 변환하여 세이브 함
#write.csv(df, 'OpenAPI/book.csv', fileEncoding = 'utf-8') #리스트 형식이라 저장이 안됨
write.csv(as.matrix(df), 'OpenAPI/book.csv', row.names = F) #매트릭스로 바꿔주고 함, 코딩이 깨지면 fileEncoding='utf-8'을 넣어주면 됨 
# 내용중에 ','가 있어서 제대로 못 읽어서 sep를 \t로 변경
write.table(as.matrix(df),'OpenAPI/book.csv', row.names = F, sep='\t')
df2 <- read.csv('OpenAPI/book.csv',sep='\t')
View(df2)

