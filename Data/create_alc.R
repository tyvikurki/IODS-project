# Anne Tyvijärvi 15/11/2023; R script for assignment 3; data downloaded from http://www.archive.ics.uci.edu/dataset/320/student+performance

library(tidyverse)
library(dplyr)
library(ggplot2)

#Let's read in the data..
math <- read.csv("./Data/student-mat.csv", sep = ";", header = TRUE)
por <- read.csv("./Data/student-por.csv", sep = ";", header = TRUE)

#... and look at their structure and dimensions
str(math) # data frame with character and integer values
dim(math) # 395 rows, 33 columns
str(por) # data frame with character and integer values
dim(por) #694 rows, 33 columns

# OK, then let's join the two data sets using all other variables except failures,
# paid, absences, G1, G2 and G 3. Let's first create a vector including these.
free_cols <- c("failures", "paid", "absences", "G1", "G2", "G3")

# Then, let's create a vector using "all the others"..
join_cols <- setdiff(colnames(por), free_cols)

#.. and join the two data sets by join_cols
math_por <- inner_join(math, por, by = join_cols, suffix = c(".math", ".por"))

head(math_por)
# Let's see structure and dimension now
str(math_por) # Now we have a data frame with integer and character "values"
dim(math_por) # With 370 rows and 39 columns

# Next, let's remove any duplicate records from the data
# First, a new data frame including the joined columns
alc <- select(math_por, all_of(join_cols))

# Then let's dive into the fun part..
# For column names not used in joining, select two column names that have the same
# original name and look at the first column vector of those two; IF the first column vector
# is numerical, take a rounded average of each row of the two columns and add that vector
# to the data frame alc; ELSE add the first column vector to the data frame alc
for(col_name in free_cols) {
  two_cols <- select(math_por, starts_with(col_name))
  first_col <- select(two_cols, 1)[[1]]
  if(is.numeric(first_col)) {
    alc[col_name] <- round(rowMeans(two_cols))
  } else {
    alc[col_name] <- first_col
  }
}

glimpse(alc) # Looking good, feeling fine!


# Now, lets create a new column based on weekday and weekend alcohol use average
# and another logical column for high alcohol use (TRUE/FALSE)
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)
head(alc)
glimpse(alc)


write_csv(alc, "./Data/create_alc.csv")

# THE END!
