##############################################################################
## Problem Set 1: Intro to R
## Author: Amelia Bertozzi-Villa
## Description: Most instructions require you to write code. When I ask a 
##              direct, question please write a brief response in a comment.
##
##              Comment your code according to the guidelines discussed in 
##              class.
##############################################################################


## 1. Basic data types ---------------------------------------------------------

## Divide five by three.
5/3
## Have the console print out a greeting.
print("Hello World")
## Test the truth or falsity of three logical statements.
"Apple" < "Banana"
(6+8) > (121/11)
68 != "68"

## 2.Variables  ---------------------------------------------------------

## Create a variable with the value of your favorite number. Create another 
## variable equal to the first variable, squared. Have the console print out 
## whether or not the second variable is equal to ten. 
my_favorite_number <- 6
new_square_num <- my_favorite_number ^ 2
print(new_square_num == 10)

## 3. 1-Dimensional Arrays  ----------------------------------------------------

## Create a numeric vector five elements long. 
## Lengthen it by three elements. Keep only the six elements in the middle. 
old_vector <- seq(1,10,2)
new_vector <- c(old_vector, c(10, 1, 12))[2:7]
## 4. Logic and Loops  ---------------------------------------------------------

## For each element of the vector created in question 3, create a loop that tests
## if that element is greater than 7.2. If it is, have the console print out your
## favorite movie quote. If it isn't, print the title of your favorite book.
for (the_element in new_vector){
  if (the_element>7.2){
    print("Life was like a box of chocolates. You never know what you're gonna get.")
  }else{
    print("Pride and Prejudice")
  }
}
## Expand the code above such that, if a number is less than 7.2 but greater than 2, 
## the console prints out the title and artist of the last song you listened to.
## (Copy and paste your code so I can see both versions.)
for (the_element in new_vector){
  if (the_element>7.2){
    print("Life was like a box of chocolates. You never know what you're gonna get.")
  }else if (the_element>2){
    print("Mad World, Gary Jules")
  }else{
    print("Pride and Prejudice")
  }
}
