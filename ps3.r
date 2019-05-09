##############################################################################
## Problem Set 3: ggplot2
## Author: Amelia Bertozzi-Villa
## Description: Most instructions require you to write code. When I ask a 
##              direct, question please write a brief response in a comment.
##
##              Comment your code according to the guidelines discussed in 
##              class.
##############################################################################

## Section 1: Loading Libraries ---------------------------------------------------------

## Load the "data.table", "ggplot2", and "Ecdat" libraries. Don't have "Ecdat" installed yet? You should know what to do.
library(data.table)
library(ggplot2)
library(Ecdat)

## ---------------------------------------------------------------------------------
## Section 2: Loading Data  ---------------------------------------------------------

## Load the "Fair" dataset, and convert it to a data.table. 
## Read through the documentation for this dataset, and answer the questions below.
data(Fair)
Fair <- data.table(Fair)
## What does one row of this dataset represent?

# Each row represents a person.

## What do the values in the "religious" column indicate?

# The value in "religiou" indicates how religious this person is, from 1 (anti) to 5 (very). 

## The documentation isn't very helpful about the "education" column-- what do you think its values represent?

# It represents different level of education: high school, college, master, PhD, etc.

## ---------------------------------------------------------------------------------
## Section 3: Plotting  ---------------------------------------------------------

## Subsection 1: Years Married vs. # of affairs ----------------------------------------------
## Make a scatter plot of years married on the x-axis and number of affairs on the y-axis, using geom_point.
ggplot(data = Fair, mapping = aes(x=ym, y=nbaffairs)) +
  geom_point() +
  labs(title = "years married vs number of affairs", x="Years married", y="Nmuber of affairs")


## Hmm, that doesn't look very nice! That's because a lot of datapoints have the same values, so they're just stacked
## on top of each other. Try replacing "geom_point" with "geom_jitter" to wiggle the values around a little bit:
ggplot(data = Fair, mapping = aes(x=ym, y=nbaffairs)) +
  geom_jitter() +
  labs(x="Years married", y="Nmuber of affairs")
## That's better! Now, color that jittered scatterplot by sex.
ggplot(data = Fair, mapping = aes(x=ym, y=nbaffairs)) +
  geom_jitter(aes(color=sex)) +
  labs(x="Years married", y="Nmuber of affairs")
## Additionally, facet it by whether or not the couple has children. 
ggplot(data = Fair, mapping = aes(x=ym, y=nbaffairs)) +
  geom_jitter(aes(color=sex)) +
  labs(x="Years married", y="Nmuber of affairs") +
  facet_grid(~child, labeller = label_both)
## Give that plot some labels (x axis, y axis, and title) that accurately describe what the plot is showing. 
ggplot(data = Fair, mapping = aes(x=ym, y=nbaffairs)) +
  geom_jitter(aes(color=sex)) +
  labs(title="The relationship between years married and number of affairs by sex and whether they have children",
       x="Years married", y="Nmuber of affairs") +
  facet_grid(~child, labeller = label_both)


## Subsection 2: Number of affairs, by marriage satisfaction ---------------------------------------

## Even though the "rate" column refers to a category, right now R thinks it's numeric. 
## Convert it to a *categorical* (or *factor*) variable with the following code:
Fair[, rate:=as.factor(rate)]

## Now that we've done that, make a bar plot where the x-axis is the rate people give their marriage, and 
## the y-axis is how many times that rating appears in the dataset (hint: this is the default setup for bar plots!)
## Color this by rating. 
ggplot(data = Fair, mapping = aes(x=rate)) +
  geom_bar(aes(fill=rate)) 

## Modify this bar plot so that the y-axis is the mean number of affairs, by rate. You'll have to perform an aggregation. 
## Remember to label it (x, y, title)!
ggplot(data = Fair[, list(mean_affairs=mean(nbaffairs)), by=list(rate)], mapping = aes(x=rate, y=mean_affairs)) +
  geom_bar(aes(fill=rate), stat = "identity") +
  labs(title = "The mean number of affairs by rate", x="Self rating of marriage",
       y= "The mean number of affairs")


## Subsection 3: Freestyle ---------------------------------------

## Make three additional plots using this dataset. At least one of them must include color,
## and at least one must include faceting. Make sure that each is fully labeled. 

# The first plot:
ggplot(data = Fair, mapping = aes(x=rate, y=ym)) +
  geom_line(aes(color=rate)) +
  stat_summary(geom = "point", fun.y = mean, size =3) +
  labs(title = "The mean number of years married by rate", x="Self rating of marriage",
       y= "Years married")

# The second plot:
Fair[, occupation:=as.factor(occupation)]
ggplot(data = Fair, mapping = aes(x=education, y=nbaffairs, fill=occupation, alpha=0.5)) +
  geom_raster(stat = "identity", position = "identity", hjust = 0.5,
              vjust = 0.5) +
  facet_grid(~sex) +
  labs(title = "The number of affairs with education and occupation by sex", x="Education",
       y= "Number of affairs")

# The third plot:
ggplot(data = Fair, mapping = aes(x=ym, y=nbaffairs, color=sex)) +
  geom_path(stat = "identity", position= "identity") +
  geom_point() +
  labs(title = "The years married with the number of affairs by sex and education", x="Years married",
       y= "Number of affarirs") +
  facet_wrap(~education, nrow = 4, labeller = label_both)