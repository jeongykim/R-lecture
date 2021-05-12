# json 기본(내장 데이터 처리)
library(jsonlite)

pi
json_pi <- toJSON(pi, digits =3)  #pi를 json 형식으로 만들겠다.
fromJSON(json_pi)

city <- '대전'
json_city <- toJSON(city)
fromJSON(json_city)

subject <- c('국어','영어','수학')
json_subject <- toJSON(subject)
fromJSON(json_subject)

# 데이터 프레임
name <- c("Test")
age <- c(25)
sex <- c("F")
address <- c("Seoul")
hobby <- c("Basketball")
person <- data.frame(Name = name,Age = age,Sex = sex,Address=address,Hobby=hobby)
str(person)

json_person <- toJSON(person)
json_person
prettify(json_person)

#=========================================
df_json_person <- fromJSON(json_person)
str(df_json_person)

# 두개의 데이터프레임의 데이터 값이 같은지 비교
all(person == df_json_person)

# cars 내장 데이터로 테스트
cars
json_cars <- toJSON(cars)
prettify(json_cars) #json형식 되있는거 예쁘장하게 보는 법
df_json_cars <- fromJSON(json_cars)
all(cars==df_json_cars)

# person.json 파일로 부터 읽기
wiki_person <- fromJSON("OpenAPI/person.json")
str(wiki_person)
class(wiki_person)

# sample.json 파일로 부터 읽기
data <- fromJSON('OpenAPI/sample.json')
str(data)

data <- as.data.frame(data)
names(data) <- c('id','like','share','comment','unique','msg')
data$like <- as.numeric(data$like)
View(data)

# CSV 파이로 저장
write.csv(data, "OpenAPI/data.csv")

# Data Frame을 JSON 파일로 저장
json_data <- toJSON(data)
write(json_data, 'data.json')
prettify(json_data)


#JSON주소로 불러오기
# Converting JSON
library(jsonlite)
library(httr)

df_repos <- fromJSON("https://api.github.com/users/hadley/repos")
str(df_repos)
names(df_repos)

names(df_repos$owner)
