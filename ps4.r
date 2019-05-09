##############################################################################
## Problem Set 4: OLS 
## Author: Amelia Bertozzi-Villa
## Description: Most instructions require you to write code. When I ask a 
##              direct, question please write a brief response in a comment.
##
##              Comment your code according to the guidelines discussed in 
##              class.
##############################################################################

## Section 1: Loading Libraries ---------------------------------------------------------

## Load the "data.table", "ggplot2", "car", and "reshape2" libraries. 
library(data.table)
library(ggplot2)
library(car)
library(reshape2)


## ---------------------------------------------------------------------------------
## Section 2: Regressing Years of Service on Salary  ---------------------------------------------------------

## Load the "Salaries" dataset, and convert it to a data.table. 
data("Salaries")
Salaries <- data.table(Salaries)
## Run a regression where the outcome variable is "salary" and the predictor variable is "yrs.service". 
regression_output <- lm(formula = salary~yrs.service, data = Salaries)

## Run the "summary" command on your regression, and answer the following questions:
summary(regression_output)
## 1. What are the coefficients for intercept and "yrs.service"?

# Coefficient for intercept: 99974.7
# Coefficient for "yrs.service": 779.6

## 2. Put those intercepts into a sentence describing the linear relationship, like we did for the two regressions in lecture.

# A professor with zero years of service is expected to make $99,974.7 dollars, 
# and every additional year of service adds $779.6 to that profesor’s expected salary.

## 3. What is the standard error and p-value of the "yrs.service" coefficient? Is that p-value statistically significant?

# Standard error of yrs.service: 110.4
# p-value of yrs.service: 7.53e-12
# The p-value is very very small and is below 0.05, so it's statistically significant.

## 4. What is the adjusted R-squared value for this regression? What does that mean?

# Adjusted R-squared:  0.1098
# It means only about 11% of the variance in salary can be explained by yrs.service.

## Make a new column in your dataset with predicted salary values.
Salaries[, predicted_salary:=predict(regression_output)]
## Make a scatter plot of yrs.service vs. salary, and add a line plot showing the regression predictions.
## NOTE: I want you to plot your predicted values (from the last question). Do *not* use geom_smooth().
## Fully label both axes, and add a title.
ggplot(data = Salaries, aes(x=yrs.service)) +
  geom_point(aes(y=salary)) +
  geom_line(aes(y=predicted_salary), color="red") +
  labs(title = "Data and Regression line for Years of Service and Salary among Professors", 
       x="Years of Service", y="Salary")

## ---------------------------------------------------------------------------------
## Section 3: Regressing with the "tips" Dataset  ---------------------------------------------------------

## Load the "tips" dataset from the "reshape2" library, and convert it to a data.table. 
data(tips)
tips <- data.table(tips)
## What does one row of this dataset represent?

# Each row represents the the tip, day, time and the total amount of a bill
# as well as the payer's sex and whether she/he is a smoker.

## Run a regression where the outcome variable is "tip" and the predictor variable is "total_bill". 
tip_regression <- lm(formula=tip~total_bill ,data = tips)
## Run the "summary" command on your regression, and answer the following questions:
summary(tip_regression)
## 1. What are the coefficients for intercept and "total_bill"?

# Coefficient for intercept: 0.920270
# Coefficient for total_bill: 0.105025

## 2. Put those intercepts into a sentence describing the linear relationship, like we did for the two regressions in lecture.

# A waiter is expected to receive $0.92 when the total bill is zero, 
# and every additional dollar of total bill adds $0.1 to the waiter's tips.

## 3. What is the standard error and p-value of the "total_bill" coefficient? Is that p-value statistically significant?

# Standard error of total_bill: 0.007365
# p-value of total_bill: < 2e-16
# The p-value is very very small and is below 0.05, so it's statistically significant.

## 4. What is the adjusted R-squared value for this regression? What does that mean?

# Adjusted R-squared: 0.4544
# It means only about 45% of the variance in tips can be explained by total bill.

## 5. What are the units of the coefficients in the "Estimate" column?

# The units are dollars.

## Make a new column in your dataset with predicted tip values.
tips[, predicted_tip:=predict(tip_regression)]
## Make a scatter plot of total_bill vs. tips, and add a line plot showing the regression predictions.
## See note above about how to plot predicted values. Again, make sure both axes are labeled and the plot 
## has a title. 
ggplot(data = tips, aes(x=total_bill)) +
  geom_point(aes(y=tip)) +
  geom_line(aes(y=predicted_tip), color="purple") +
  labs(title = "Data and Regression line for Total Bill and Tip in Dollars", x="Total Bill in Dollars", 
       y="Tip in Dollars")
## Think about the expected relationship between "total_bill" and "tip", according to cultural norms in the US.
## How does the coefficient on "total_bill" relate to those cultural norms?

# According to my own understanding of the cultural norms of “tip”, I think the amount of tip should be
# 12% to 20% of the total bill. When the total bill is between 10 to 65, the tip range is from
# 12% to 20% which matches the cultural norms. 
# So, I think this coefficient can better decribe the cultural norms in small restaurants.
