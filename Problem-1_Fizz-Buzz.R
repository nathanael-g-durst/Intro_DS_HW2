listNumbers <- 1:1000

listMultipleThree <- seq(from = 3, to = 1000, by = 3)
listMultipleFive <- seq(from = 5, to = 1000, by = 5)

listIntersect <- intersect(listMultipleThree, listMultipleFive)

listMultipleThree <- setdiff(listMultipleThree, listMultipleFive)
listMultipleFive <- setdiff(listMultipleFive, listMultipleThree)

text <- c("Fizz", "Buzz", "Fizz Buzz")

listNumbers <- replace(listNumbers, listMultipleThree, text[1])
listNumbers <- replace(listNumbers, listMultipleFive, text[2])
listNumbers <- replace(listNumbers, listIntersect, text[3])

print(listNumbers)