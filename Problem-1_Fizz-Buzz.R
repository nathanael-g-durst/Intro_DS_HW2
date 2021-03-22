############### [START] Nathanael's way ###############

#Create the list of numbers from 1 to 1000
listNumbers <- 1:1000

#List multiples of 3
listMultipleThree <- seq(from = 3, to = 1000, by = 3)
#List multiples of 5
listMultipleFive <- seq(from = 5, to = 1000, by = 5)
#List multiples of 3 that are also multiples of 5
listIntersect <- intersect(listMultipleThree, listMultipleFive)

#Remove multiples of 5 in the list of multiples of 3 
listMultipleThree <- setdiff(listMultipleThree, listMultipleFive)
#Remove multiples of 3 in the list of multiples of 5 
listMultipleFive <- setdiff(listMultipleFive, listMultipleThree)

#List of values that will replace the different multiples
text <- c("Fizz", "Buzz", "Fizz Buzz")

#Replace the multiples of 3 by Fizz
listNumbers <- replace(listNumbers, listMultipleThree, text[1])
#Replace the multiples of 5 by Buzz
listNumbers <- replace(listNumbers, listMultipleFive, text[2])
#Replace the multiples of 3 and 5 by Fizz Buzz
listNumbers <- replace(listNumbers, listIntersect, text[3])

#Clean the environment
rm(listIntersect, listMultipleFive, listMultipleThree, text)

#Print the results
print(listNumbers)

############### [END] Nathanael's way ###############

############### [START] Adel's way ###############

listNumbers <- 1:1000

#List multiples of 3
listMultipleThree <- seq(from = 3, to = 1000, by = 3)
#List multiples of 5
listMultipleFive <- seq(from = 5, to = 1000, by = 5)

#List of values that will replace the different multiples
text <- c("Fizz", "Buzz", "Fizz Buzz")

for(i in 1:length(listNumbers)) {
  if (listNumbers[i] %in% listMultipleThree && listNumbers[i] %in% listMultipleFive){
    listNumbers[i]=text[3]
  }
  else if (listNumbers[i] %in% listMultipleThree){
    listNumbers[i]=text[1]
  }
  else if (listNumbers[i] %in% listMultipleFive){
    listNumbers[i]=text[2]
  }
}

#Clean the environment
rm(i, listMultipleFive, listMultipleThree, text)

#Print the results
print(listNumbers)

########## [END] Adel's way ###############

# EL-Amine way Start 


  for(i in 1:1000) { 

      if((i%%3==0)&&(i%%5==0))   {print("Fizz Buzz")} 
    else { if(i%%5==0) { print("Buzz")}
     else {  if(i%%3==0) {print("Fizz") } 
       else print(i)}} }

# [END] EL-Amine


