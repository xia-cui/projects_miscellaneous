## STEP 1: Merge the training and the test sets to create one data set
##install and load the packages needed
install.packages("downloader")
install.packages("dplyr")
library(downloader)
library(dplyr)

##download and unzip files
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download(url, "dataset.zip", mode = "wb")
unzip("dataset.zip", exdir = "./")
setwd("./UCI HAR Dataset")

#load and combine the test files
subject_test <- read.table("./test/subject_test.txt", 
                           col.names = "subject")
test_set <- read.table("./test/X_test.txt")
test_label <- read.table("./test/y_test.txt", col.names = "testlabel")
test <- cbind(subject_test, test_label, test_set)

## load and combine the training files
subject_train <- read.table("./train/subject_train.txt", 
                           col.names = "subject")
train_set <- read.table("./train/X_train.txt")
train_label <- read.table("./train/y_train.txt", col.names = "testlabel")
train <- cbind(subject_train, train_label, train_set)

##merge the the test and the training dataset
data <- rbind(test, train)

##STEP 2: Extract only the measurements on the mean and sd for each
##getting the features' list
features <- read.table("features.txt")
## getting the list of those that only measures mean and
##standard deviation. +2 is here because we want to include
## the 2 variables in the data already
feature_list <- grep("mean()\\b|std()\\b", features$V2) + 2
##use the list of reduced features to subset the data, column 1 and 2 are kept.
reduced_data <- data[,c(1, 2, feature_list)]

##checking the dimension of the reduced data which has 66 variables
dim(reduced_data)

##STEP 3: updating the activity name in the data
reduced_data$testlabel <- gsub(1, "walking", reduced_data$testlabel)
reduced_data$testlabel <- gsub(2, "upstairs", reduced_data$testlabel)
reduced_data$testlabel <- gsub(3, "downstairs", reduced_data$testlabel)
reduced_data$testlabel <- gsub(4, "sitting", reduced_data$testlabel)
reduced_data$testlabel <- gsub(5, "standing", reduced_data$testlabel)
reduced_data$testlabel <- gsub(6, "laying", reduced_data$testlabel)

##STEP 4:label the dataset with descriptive feature names

##getting the features' names for the data
feature_namelist <- grep("mean()\\b|std()\\b", features$V2)
feature_names <- features$V2[feature_namelist]

##tidying up feature names
feature_names <- tolower(feature_names)
feature_names <- gsub("-", "_", feature_names)
feature_names <- gsub("[()]", "", feature_names)

##renaming the column variables 
names(reduced_data) <- c("subject", "activity", feature_names)

##changing the name of the dataset to tidydata
tidydata <- reduced_data

##create a second tidy data set with the average of each variable for 
##each activity and each subject

##change subject and activity to class factor
tidydata$activity <- as.factor(tidydata$activity)
tidydata$subject <- as.factor(tidydata$subject)

##aggregate tidydata based on subject and activity
new_data <- aggregate(tidydata[,c(3:68)], 
                      by = list(tidydata$subject, tidydata$activity), 
                      FUN = mean)

##change back the names of the first 2 columns
new_data <- rename(new_data, "subject" = "Group.1", "activity" = "Group.2")

##Write up new data into text file
write.table(new_data, file = "newdata.txt", row.names = FALSE)