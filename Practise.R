i <- 1
repeat {
  print("Hello World")
  i <- i + 1
  if (i > 5) {
    break()
  }
}

alphabet = LETTERS[1:4]
for (l in alphabet) {
  print(l)
}

add_func <- function(a, b) {
  a + b
}
add_func(5, 6)

addition <- function(a = 0, b = 0) {
  a + b
}

addition()
addition(2, 3)


intro <- "Hello! Good Morning."
name <- "Rifatul"
print(paste(intro, name, sep = "-"))


result <- format(23.123456789, digits = 9)
print(result)

result <- format(c(6, 13.14521), scientific = TRUE)
print(result)

result <- format(23.47, nsmall = 5)
print(result)

result <- format(6)
print(result)

result <- format(13.7, width = 6)
print(result)

result <- format("Hello", width = 8, justify = "l")
print(result)

print(seq(4, 6, by=.5))

# Accessing vector elements using position.
t <- c("Sun","Mon","Tue","Wed","Thurs","Fri","Sat")
u <- t[c(2,4,6)]
print(u)

# Accessing vector elements using logical indexing.
v <- t[c(TRUE,FALSE,FALSE,FALSE,FALSE,TRUE,FALSE)]
print(v)

# Accessing vector elements using negative indexing. Which means that -2 and -5 position are excluded.
x <- t[c(-2,-5)]
print(x)

# Accessing vector elements using 0/1 indexing.
y <- t[c(0,0,0,0,0,0,1)]
print(y)


v1 <- c(3,8,4,5,0,11)
v2 <- c(4,11,0,8,1,2)

# Vector addition.
add.result <- v1+v2
print(add.result)

v1 <- c(3,8,4,5,0,9)
v2 <- c(4,11)
print(v1 + v2)

v <- c(3,8,4,5,0,11, -9, 304)

# Sort the elements of the vector.
sort.result <- sort(v)
print(sort.result)

# Create two 2x3 matrices.
matrix1 <- matrix(c(3, 9, -1, 4, 2, 6), nrow = 2)
print(matrix1)

matrix2 <- matrix(c(5, 2, 0, 9, 3, 4), nrow = 2)
print(matrix2)

# Add the matrices.
result <- matrix1 + matrix2
cat("Result of addition","\n")
print(result)

# Subtract the matrices
result <- matrix1 - matrix2
cat("Result of subtraction","\n")
print(result)


##Reading from CSV file and use data to analysis
tmp <- read.csv("resource/file.csv")
print(tmp)
print(tmp$salary)
max_salary <- max(tmp$salary)
print(max_salary)
#Using column data for analysis
print(subset(tmp, as.Date(start_date, "%m/%d/%Y") > as.Date("02/02/14", "%m/%d/%Y")))
print(as.Date(tmp$start_date, "%m/%d/%Y"))


# Read the "mtcars" data frame as a csv file and store only the columns 
#"cyl", "am" and "gear".
write.table(mtcars, file = "mtcars.csv",row.names = FALSE, na = "", 
            col.names = TRUE, sep = ",")

my.mtcar <- read.table("mtcars.csv", header = TRUE, sep = ",", nrows = 5)
# Create a connection object to write the binary file using mode "wb".
write.filename = file("/web/com/binmtcars.dat", "wb")

# Write the column names of the data frame to the connection object.
writeBin(colnames(new.mtcars), write.filename)

# Write the records in each of the column to the file.
writeBin(c(new.mtcars$cyl,new.mtcars$am,new.mtcars$gear), write.filename)

# Close the file for writing so that it can be read by other program.
close(write.filename)

