# Anne Tyvijärvi 09/11/2023 Data wrangling

library(tidyverse)
library(dplyr)

# Read the table into R

learning2014 <- read.table("")

#Read data into R
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", 
                           header = TRUE, sep = "\t")

# Structure and dimensions
dim(lrn14) #183 rows and 60 columns
str(lrn14) #numbers are integer, all data numeric except "gender" is F/M

lrn14$attitude <- lrn14$Attitude / 10 # create a new column 'attitude' in lrn14

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning 
deep_columns <- select(lrn14, one_of(deep_questions))
# and create column 'deep' by averaging
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning 
surface_columns <- select(lrn14, one_of(surface_questions))
# and create column 'surf' by averaging
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning 
strategic_columns <- select(lrn14, one_of(strategic_questions))
# and create column 'stra' by averaging
lrn14$stra <- rowMeans(strategic_columns)

# choose a handful of columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
keep_columns

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))


# see the structure of the new dataset

str(learning2014)


setwd("C:\Users\03114911\OneDrive - Valtion\Anne's PhD papers, results, plans etc\MBDP\Open data science\IODS-project\Data")

