# 반복문
# 1. repeat 구문
i <- 1
sum <- 0
repeat{
  if(i>10) {
    break
  }
  sum <- sum + i
  i <- i + 1
}
print(sum)

# while 구문
i <- 1
sum <- 0
while (i<=10) {
  sum <- sum + i
  i <- i+1
}
print(sum)

# for 구문
sum <- 0
for (i in 1:10) {
  sum <- sum + i
}
print(sum)

# 10! 구하기 방법 1
sum <- 1
for (i in 1:10) {
  sum <- sum * i
}
print(sum)

# 10! 구하기 방법 2
factorial(10)

# 10! 구하기 방법 3
i <- 1
sum <- 1
while (i<=10) {
  sum <- sum * i
  i <- i+1
}
print(sum)

# 10! 구하기 방법 4
i <- 1
repeat {
  factorial_value <- factorial(i)
  cat("factorial(", i, ") = ", factorial_value, "\n", sep="")
  if (factorial_value > 1000000000000) break
  i <- i+1
}

# 1~100 사이의 홀수 합 구하기(내가 구한 것)
sum <- 0
for(i in seq(1, 100, by=2)) {
  sum <- sum + i
}
print(sum)

# 1~100 사이의 홀수 합 구하기(강사님 답안1)
odd_sum <- 0
for (i in 1:100) {
  if(i %% 2 ==1) {
    odd_sum <- odd_sum + i
  }
}
print(odd_sum)

# 1~100 사이의 홀수 합 구하기(강사님 답안2)
odd_sum <- 0
for(i in seq(1, 100, by=2)) {
  odd_sum <- odd_sum + i
}
print(odd_sum)

# 구구단 2단 만들기
for(k in 1:9){
  print(paste('2','x',k,'=',2*k))
}

# 구구단 2~9단 만들기
for(i in 2:9) {
  for(j in 1:9) {
    print(paste(i,'x',j,'=', i*j))
  }
}

# 구구단 2~9단 구분선 추가해서 만들기
for(i in 2:9) {
  print(paste('단========================='))
  for(k in 1:9) {
    print(paste(i,'x',k,'=', i*k))
  }
}

#Matrix 문제 풀기
mat <- matrix(1:12, nrow=3)
nrow <- 3
ncol <- 4

sum1 <- 0
sum2 <- 0
sum3 <- 0
for(i in 1:nrow) {
  for(k in 1:ncol){
    sum1 <- sum1 +mat[i,k]
    sum2 <- sum2 +mat[i,k]**2
    sum3 <- sum3 +mat[i,k]**i
  }
}
print(paste(sum1,sum2,sum3))

# 삼각형
for(i in 1:5){
  star <- ''
  for(k in 1:i){
    star <- paste0(star,"+")
  }
  print(star)
}

# 피라미드
for(i in 1:5){
  for(k in 1:(5-i)){
    if(5-i>0) cat(" ")
  }
  for (k in 1:(i*2-1)){
    cat("+")
  }
  cat("\n")
}
# 역정삼각형
num <- 5
for(i in num:1){
  for(k in 1:(num-i)){
    cat(" ")
  }
  for (k in 1:(i*2-1)){
    cat("+")
  }
  cat("\n")
}

#list 만들기
lst = list()
lst <- append(lst,3)
lst <- append(lst,5)
lst <- append(lst,7)
length(lst)
#list append로 붙이기
lst = list()
for (i in 1:5){
  lst <- append(lst,i)
}
lst

vec = c()
for (i in 1:4){
  vec <- append(vec,i)
}
vec

#list element로 붙이기 vec, mat 형태도 가능(Enhanced - for -loop)
vec <- c(1,7,8)
for (element in vec) {
  print(element)
}
for (element in mat) {
  print(element)
}

# 약수
N <- 6
for (num in 1:N){
  if(N %% num == 0) {
    print(num)
  }
}

# 약수의 합
N <- 6
sum <-  0
for (num in 1:N){
  if(N %% num == 0) {
    sum <- sum+num
  }
}
print(sum)

#완전수(Perfect Number) : 자기자신을 제외한 약수의 합이 자기 자신과 같은 수 6은 완전수 이다.

#Perfect Number
# 2에서 10000 사이의 완전수를 찾으시오.
for (N in 2:10000) {
  sum <- 0
  for (num in 1:(N-1)){
    if(N %% num == 0) {
      sum <- sum+num
    }
  }
  if(sum==N){
    print(N)
  }
}

for (N in 2:100000) {
  sum <- 0
  for (num in 1:(N-1)){
    if(N %% num == 0) {
      sum <- sum+num
    }
  }
  if(sum==N){
    print(N)
  }
}

