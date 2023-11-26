
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
colnames(hd) <- c('HDI.rank', 'Country', 'HDI', 'Life.exp', 'Edu.exp', 'Edu.mean', 'GNI', 'GNI.HDI')
colnames(hd)

colnames(gii)
colnames(gii) <- c('GII.rank', 'Country', 'GII', 'Mat.mor', 'Ado.Birth', 'Parli.F', 'Edu2.F', 'Edu2.M', 'Labo.F', 'Labo.M')
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
write_csv(x = human, "Data/human.csv")


# TADAA; there are now 195 observations and 19 variables
