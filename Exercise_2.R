# Project: Data Wrangling Exercise 2: Dealing with missing values

# Load libraries and setting work directory
library(tidyr)
library(dplyr)
setwd("/Users/Tortosae/Desktop/Data science course")

# 0: Load the data in RStudio

df <- read.csv(file="titanic_original.csv",header=TRUE)
View(df)

#1: Port of embarkation

#Find the missing values and replace them with S for the embarked column
levels(df$embarked)
df <- df %>% mutate(embarked = gsub("^$", "S", embarked))

#2: Age

#Calculate the mean of the Age column and use that value to populate the missing values
mean_age <- mean (df$age, na.rm = TRUE)
df <- df %>%  mutate(age = ifelse(is.na(age), mean_age, age))

#Think about other ways you could have populated the missing values in the age column. 
#Why would you pick any of those over the mean (or not)?
# We could use the median, when the data set has some outliers.
# We could also replace missing values with a random value that is drawn between the minimum and maximum of the variable.
# We could also remove rows with NA from the dataset.

#3: Lifeboat
#Fill empty slots in the boat column with a dummy value e.g. the string 'None' or 'NA'.
df <- df %>% mutate(boat =gsub("^$", "None", boat))

#4: Cabin
#Does it make sense to fill missing cabin numbers with a value?
#No, it doesn't. With the available data we cannot predict the cabin number and 
#we cannot fill the missing value with mean, median or random values as we did before.

#What does a missing value here mean?
#It could mean many things;
#1)People from lower class were not assigned to any cabin 
#2) We have lost that information

#Create a new column has_cabin_number which has 1 if there is a cabin number, and 0 otherwise.
df <- df %>% mutate(has_cabin_number = ifelse (cabin == "", 0, 1))

#5: Submit the project on Github
write.table(df, file = "titanic_clean.csv", sep = ",", col.names = NA)
