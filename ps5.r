##############################################################################
## Problem Set 5: Multivariate Regression 
## Author: Amelia Bertozzi-Villa
## Description: Most instructions require you to write code. When I ask a 
##              direct, question please write a brief response in a comment.
##
##              Comment your code according to the guidelines discussed in 
##              class.
##############################################################################

## Section 1: Loading Libraries ---------------------------------------------------------

## Load the "data.table", "ggplot2", and "reshape2" libraries. 
library(data.table)
library(ggplot2)
library(reshape2)

## Section 2: Exploring variables in the "tips" dataset ---------------------------------------------------------

## Load the "tips" dataset and convert it to a data.table.
data(tips)
tips <- data.table(tips)
## Let's say that we're interested in the relationship between total bill (predictor variable) and tip (outcome variable).
a <- lm(formula = tip ~ total_bill +sex, data = tips)
summary(a)

## For each of the other five variables in the dataset, indicate what class that variable falls into (confounder, effect modifier,
## mediator, or none of the above). Explain why you think that. Is this variable categorical or continuous?
## Should this variable be included in the regression?

# Confounder: size & time & sex. 
# Because the number of the people and time may affect the total bill and the tip. More people may
# have higher amount of total bill, and may pay more tip. But it's not on the causal path. 
# For time, I ran the regression formula and found that time have effect on total bill and tip. Probably, people will pay more tip
# and bill for dinner or lunch. And apparently, time is not on the causal path.
# For sex, I ran the regression and found the association is not significant. But I still think it might affect the 
# total bill and tip and is not on the causal path.
# 
# Size is continiuous. Time and sex is categorical. They should be included in the regression.

# None: Smoker and day. By running the regression formula of each of these factors and total
# bill and tip, it seems that they have no association with total bill and tip.
# And these are all categorical variables.

## Section 3: Designing a regression ---------------------------------------------------------

## In section 2, you decided what variables should and should not be included in your regression on the relationship 
## between total bill and tip.Write out what your regression equation should be, including all the variables
## you deemed necessary in Section 2.
## You can use "b" instead of "beta", for example: "tip = b0 + b1*total_bill + b2*sex". 
## You should have at least three predictor variables. 

# tip=b0 + b1*total_bill + b2*size + b3*sex + b4*time + E

## Section 4: Running that regression ---------------------------------------------------------

## Run the regression specified in Section 3. Print the output using summary().
tip_regression <- lm(formula = tip~total_bill + size + time + sex, data = tips)
summary(tip_regression)
## What category/categories is your Intercept value capturing? For example, in our "full regression" video from 
## lecture, our Intercept value captured both the category "sex=Female" and the category "discipline=A".

# The intercepty captured the category "sex=Male" and the category "time=Lunch".

## For each row of the regression output, tell me:
## --If the coefficient in question refers to a continuous or categorical variable (and if categorical, what category)
## --How to interpret that value in a sentence. 
##    For continuous variables, this should be in the format of "an [x] increase in [predictor variable] 
##    leads to a [y] increase/decrease in my outcome variable. 
##    For categorical variables, tell me how the Intercept changes for each categorical variable. 

# For every bill of lunch paid by male with 0 people and 0 amount, the expected tip is to be $0.65.
# For every bill of dinner paid by male with 0 zero people and 0 amount, the expected tip is to be $0.67.
# For every bill of lunch paid by female with 0 people and 0 amount, the expected tip is to be $0.68.
# For every bill of dinner paid by female with 0 zero people and 0 amount, the expected tip is to be $0.68.
# Every one person increase in size leads to a $0.19 increase in tip. 
# A dollar increase in total bill leads to a $0.1 increase in tip.

## NOTE: You **do not** have to work through every possible combiations of categories and give me their intercept values--
## depending on which variables you choose, that could wind up being a lot of combinations. Just tell me how each categorical
## coefficient changes the intercept. 


## Section 5: Visualization ---------------------------------------------------------

## Make a plot of your regression outputs. If you included continuous variables, make one plot where the x-axis is 
## "total_bill" and another where it is your continuous variable. The results won't be straight lines, but that's ok.
## If you only have one categorical variable, distinguish its values by color. If you have multiple categorical variables,
## Use some combination of color and faceting to come up with the appropriate number of regression lines. 

# Use facet to seperate sex and time
tips[, predicted_tips:=predict(tip_regression)]
ggplot(data=tips,mapping = aes(x=total_bill)) +
  geom_point(aes(y=tip, color=sex, size=size), alpha=0.5) +
  geom_line(aes(y=predicted_tips, linetype="predicted tip")) +
  facet_grid(sex~time) +
  labs(title = "The relationship between total bill, size and tip by time and sex.", x="Total bill amount",
       y="Tip amount")

# Use linetype to represent the predicted tip of different sex
ggplot(data=tips,mapping = aes(x=total_bill)) +
  geom_point(aes(y=tip, color=sex, size=size), alpha=0.5) +
  geom_line(aes(y=predicted_tips, linetype=sex)) +
  facet_grid(~time) +
  labs(title = "The relationship between total bill, size and tip by time and sex.", x="Total bill amount",
       y="Tip amount")


# Another visualization for size and tip
ggplot(data=tips,mapping = aes(x=size)) +
  geom_point(aes(y=tip, shape=sex, color=sex), size = 1.5) +
  geom_line(aes(y=predicted_tips, color=sex, linetype="predicted tip")) +
  facet_grid(~time) +
  labs(title = "The relationship between total bill, size and tip by time and sex.", x="Size",
       y="Tip amount")
