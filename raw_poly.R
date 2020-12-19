# load data
library(readxl)
library(ggplot2)
meat_data = read_excel("tecator.xlsx")
ggplot(meat_data,aes(x=Protein,y=Moisture)) +
  geom_point() + theme_classic() + ggtitle("Moisture vs Protein")

# divide data 
n = dim(meat_data)[1]
set.seed(12345)
id = sample(1:n, floor(n*0.5))
train = meat_data[id,]
valid = meat_data[-id,]

fitted_values = list()
train_MSE = vector()
valid_MSE = vector()
for(i in 1:6){
  poly_model = lm(Moisture ~ poly(Protein,degree = i),data = train)
  fitted_values[[i]] = poly_model$fitted.values
  train_MSE[i] = mean((poly_model$residuals)^2)
  poly_predict = predict(poly_model, newdata = valid)
  valid_MSE[i] = mean((poly_predict - valid$Moisture)^2)
}

ggplot() + geom_point(aes(x = train$Protein, y = train$Moisture), color = "black") + 
  geom_line(aes(x = train$Protein, y = fitted_values[[1]], color = "Degree1 Fitted"), 
            size = 0.8) + 
  geom_line(aes(x = train$Protein, y = fitted_values[[2]], color = "Degree2 Fitted"), 
            size = 0.8) + 
  geom_line(aes(x = train$Protein, y = fitted_values[[3]], color = "Degree3 Fitted"), 
            size = 0.8) + 
  geom_line(aes(x = train$Protein, y = fitted_values[[4]], color = "Degree4 Fitted"), 
            size = 0.8) + 
  geom_line(aes(x = train$Protein, y = fitted_values[[5]], color = "Degree5 Fitted"), 
            size = 0.8) + 
  geom_line(aes(x = train$Protein, y = fitted_values[[6]], color = "Degree6 Fitted"), 
            size = 0.8) +
  ggtitle("Regression Line based on degree") + xlab("Protein") + ylab("Moisture")



# train and validation MSE
cat("The train errors are\n", train_MSE)
cat("\n\nThe test errors are\n", valid_MSE)
ggplot() + geom_line(aes(x = 1:6, y = train_MSE, color="Training MSE")) + 
  geom_point(aes(x = 1:6, y = train_MSE, color="Training MSE"), size = 1) + 
  geom_line(aes(x = 1:6, y = valid_MSE, color="Test MSE"), size = 1) + 
  geom_point(aes(x = 1:6, y = valid_MSE, color="Test MSE")) + 
  theme_classic() + ggtitle("Mean Square Error Comparison") + xlab("Degrees")


# step AIC
library(MASS)
meat_data1 = meat_data[,2:102]
model_aic = lm(Fat ~ ., data = meat_data1)
select_step = stepAIC(model_aic, direction = "both", trace = FALSE)

cat("The number of variables selected using StepAIC are",length(select_step$coefficients))


# Ridge Regression
library(glmnet)
covariates = meat_data1[,-101]
response = meat_data1$Fat
ridge_model = glmnet(as.matrix(covariates), response, alpha=0, family="gaussian")
plot(ridge_model, xvar = "lambda", label = TRUE)


# LASSO Regression
lasso_model = glmnet(as.matrix(covariates), response, alpha = 1, family = "gaussian")
plot(lasso_model, xvar = "lambda", label = TRUE)
cv_lasso = cv.glmnet(as.matrix(covariates), response, alpha = 1, family="gaussian")
cat("The optimal lambda for LASSO is", (cv_lasso$lambda.min))


# LASSO CV
cv_lasso = cv.glmnet(as.matrix(covariates), response, alpha = 1, family="gaussian")
cat("The optimal lambda for LASSO is", (cv_lasso$lambda.min))
lasso_coeff = coef.glmnet(cv_lasso, s = cv_lasso$lambda.min)
select_coeff = lasso_coeff[which(lasso_coeff[,1] != 0)]
cat("\n\nNumber of coefficients selected in LASSO are", length(select_coeff)-1)# -1 is to remove intercept



