library('dplyr')
chicgo <- readRDS("resource/chicago")

#Meta data in dplyr
dim(chicgo)
str(chicgo)
names(chicgo)

#Using select with chicago data
head(select(chicgo, city:dptp))
#Printing data set without city and tmpd
head(select(chicgo, -(city:tmpd)))

# Without dplyr package we would have to do something like this
i <- match("city", names(chicgo)) # Index of city
j <- match("tmpd", names(chicgo)) # Index of tmpd
head(chicgo[, -(i:j)])

# Select can also used to matching
ends.with.d <-
  select(chicgo, ends_with("2")) # Patten matched not with data but with column name
head(ends.with.d)

# Can also filter dataset based on conditions
chicgo.max.tmp <- filter(chicgo, tmpd > 60)
head(chicgo.max.tmp)
summary(chicgo.max.tmp$pm25tmean2)

#Multiple filter
chicgo.max.dptp <- filter(chicgo,  dptp > 40 & tmpd > 50)
head(chicgo.max.dptp)

#Arranging data set
chicago.date <- arrange(chicgo, date)
head(chicago.date)
tail(chicago.date)
chicago.date.des <- arrange(chicgo, desc(date))
head(chicago.date.des)

#Renaming
chi_renamed <- rename(chicgo, city_name = city)
head(chi_renamed)

#Mutate function to add new matrix to the dataset
chicgo <-
  mutate(chicgo, tmpcat = factor(tmpd > 80, labels = c("Cold", "Hot")))
chicgo <- mutate(chicgo, humid_cat = factor(tmpd >= 40
                              & tmpd < 60
                              & dptp >= 35, labels = c("Dry", "Wet")))
head(chicgo)

# Transmute() function, which does the same thing as mutate() but then
# drops all non-transformed variables
chicga.trans <- transmute(chicgo, pm25detrend = pm10tmean2 - mean(pm10tmean2, na.rm = TRUE))
head(chicga.trans)

# Group by and summarise
chicgo <- mutate(chicgo, year = as.POSIXlt(date)$year + 1900 )
head(chicgo)
year <- group_by(chicgo, year)
summarise(year, pm25 = mean(pm25tmean2, rm.na = TRUE), pm10 = max(o3tmean2, rm.na=TRUE))

qq <- quantile(chicgo$pm25tmean2, seq(0, 1, 0.2), na.rm = TRUE)
chicgo <- mutate(chicgo, pm25.quint = cut(pm25tmean2, qq))
chicgo
quint <- group_by(chicgo, pm25.quint)
quint
summarize(quint, o3 = mean(o3tmean2, na.rm = TRUE),
           no2 = mean(no2tmean2, na.rm = TRUE))
