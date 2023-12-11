# Data wrangling 6, Anne Tyvijärvi 08/12/2023

library(dplyr)
library(tidyr)
rm(BPRS)

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", header = TRUE)
rats <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE)

#check their variable names
#view the data contents and structures
#create some brief summaries of the variables

#BPRS
names(BPRS)
dim(BPRS)
glimpse(BPRS)
summary(BPRS)

#transform categorical variables as factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

levels(BPRS$treatment)
levels(BPRS$subject)

#rats
names(rats)
dim(rats)
glimpse(rats)
summary(rats)

#transform categorical variables as factors
rats$Group <- factor(rats$Group)
rats$ID <- factor(rats$ID)
levels(rats$Group)
levels(rats$ID)

#convert BPRS and rats to long form
colnames(BPRS)
rownames(BPRS)

BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
          names_to = "weeks", values_to = "bprs") %>%
    arrange(weeks)
#add column "week"
BPRSL <-  BPRSL %>% 
  mutate(week = as.integer(substr(weeks,5,5)))
?substr

ratsL <-  pivot_longer(rats, cols = -c(Group, ID),
              names_to = "times", values_to = "weight") %>%
    arrange(times)
#add column "time"
ratsL <-  ratsL %>%
  mutate(time = as.integer(substr(times,3,4)))

glimpse(BPRS)# wide form
colnames(BPRS)
summary(BPRS)
glimpse(BPRSL) # long form
colnames(BPRSL)
summary(BPRSL)

glimpse(rats)# wide form
colnames(rats)
summary(rats)
glimpse(ratsL)# long form
colnames(ratsL)
summary(ratsL)
