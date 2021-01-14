This CodeBook describes the variables, the data, and transformations that has been performed to clean up the data downloaded from 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data which this codebook is for represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

A full description of the dataset can be found from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were captured. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

In the unzipped downloaded folder, the features.txt lists the 561 features which are measured for each subject and each activity. The test folder contains measurements of 30% of the subjects, and the train folder contains measurements of 70% of the subjects. 

First of all the training and test datasets are merged, resulting in a dataset of 563 variables (subject, activity and the 561 features), and 10299 observations. 

Among the 561 features, only 66 are measurements of the mean and standard deviation. Therefore the dataset is further extracted keeping only these 66 features.

In the original datasets, activity names are reprented by numbers 1-6. In the final dataset, the numbers are replaced by descriptive activity names: walking, upstairs, downstairs, sitting, standing, and laying. 

The feature names in the original datasets contain "-", "()", and a mix of upper and lower cases. In the final data set, the variable names are all in lower cases, and the brackets are removed. however, "_" are used because some of the feature names are very long and without "_" it is hard to distinguish. Below is a list of the 68 variable names in the final data set. 

1. subject: Factor w/30 levels "1", "2", "3", .... "30" 
2. activity: Factor w/6 levels 1-6 representing "walking", "upstairs", "downstairs", "sitting", "standing", "laying", respectively. 

Variable 3 to 60 are all numeric variables, including: 
 [3] "tbodyacc_mean_x"           "tbodyacc_mean_y"          
 [5] "tbodyacc_mean_z"           "tbodyacc_std_x"           
 [7] "tbodyacc_std_y"            "tbodyacc_std_z"           
 [9] "tgravityacc_mean_x"        "tgravityacc_mean_y"       
[11] "tgravityacc_mean_z"        "tgravityacc_std_x"        
[13] "tgravityacc_std_y"         "tgravityacc_std_z"        
[15] "tbodyaccjerk_mean_x"       "tbodyaccjerk_mean_y"      
[17] "tbodyaccjerk_mean_z"       "tbodyaccjerk_std_x"       
[19] "tbodyaccjerk_std_y"        "tbodyaccjerk_std_z"       
[21] "tbodygyro_mean_x"          "tbodygyro_mean_y"         
[23] "tbodygyro_mean_z"          "tbodygyro_std_x"          
[25] "tbodygyro_std_y"           "tbodygyro_std_z"          
[27] "tbodygyrojerk_mean_x"      "tbodygyrojerk_mean_y"     
[29] "tbodygyrojerk_mean_z"      "tbodygyrojerk_std_x"      
[31] "tbodygyrojerk_std_y"       "tbodygyrojerk_std_z"      
[33] "tbodyaccmag_mean"          "tbodyaccmag_std"          
[35] "tgravityaccmag_mean"       "tgravityaccmag_std"       
[37] "tbodyaccjerkmag_mean"      "tbodyaccjerkmag_std"      
[39] "tbodygyromag_mean"         "tbodygyromag_std"         
[41] "tbodygyrojerkmag_mean"     "tbodygyrojerkmag_std"     
[43] "fbodyacc_mean_x"           "fbodyacc_mean_y"          
[45] "fbodyacc_mean_z"           "fbodyacc_std_x"           
[47] "fbodyacc_std_y"            "fbodyacc_std_z"           
[49] "fbodyaccjerk_mean_x"       "fbodyaccjerk_mean_y"      
[51] "fbodyaccjerk_mean_z"       "fbodyaccjerk_std_x"       
[53] "fbodyaccjerk_std_y"        "fbodyaccjerk_std_z"       
[55] "fbodygyro_mean_x"          "fbodygyro_mean_y"         
[57] "fbodygyro_mean_z"          "fbodygyro_std_x"          
[59] "fbodygyro_std_y"           "fbodygyro_std_z"          
[61] "fbodyaccmag_mean"          "fbodyaccmag_std"          
[63] "fbodybodyaccjerkmag_mean"  "fbodybodyaccjerkmag_std"  
[65] "fbodybodygyromag_mean"     "fbodybodygyromag_std"     
[67] "fbodybodygyrojerkmag_mean" "fbodybodygyrojerkmag_std" 


