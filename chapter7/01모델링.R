# 현실 세계의 모델링
X = c(3.0,6.0,9.0,12.0)
Y = c(3.0,4.0,5.5,6.5)
plot(X,Y)

# model 1: y=0.5x+1.0
Y1 = 0.5*X + 1.0
Y1

# 평균 제곱 오차 : Mean Squared Error (실제값-예측값)**2/갯수
(Y-Y1)**2
sum((Y-Y1)**2)
mse <- sum((Y-Y1)**2)/length(Y)
mse #0.125

# model 2: y=5/12x+7/4     # 모델2가 0에 더 가깝기 때문에 훨씬 적합한 모델이라고 판단할 수 있다.
Y2 = 5/12*X + 7/4
Y2
mse2 <- sum((Y-Y2)**2)/length(Y)
mse2  #0.03125  

# R의 단순 선형회귀 모델 lm (최적의 값을 찾아줌)
model <- lm(Y~X)
model

plot(X,Y)
abline(model,col='red')
fitted(model) # 최적의 값을 찾아줌
mse_model <- sum((Y-fitted(model))**2)/length(Y)
mse_model

# 잔차 - Residuals #실제값과 예측값의 차이 
residuals(model) 

# 잔차 제곱합
deviance(model) 
sum(residuals(model)**2) #같은 의미다

# 평균 제곱오차 (MSE)
deviance(model)/length(Y)

summary(model)

newx = data.frame(X= c(1.2,2.0,20.65))
predict(model, newdata=newx)


# 연습문제 1
x=c(10.0,12.0,9.5,22.2,8.0)
y=c(360.2,420.0,359.5,679.0,315.3)
model2 = lm(y~x)
newx = data.frame(x= c(10.5,25.0,15.0))
newy = predict(model2, newdata=newx)

plot(newx$x,newy,pch=2)
abline(model2, col='red')


