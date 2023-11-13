# Anne Tyvijärvi 09/11/2023 Data wrangling

library(tidyverse)
library(dplyr)

#Read data into R
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", 
                           header = TRUE, sep = "\t")
# Structure and dimensions
dim(lrn14) #183 rows and 60 columns
str(lrn14) #numbers are integer, all data numeric except "gender" is F/M


# create a new column 'attitude' in lrn14
lrn14$attitude <- lrn14$Attitude / 10 
lrn14

# combine data related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# choose columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
keep_columns

# select the 'keep_columns' to create a new dataset
lrn14 <- select(lrn14, one_of(keep_columns))

# change the name to "age"
colnames(lrn14)[2] <- "age"

# change the name "points"
colnames(lrn14) [7] <- "points"

# select rows where points is greater than zero
learning2014 <- filter(lrn14, points > 0)

# set working directory
setwd("C:/Users/03114911/OneDrive - Valtion/Anne's PhD papers, results, plans etc/MBDP/Open data science/IODS-project")

# create .csv file
?write_csv
write_csv(learning2014, "Data/learning2014.csv")

# read back
learning2014_readback <- read_csv("Data/learning2014.csv", show_col_types = FALSE)

