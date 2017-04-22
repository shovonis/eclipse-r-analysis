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







###Chart###
#Pie 
value <- c(45, 50, 75, 25, 68)
label <- c("Dhaka", "Montreal", "London", "Texas", "Dellhi")

#png(file="city.jpg")
pie(value, label, main = "City Percentage")
#dev.off()

png(file="city.png")
percentage <- round(100 * value/sum(value), 1)
pie(value, percentage, col = rainbow(length(value)))
legend("topright", label, cex = 1, fill = rainbow(length(value)))
dev.off()

#Barplot
barplot(value, names.arg =  label, xlab = "City", ylab = "Humidity", col = c("black", "orange", "white"))
matvalue <- matrix(c(2, 3, 4, 5, 9, 7, 9, 3, 5), nrow = 3, ncol = 3)
barplot(matvalue, names.arg =  c("Dhaka", "Montreal", "Texas"), xlab = "City", ylab = "Humidity", col = c("black", "orange", "white"))
  

#BoxPlot
input <- mtcars[,c("mpg", "cyl")]
print(head(input))
print(mtcars)

boxplot(mpg~gear, data = mtcars, xlab="Gear", ylab="Miles per gallon")


v <- mtcars[, "cyl"]
hist(v, xlab = "Cylinder", xlim = c(4, 7), ylim = c(0, 15), breaks = 6)

#Plot
v <- c(7,12,28, 7, 3, 4, 5)
y <- c("Sev", "Twlv",  "Twnty")
plot(v,xlab ="String", ylab = "Valye" )

mean(v, trim = 0.3, na.rm = TRUE)

x <- c(12,7,3,4.2,18,2,54,-21,8,-5)
median(x)
unique(v)
tabulate(7)

help("tabulate")

#Linear Regression
x <- c(151, 174, 138, 186, 128, 136, 179, 163, 152, 131)
y <- c(63, 81, 56, 91, 47, 57, 76, 72, 62, 48)
relation <- lm(y~x)
summary(relation)
predict(relation, data.frame(x = 189))
plot(y, x, abline(lm(x~y)), main = "Test", xlab = "Weight", ylab = "Height", pch=16, cex = 1.3)

#Multiple Regression
input <- mtcars[,c("mpg","disp","hp","wt")]
m.relation <- lm(mpg~ disp+disp+hp+wt, input)
print(m.relation)
print(input)
predict(m.relation, input, type="response")

#Logistic Regression
input <- mtcars[,c("am","cyl","hp","wt")]
print(head(input))
relation <- glm(formula = am ~ cyl + hp + wt, data = input, family = binomial)
print(summary(relation))
predict(relation, data.frame(cyl=6, hp=110, wt=2.62), type="response")

help(print)

