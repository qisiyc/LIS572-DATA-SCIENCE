#############################################
# in class exercicse for logistic regression
############################################
rm(list = ls())

# loading libraries
library(data.table)
library(ggplot2)

# load data
data("mtcars")
mtcars <- data.table(mtcars)

# rename the variable
setnames(mtcars, "vs", "is.straight.engine")

# make new variable for automatic vs manual
mtcars[, shift.type:= ifelse(am==1,"manual","auto")]

# keep only necessaary columns
mtcars[, list(is.straight.engine, mpg, shift.type)]

# run logistic regression

ggplot(mtcars,aes(x=mpg, y=is.straight.engine)) +
  geom_point()

lr_mpg <- glm(formula = is.straight.engine ~ mpg, data=mtcars, family = binomial)
summary(lr_mpg)

# Theese two are slightly different in results. 
# prob_of_SE = probability pf straight engine
#mtcars[, predicted_prob_of_SE:=1/(1+exp(-(-8.8331 +0.4304*mpg)))]
mtcars[,auto_predicted_prob_of_SE:=predict(lr_mpg, type="response")]

ggplot(mtcars,aes(x=mpg))+
  geom_point(aes(y=is.straight.engine))+
  geom_line(aes(y=auto_predicted_prob_of_SE), color="blue")

# logistic regression with mpg and shif type
ggplot(mtcars,aes(x=mpg, y=is.straight.engine)) +
  geom_point(aes(color=shift.type), size=2.5, alpha=0.5)

lr_mpg_shif <- glm(formula = is.straight.engine ~mpg + shift.type, data = mtcars,family = binomial)
summary(lr_mpg_shif)

mtcars[, predicted_mpg_shift:=predict(lr_mpg_shif, type="response")]
ggplot(mtcars,aes(x=mpg, color=shift.type))+
  geom_point(aes(y=is.straight.engine))+
  geom_line(aes(y=predicted_mpg_shift))
