########################
## April 29th: OLS in R
########################

rm(list = ls())

library(data.table)
library(ggplot2)
library(car)

data("Salaries")
Salaries <- data.table(Salaries)

## run a regression with years.since.phd as the predictor
## and the salary as the outcome

ggplot(data = Salaries, mapping = aes(x=yrs.since.phd, y=salary)) +
  geom_point()

# regression equation: lm() (stands for linear model)
# needs: 1. a formula for the regression
#        2. your dataset of interest

# salary ~ yrs.since.phd IS THE R FORMULA FOR salary = b0 + b1*yrs.since.phd + e
# R assumens you want a b0

regression_output <- lm(formula=salary~yrs.since.phd, data=Salaries)
# y~x, y before x
summary(regression_output)

# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)    91718.7     2765.8  33.162   <2e-16 ***
#   yrs.since.phd    985.3      107.4   9.177   <2e-16 ***
# intercept = when your x equal 0, the value of y =b0
# we are more interested in the effect y has on x instead of x on y
# b1 indicates the one unit increased in salary every one year

## regression of yrs.since.phd on the x axis and yrs.service on y axis
 ggplot(data=Salaries, mapping = aes(x=yrs.since.phd, y=yrs.service)) +
   geom_point()
# very strong correlation

regression_two <- lm(formula = yrs.service~yrs.since.phd, data=Salaries)
summary(regression_two)

# Why you get ridiculous intercept
# your regression is running interrupt
# the intercept is actually outside the bound

## to Plot regression output
## 1. predict the y value
## 2. plot it

## predict your value by hand
## not recommend
# Salaries[, predict_salary:= 91718.7 + 985.3*yrs.since.phd]

## recommended way
Salaries[, predict_salary:=predict(regression_output)]

ggplot(data = Salaries, mapping = aes(yrs.since.phd)) +
  geom_point(aes(y=salary)) +
  geom_line(aes(y=predict_salary), size = 1, color="red")

## expand to multivaniate with continuous
mulit_count_reg <- lm(salary~yrs.since.phd +yrs.service, data=Salaries)
summary(mulit_count_reg)

Salaries[, prediced_cont:=predict(mulit_count_reg)]

ggplot(Salaries, aes(x=yrs.since.phd)) +
  geom_point(aes(y=salary)) +
  geom_line(aes(y=prediced_cont), color="blue")

## expand to multivaniate with 2-value categorical

multi_cat_reg <- lm(salary~yrs.since.phd + sex, data=Salaries)
summary(multi_cat_reg)

Salaries[, predicted_cat_sex:=predict(multi_cat_reg)]

ggplot(Salaries, aes(x=yrs.since.phd)) +
  geom_point(aes(y=salary)) +
  geom_line(aes(y=predicted_cat_sex, color=sex))


multi_cat_reg_three_lin <- lm(salary~yrs.since.phd + rank + sex, data=Salaries)
summary(multi_cat_reg_three_lin)

Salaries[, predicted_cat_rank:=predict(multi_cat_reg_three_lin)]

ggplot(Salaries, aes(x=yrs.since.phd)) +
  geom_point(aes(y=salary, color=rank)) +
  geom_line(aes(y=predicted_cat_rank, color=rank, linetype=sex), size = 1.5)# +
  #facet_grid(.~sex)



## discipline and salary
ggplot(Salaries, aes(x=discipline, y=salary)) +
  geom_boxplot()