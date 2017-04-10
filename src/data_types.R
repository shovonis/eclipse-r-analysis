#Matrix
mat <- matrix(1:6, nrow = 2, ncol = 3)
attributes(mat)
mat

#Matrices can also be created directly from vectors by adding a dimension attribute.
m <- 1:10
print(m)
dim(m) = c(2, 5)
print(m)

#Matrices can be created by column-binding or row-binding with the cbind() and rbind() functions.
x <- 1:3
y <- 7:9
cbind(x, y)

#Row wise matrix
rbind(x, y)

#Lists can be explicitly created using the list() function, which takes an arbitrary number of
#arguments.

l <- list(1, "2", "Rifatul", TRUE, 1+2i, c(1, 2, 3))
print(l)

#an empty list of a prespecified length with the vector() function
list <- vector("list", length = 5)
print(list)

#Factors are used to represent categorical data and can be unordered or ordered
answeres <- c("Yes", "Yes", "No", "No", "Yes")
factorized.ans <- factor(answeres)
print(factorized.ans)

## See the underlying representation of factor
unclass(factorized.ans)

## Levels are put in alphabetical order But can tweek it if necessary
factorized.ans <- factor(answeres, labels = c("Yes", "No"))
print(factorized.ans)

##Data Frames
data_frame <- data.frame(x = c(1:4), y=c(T, T, F, F))
print(data_frame)

#Naming List and Matrix
l <- c(1:3)
names(l) <- c("One", "Two", "Three")
names(l)

#Lists can also have names, which is often very useful.
x <- list("Los Angeles" = 1, Boston = 2, London = 3)
x

#naming matrix
m <- matrix(1:4, nrow = 2, ncol = 2)
dimnames(m) <- list(c("a", "b"), c("c", "d"))

#name can also be declared explicitely
colnames(m) <- c("h", "f")
rownames(m) <- c("x", "z")
