##############################################################################
## Worksheet 5: OLS 
##############################################################################
rm(list=ls())

## 0. libraries and data -----------------------------

## Load the data.table, ggplot2, and car libraries, load the dataset called "Wong", convert it to a data.table.
library(data.table)
library(ggplot2)
library(car)

data(Wong)
comas <- data.table(Wong)

## 1. Preliminary plots -----------------------------
# Make scatter plots of the following: age vs piq, age vs duration, 
# viq vs piq. 
# When I say "a vs b", I mean that "a" should be on the x axis. These plots do not need
# to be fully labeled. 
ggplot(data=comas, mapping = aes(x=age, y=piq)) +
  geom_point()
ggplot(data=comas, mapping = aes(x=age, y=duration)) +
  geom_point()
ggplot(data=comas, mapping = aes(x=viq, y=piq)) +
  geom_point()
## Which of the above relationships is the best candidate for bivariate
## regression? Why? 
# The third one.
## 2. Regression -----------------------------

## For the relationship you picked in part 1, run a bivariate regression. 
## The *outcome* variable should be the variable on the *y* axis of your plots 

## Run the 'summary' command on the regression output. Identify the coefficients 
## and their meanings. 

## ## Make a new column in your dataset with predicted [outcome variable] values.

## Take the scatter plot you made in part 1, and add a line plot showing the regression predictions.
## Fully label this plot. 




