# Argyments of read.table()
#   file, the name of a file, or a connection
#   header, logical indicating if the file has a header line
#   sep, a string indicating how the columns are separated
#   colClasses, a character vector indicating the class of each column in the dataset
#   nrows, the number of rows in the dataset. By default read.table() reads an entire file.
#   comment.char, a character string indicating the comment character. This defalts to "#". If there
# are no commented lines in your file, it’s worth setting this to be the empty string "".
# • skip, the number of lines to skip from the beginning
# • stringsAsFactors, should character variables be coded as factors? This defaults to TRUE
# because back in the old days, if you had data that were stored as strings, it was because
# those strings represented levels of a categorical variable. Now we have lots of data that is text
# data and they don’t always represent categorical variables. So you may want to set this to
# be FALSE in those cases. If you always want this to be FALSE, you can set a global option via
# options(stringsAsFactors = FALSE). I’ve never seen so much heat generated on discussion
# forums about an R function argument than the stringsAsFactors argument. Seriously.

#Reading in moderate file
data <- read.table("foo.txt")

#Reading in large file need to specify the other arguments;
#Reading in Larger Datasets with read.table

initial <- read.table("datatable.txt", nrows = 100) #Get only the initial rows
classes <- sapply(initial, class) #Find out the classes of the data set
tabAll <- read.table("datatable.txt", colClasses = classes) #Specifying the classes of the collums will generate much faster results.


#Using the readr Package
install.packages("readr")

