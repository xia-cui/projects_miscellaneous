## Project description

This folder includes the script which is run to tidy up the dataset downloade from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description of the dataset can be found from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The tidyup process as shown in the R script (run_analysis.R) follows five steps:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The packages that are needed to run the script are "downloader" and "dplyr". These are 
installed and downloaded at the start of the script. 

You can also find the CodeBook.md in this folder which describes the variables, the data, and transformations that has been performed to clean up the data. 
