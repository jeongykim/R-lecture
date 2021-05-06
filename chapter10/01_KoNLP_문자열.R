##KoNLP설치-------------------
#install.packages('rJava')
#install.packages('memoise')
#install.packages('hash')
#install.packages('tau')
#install.packages('Sejong')
#install.packages('devtools')
#install.packages('RSQLite')
library(rJava)
library(memoise)
library(hash)
library(tau)
library(Sejong)
library(devtools)
library(RSQLite)
install.packages("https://cran.r-project.org/src/contrib/Archive/KoNLP/KoNLP_0.80.2.tar.gz", repos = NULL, type="source", INSTALL_opts = c('--no-lock'))
.libPaths() 
library(KoNLP)
useSejongDic()




# 문자열 처리-----------------------------
# [R] R에서 String(문자열) 처리하기 - 베어베어스 참조
library(stringr)

#1. Character로 형 변환
example <- 1
typeof(example) # double 숫자
example <- as.character(example)
typeof(example) # character

# 입력을 받는 경우
input <- readline('Prompt>')
input
i <- as.numeric(input)
3 * i

# 2. String 이어 붙이기
paste('A','quick','brown','fox') # 기본적으로 공백이 달라 붙음 A quick brown fox
paste0('A','quick','brown','fox') # 기본적으로 공백 없이 달라 붙음 Aquickbrownfox
paste('A','quick','brown','fox',sep='-') # sep는 구분 기호, 디폴트는 공백 
s <- paste('A','quick','brown','fox',sep='-')
sample <- c('A','quick','brown','fox')
paste(sample)#"A"     "quick" "brown" "fox"
paste(sample, collapse = ' ') # A quick brown fox , collapse를 쓰면 원하는 구분기호로 만들어줌
str_c(sample, '1', sep = '_') # 원하는 단어와 구분자로 달라 붙게 만들어 줌
str_c(sample, '1', sep = '_', collapse = '@@') 

# 3. Character 개수 카운트
x <- 'Hello'
nchar(x)
h <- '안녕하세요'
nchar(h)
str_length(h)

# 4. 소문자 변환
tolower(x)

# 5. 대문자 변환
toupper(x)

# 6. 2개의 character vector를 중복되는 항목 없이 합하기
str_1 <- c("hello", "world", "r", "program")
str_2 <- c("hi", "world", "r", "coding")
union(str_1,str_2) # 합집합

# 7. 2개의 character vector에서 공통된 항목 추출
intersect(str_1,str_2) # 교집합

# 8. 2개의 character vector에서 공통되지 않는 항목 추출
setdiff(str_1,str_2) # 차집합

# 9. 2개의 character vector 동일 여부 확인 (순서에 관계없이) 
str_3 <- c("r", "world", "program", "hello")
setequal(str_1,str_2) #FALSE
setequal(str_1,str_3) #TRUE

# 10. 공백 없애기
vector_1 <- c("   Hello World!  ", "    Hi R!    ")
str_trim(vector_1) #"Hello World!" "Hi R!"
str_trim(vector_1, side = "left") # 글자의 왼쪽 공백 제거
str_trim(vector_1, side = "right") # 글자의 오른쪽 공백 제거
str_trim(vector_1, side = "both") # 글자의 양쪽 공백 제거

# 11. String 반복해서 나타내기
str_dup(x,3)
rep(x,3)

# 12. Substring(String의 일정 부분) 추출
string_1 <- "Hello World"
substr(string_1,7,9)
substring(string_1,7,9)
str_sub(string_1,7,9)
substr(string_1,7) #Stop시켜주는 옵션이 존재하지 않아 오류
substring(string_1,7) #7번째 문자열 부터 다 출력
str_sub(string_1,7) 
str_sub(string_1,7, -1) 
str_sub(string_1,7, -3)
string_1[7:9] # NA NA NA

# 13. String의 특정 위치에 있는 값 바꾸기
string_1 <- "Today is Monday"
substr(string_1,10,12) <- "Sun"
string_1
substr(string_1,10,12) <- "Thurs"
string_1 #Today is Thuday

# 14. 특정 패턴(문자열)을 기준으로 String 자르기
strsplit(string_1,split=' ')
str_split(string_1,pattern=' ')
str_split(string_1,pattern=' ', n=2) # 두개의 조각으로 나눠라
str_split(string_1,pattern=' ', simplify = T) # matrix형태로 변환
s <- str_split(string_1, pattern = ' ')
typeof(s)
s[[1]]
s[[1]][1]

# 리스트를 벡터로 변환 : unlist()
unlist(s)
paste(unlist(s),collapse = ' ') # 리스트 형태는 벡터로 쪼개서 paste를 사용하는 것이 좋음

# 15. 특정 패턴(문자열) 찾기 (기본 function)
vector_1 <- c("Xman", "Superman", "Joker")
grep('man',vector_1) #man이라는 문자를 찾아서 카운트 해줌
grepl("man", vector_1)
regexpr("man", vector_1) # 원하는 문자열이 없으면 -1로 반환함
gregexpr("man", vector_1)

# 16. 특정 패턴(문자열) 찾기 (stringr package function) 
fruit <- c("apple", "banana", "cherry")
str_count(fruit, "a") # 하나의 글자에 a가 몇개 포함되는지
str_detect(fruit, "a") # 글자에 a가 포함되어 있는지
str_locate(fruit, "a") 
str_locate_all(fruit, "a")

people <- c("rorori", "emilia", "youna")
str_match(people, "o(\\D)") #\\D는 non-digit character(숫자가 아닌 문자)를 의미
str_match_all(people, "o(\\D)")

# 17. 특정 패턴(문자열) 찾아서 다른 패턴(문자열)으로 바꾸기
fruits <- c("one apple", "two pears", "three bananas")
sub('a','A',fruits) # 특정 요소에 한번만 원하는 문자열로 바꿈
gsub('a','A',fruits) #모든 요소에 전체를 원하는 문자열로 바꿈 
sub("[aeiou]", "-", fruits)
gsub("[aeiou]", "-", fruits)
str_replace(fruits, "[aeiou]", "-") #sub함수와 같음
str_replace_all(fruits, "[aeiou]", "-") #gsub함수와 같음
