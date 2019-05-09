# making a numeric vector numeric_vector
# c()
numeric_vector <- c(7, 18, 9)
print(numeric_vector)

# make a string vector
string_vector <- c("hello", "dog", "lime")

# make a mixed vector
mix_vector_1 <- c(string_vector, numeric_vector)
mix_vector_2 <- c(14, 20, T, F)

# islating elements: indexing
longer_vector <- c("hello", "dog", "lime", "blue", "black","yellow","red")
second_string <- string_vector[2]
first_two_string <- string_vector[1:2]
second_to_forth <- string_vector[2:4]

# this colon is an operator to create sequences
65:70
c(65:70)
seq(65,70)
rep(65:70)

# square brackets accpet any integer vector as input
longer_vector[c(1,3,5)]

# lengthen vector
second_string_vector <- c("goldfish", "honeydew")
another_longer_vector <- c(string_vector, second_string_vector)
vector_with_duplicate <- c(string_vector, "honeydew", "honeydew")

# finding the index of a vector
which(longer_vector=="yellow")
which(vector_with_duplicate=="honeydew")

# shortening vectors
shortened_vector_1 <- vector_with_duplicate[1:4]
shortened_vector_2 <- vector_with_duplicate[-5]
shortened_vector_3 <- vector_with_duplicate[-(2:4)]
no_honeydew_vector <- vector_with_duplicate[which(vector_with_duplicate != "honeydew")]

