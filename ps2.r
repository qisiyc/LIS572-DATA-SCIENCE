##############################################################################
## Problem Set 2: Data Manipulation
## Author: Amelia Bertozzi-Villa
## Description: Most instructions require you to write code. When I ask a 
##              direct question please write a brief response in a comment.
##
##              Comment your code according to the guidelines discussed in 
##              class.
##
##              You can get up to one additional point for the extra credit 
##              sections.
##############################################################################
# this command *clears your environment* so you start with a fresh slate every time you run the script:
rm(list=ls()) 


## Section 1: Loading Libraries ---------------------------------------------------------

## Load the "data.table" and "vcd" libraries. 
## You'll have to install the "vcd" package first if you haven't already, but *do not* include this in your script!
library(data.table)
library(vcd)
## ---------------------------------------------------------------------------------
## Section 2: Loading Data  ---------------------------------------------------------

## Load the "Suicide" dataset. Read through the documentation for this dataset with "?Suicide"
data("Suicide")
?Suicide
## Convert the "Suicide" dataset into a data.table. Remember to *assign* it to an object named "Suicide"!
Suicide <- data.table(Suicide)
## What does one line of this dataset represent? Look back at the "What is Data Science" lecture if you need a hint.
## NOTE: please type your response IN A COMMENT so it doesn't get executed as code. To comment out a block of text, 
## Select it and hit Cmd-Shift-C. 

# Each line represents a method of suicide.

## ------------------------------------------------------------------------------------
## Section 3: data.table : i  ----------------------------------------------------
## Note: NONE OF THESE COMMANDS should change the original dataset "Suicide". You're just
## printing subsets of the dataset to the screen.

## Isolate the 7th row of the dataset.
Suicide[7]
## Isolate rows 3-15 of the dataset. 
Suicide[3:15]
## Isolate all the rows where method is equal to "poison". 
Suicide[method == "poison"]
## Isolate all the rows where sex is equal to "male" and method is equal to "drown". 
Suicide[sex == "male" & method == "drown"]
## ------------------------------------------------------------------------------------
## Section 4: data.table : j  ----------------------------------------------------

## Isolate the column "sex".
Suicide[, list(sex)]
## Isolate the columns "Freq" and "age".
Suicide[, list(Freq, age)]
## Isolate rows 200-215 AND columns "sex" and "method". 
Suicide[200:215, list(sex, method)]
## Delete the "method2" and "age.group" columns from your dataset. 
## NOTE: This WILL change the dataset.
Suicide[, method2:=NULL]
Suicide[, age.group:=NULL]

## ------------------------------------------------------------------------------------
## Section 5: data.table : by  ----------------------------------------------------

## Aggregate the dataset down to the total number (e.g. the "sum") of suicides, BY method. Do *not* assign this output to an object name. 
Suicide[, list(sum(Freq)), by=list(method)]
## Create a *new column* called "mean.freq", equal to the mean frequency of suicide, BY method and sex.
## By "create" here, I mean that you should *update* the dataset such that when you print out "Suicide", you see the new column name.
Suicide[,mean.freq:=mean(Freq), by=list(method,sex)]
## Delete the column "mean.freq".
Suicide[, mean.freq:=NULL]

## ------------------------------------------------------------------------------------
## Section 6: Contemplation -----------------------------------------------------
## You've just been working with a dataset of suicides. We've been treating them like they're just 
## any old numbers. Is this an appropriate method of working with this dataset? How do you, as a newfangled 
## data scientist, feel about needing to work with depressing or sensitive information? 
## Again, please write your response as a comment. 

# I think when analyzing the dataset of depressing or sensitive information, one should first treat it as 
# objectively as other dataset. Because every datasat is trying to reveal some kind of pattern or truth that
# can help solve problems. What this kind of depressing or sensitive information will convey would be
# more important to society. Involving personal emotion may result in incomplete analysis of this dataset or
# generate avoidable bias. I don't think it's good for the dataset. It doesn't mean to treat them as just numbers
# but to give them respect. After understanding what the dataset conveys, we can try to find a kind of impressive
# way to reveal the truth beneath the dataset directly to the public or target group.

## ------------------------------------------------------------------------------------
## EXTRA CREDIT 1: Merging  ---------------------------------------------------------

## Run the code below to generate a new dataset with the frequency of suicides in neighboring East Germany:
Suicide.east <- Suicide[, list(sex, age, method, Freq.east=as.double(sample(1:1500, nrow(Suicide), replace=T)))]

## Run the code below to rename the "Freq" column of "Suicide" to make it clear that you're talking about western Germany
setnames(Suicide, "Freq", "Freq.west")

## Merge "Suicide" and "Suicide.east" to a new object called "all.suicide". 
## The result should have the same number of rows as either "Suicide" or Suicide.east". 
all.suicide <- merge(Suicide,Suicide.east, by=c("sex","age","method"))
## If you rerun the command above, but with the argument "all" set to true, do you get a different result? Why or why not?

# No. The result is the same. Because they have the same number of rows. Each row can be found in both datasets.
# Running the original command is equal to merging all the rows with "all=T".

## ------------------------------------------------------------------------------------
## EXTRA CREDIT 2: Reshaping -----------------------------------------------------

## Melt the "suicide.all" dataset so that the "Freq.west" and "Freq.east" columns are collapsed into a single column. 
## Save the result of this operation to a new dataset called "melted.suicide". 
melted.suicide <- melt(data = all.suicide,id.vars = c("method", "sex", "age"), variable.name = "area", value.name = "Freq")
## Cast the "melted.suicide" dataset so that there is a column for each sex, which contains the death count for that sex. 
dcast(melted.suicide, method + age + area ~sex, value.var = "Freq")





