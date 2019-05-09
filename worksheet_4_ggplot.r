
##############################################################################
## Worksheet 4: ggplot
##############################################################################


## 1. libraries and data -----------------------------
rm(list=ls()) 

## Load the data.table and car libraries. 
library(data.table)
library(car)
library(ggplot2)
## load the dataset called "Wong" from the car library, and convert it to a data.table called "comas".
data(Wong)
comas <- data.table(Wong)
## 2. Plots -----------------------------

## Make a scatter plot of age vs coma duration, colored by sex.
plot_1 <- ggplot(data = comas, mapping = aes(x=age,y=duration)) +
  geom_point(aes(color=sex))
print(plot_1)
## Make a scatter plot of coma duration vs piq, colored by age.
plot_2 <- ggplot(data = comas, mapping = aes(x=duration,y=piq)) +
  geom_point(aes(color=age))
print(plot_2)
## Make a scatter plot of coma duration vs viq, faceted by sex and colored by piq.
## Label it appropriately. 
plot_3 <- ggplot(data = comas, mapping = aes(x=duration,y=viq)) +
  geom_point(aes(color=piq)) +
  facet_grid(~sex) +
  labs(title = "coma duration vs viq by sex and pig")
print(plot_3)
# ---

## Make a histogram (bar chart with counts) of the datset, by sex.
plot_chart <- ggplot(data = comas) +
  geom_bar(mapping = aes(x=sex))
print(plot_chart)
## Change this histogram so the y-axis is mean piq. 
plot_chart_piq <- ggplot(data = comas) +
  geom_bar(mapping = aes(x=sex, y=piq), stat = "identity")
print(plot_chart_piq)

plot_chart_piq_1 <- ggplot(data = comas) +
  stat_summary(mapping = aes(x=sex, y=viq), 
               fun.ymin = min,
               fun.ymax = max,
               fun.y = median)
print(plot_chart_piq_1)

plot_chart_piq_2 <- ggplot(data = comas) +
  geom_bar(mapping = aes(x=viq, y=days, fill=sex), stat = "identity") +
  facet_wrap(~freq)
print(plot_chart_piq_2)

## Make a new dataset containing only individuals with more than three observations. 
##  Make a line plot of this dataset showing "days" vs piq, colored by id. Superimpose
##  The data points (aka a scatter plot) over this line plot. 

comas[, count:=.N, by=list(id)]

more_than_three <- comas[count>3]
#more_than_three <- comas[, id:=as.factor(id)]
ggplot(data = more_than_three, mapping = aes(x=days, y=piq, color=id)) +
  geom_line() +
  geom_point()



library(plyr)
new_data <- merge(comas,data.table(count(comas,vars = "id")), all = T)
more_than_3 <- new_data[freq>2]
more_than_3_plot <- ggplot(data = more_than_3, mapping = aes(x=days, y=piq)) +
  geom_point(mapping=aes(color=id)) +
  geom_smooth() +
  labs(title="viq & days by id") 
print(more_than_3_plot)

plot_chart_piq_2 <- ggplot(data = more_than_3) +
  geom_bar(mapping = aes(x=viq, y=days, color=sex), stat = "identity") +
  facet_wrap(~freq) +
  scale_color_manual(values = c("red", "purple"))
print(plot_chart_piq_2)

more_than_3_plot_3 <- ggplot(data = more_than_3, mapping = aes(x=duration, y=piq)) +
  geom_point(mapping=aes(color=id)) +
  geom_smooth() +
  labs(title="viq & days by id")
print(more_than_3_plot)



