#Anne Tyvijärvi
#Assignments 4 & 5 (see row 44 for assignment 5 script)

#Assignment 4:
#Let's read in the data, explore structure and dimensions, and create summaries of the datasets gii and hd
library(readr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

dim(hd)
str(hd)
summary(hd)

dim(gii)
str(gii)
summary(gii)

# Let's change the variable names
colnames(hd)
colnames(hd) <- c('HDI.rank', 'Country', 'HDI', 'Life.Exp', 'Edu.Exp', 'Edu.mean', 'GNI', 'GNI.HDI')
colnames(hd)

colnames(gii)
colnames(gii) <- c('GII.rank', 'Country', 'GII', 'Mat.Mor', 'Ado.Birth', 'Parli.F', 'Edu2.F', 'Edu2.M', 'Labo.F', 'Labo.M')
colnames(gii)

# Adding two new variables according to the instructions

gii$Edu2.FM <- gii$Edu2.F / gii$Edu2.M
gii$Labo.FM <- gii$Labo.F / gii$Labo.M
colnames(gii)
summary(gii)

# Now let's Join the two data sets and save the data as human.csv
library(dplyr)
human <- inner_join(gii, hd, by = "Country")
glimpse(human)
library(readr)
human <- write_csv(x = human, "Data/human.csv")


# TADAA; there are now 195 observations and 19 variables

#Assignment 5:
library(readr)
human2 <- read_csv("./Data/human.csv")
str(human2) 
dim(human2)
# The data consists of 195 rows and 19 columns. Most variables are numerical values except for "Country", which is a character. 

#Columns to keep
colnames(human2)
keep <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")


#Remove rows with NAs
library(dplyr)
human2 <- select(human2, one_of(keep))
human2 <- filter(human2, complete.cases(human2))
colnames(human2)

#Remove observations related to regions instead of countries
unique(human2$Country)
tail(human2$Country, n = 10)
last <- nrow(human2) - 7
human2 <- human2[1:last, ]

glimpse(human2)

#Now there are 155 observations (rows) and 9 variables (columns). :)

write_csv(human2, "./Data/human2.csv") #..I did not want to overwrite the original human.csv..
