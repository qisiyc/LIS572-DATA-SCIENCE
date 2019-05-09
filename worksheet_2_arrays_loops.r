##############################################################################
## Worksheet 2
##############################################################################

## 1. Arrays -----------------------------

## Make a vector called "good_music" three elements long. Each element should be the name of a band/musician you like.
good_music <- c("Schubert", "Mozart", "Beethoven")
## *update* good_music by appending two more musicians you like. 
good_music <- c(good_music, "Bach", "Chopin")
## Use [] and : to display the 2nd through 4th elements of good_music.
print(good_music[2:4])
## Make a new vector called "music_amelia_likes" with the elements "Alt-j", "Sia", "el ten eleven", and "Sylvan Esso".
music_amelia_likes <- c("Alt-j", "Sia", "el ten eleven", "Sylvan Esso")
## Use "which" to display the index of "Sia" in music_amelia_likes.
which("Sia" == music_amelia_likes)
## Make a new vector called "combined_music" that combines good_music and music_amelia_likes.
combined_music <- c(good_music, music_amelia_likes)
## Use "which" and "-" to remove the element "el ten eleven" from combined_music. 
## Be sure to *update* combined_music, don't just display the altered vector. 
combined_music <- combined_music[-which(combined_music == "el ten eleven")]

## 2. Loops -----------------------------

## Use a "for" loop to sequentially print out each element of combined_music.
for (the_element in combined_music){
  print(paste("Artist name:",the_element))
}
## Make a vector called "music_rating" the same length as combined_music. 
## Each element of music_rating should be a score, from 1 to 5, of how much you like that musician. 
## Just make a number up if you don't recognize the artist. 
music_rating <- c(2,4,5,4,3,2,1,3)
## Use a "for" loop to sequentially print out each element of combined_music, and its rating (according to the vector music_rating).
for (the_element in combined_music) {
  print(paste(the_element, ", the rating is", music_rating[which(the_element == combined_music)]))
}

## 3. Logic -----------------------------

## Modify the last "for" loop you made such that, if the musician has a rating below 3, 
## the console prints out "I don't like this musician".
for (the_element in combined_music) {
  if (music_rating[which(the_element == combined_music)] < 3){
    print(paste("Artist name:", the_element, ", the rating is", music_rating[which(the_element == combined_music)], "and I don't like this musican."))
  }else{
    print(paste(the_element, ", the rating is", music_rating[which(the_element == combined_music)]))
  }
}
## Modify *that* loop such that, if the musician has a rating of 5, the console prints out
# "I love this musician". 
for (the_element in combined_music) {
  if (music_rating[which(the_element == combined_music)] < 3){
    print(paste(the_element, ", the rating is", music_rating[which(the_element == combined_music)], "and I don't like this musican."))
  }else if (music_rating[which(the_element == combined_music)] == 5){
    print(paste(the_element, ", the rating is", music_rating[which(the_element == combined_music)], "and I like this musican."))
  }else{
    print(paste(the_element, ", the rating is", music_rating[which(the_element == combined_music)]))
  }
}
## Use a "while" loop to print out the first element of combined_music with a rating of 5
## MAKE SURE that at least one of your musicians has a rating of 5 before you do this!!
the_index <- 1
while (the_index < length(music_rating)){
  if ((music_rating[the_index]) == 5){
    print(paste("The first musician with a rating 5 is", combined_music[the_index]))
  }
  the_index <- the_index + 1
}

