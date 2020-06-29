---
title: 'Data Dictionary - tidydata.txt'
author: "Zhao Zheng"
date: "6/27/2020"
output:
  html_document:
    df_print: paged
---

## Description of my tidy data
My tidy data set is stored in the "tidydata.txt" and can be read using the R code below if you put it in your working directory:

```{r}
data<-read.table("tidydata.txt", header=T)
```

This is the alternative way of reading the file
```{r}
address <- "https://raw.githubusercontent.com/ZhaoZ-2020/GettingnCleaningData_Project/master/tidydata.txt"
address <- sub("^https", "http", address)
data <- read.table(url(address), header = TRUE) 
```

The data is in long form with 15480 rows and 5 columns. 

There are 30 subjects, 6 activitys and I have extracted 86 features related to  the mean and standard deviation. I have calculated the average of each of the 86 features, for each activity and each subject. Therefore, the data has in total (30 X 6 X 86=15480) rows.

For step-by-step description on how to obtain this tidy data, please refer to README.md.

Data dictionary for the 5 columns are appended below: 

### 1.Subject

Variable name: Subject

Description: Subject IDs (ranges from 1 to 30) for the 30 volunteers who participated in the experiment. 

Type: Integer 

Value: 1, 2, 3, ..., 30

Units: This is a categorical variable, so no units.


### 2.Group

Variable name: Group

Description: Obtained dataset for the 30 subjects has been randomly partitioned into two groups, they are "training group" and "test group".

Type: Character 

Value:  
training group  
test group  

Units: This is a categorical variable, so no units.

Note: Subjects 2, 4, 9, 10, 12, 13, 18, 20, 24 has been assigned to test group, while the rest of the subjects has been assigned to training group.


### 3.Activity

Variable name: Activity

Description: The six activities each subject had performed in the experiment.

Type: Character

Value:  
walking  
walking_upstairs  
walking_downstairs  
sitting  
standing  
laying  

Units: This is a categorical variable, so no units.



### 4.Feature

Variable name: Feature

Description: The 86 features, on the mean and standard deviation, selected out of the 561 features from the original dataset. For more details on what does each feature mean, please refer to "features_info.txt" in the origional data set folder "UCI HAR Dataset".

Type: Character
 
Value:  
tBodyAcc_mean_X  
tBodyAcc_mean_Y  
tBodyAcc_mean_Z  
tBodyAcc_std_X  
tBodyAcc_std_Y  
tBodyAcc_std_Z  
tGravityAcc_mean_X  
tGravityAcc_mean_Y  
tGravityAcc_mean_Z  
tGravityAcc_std_X  
tGravityAcc_std_Y  
tGravityAcc_std_Z  
tBodyAccJerk_mean_X  
tBodyAccJerk_mean_Y  
tBodyAccJerk_mean_Z  
tBodyAccJerk_std_X  
tBodyAccJerk_std_Y  
tBodyAccJerk_std_Z  
tBodyGyro_mean_X  
tBodyGyro_mean_Y  
tBodyGyro_mean_Z  
tBodyGyro_std_X  
tBodyGyro_std_Y  
tBodyGyro_std_Z  
tBodyGyroJerk_mean_X  
tBodyGyroJerk_mean_Y  
tBodyGyroJerk_mean_Z  
tBodyGyroJerk_std_X  
tBodyGyroJerk_std_Y  
tBodyGyroJerk_std_Z  
tBodyAccMag_mean  
tBodyAccMag_std  
tGravityAccMag_mean  
tGravityAccMag_std  
tBodyAccJerkMag_mean  
tBodyAccJerkMag_std  
tBodyGyroMag_mean  
tBodyGyroMag_std  
tBodyGyroJerkMag_mean  
tBodyGyroJerkMag_std  
fBodyAcc_mean_X  
fBodyAcc_mean_Y  
fBodyAcc_mean_Z  
fBodyAcc_std_X  
fBodyAcc_std_Y  
fBodyAcc_std_Z  
fBodyAcc_meanFreq_X  
fBodyAcc_meanFreq_Y  
fBodyAcc_meanFreq_Z  
fBodyAccJerk_mean_X  
fBodyAccJerk_mean_Y  
fBodyAccJerk_mean_Z  
fBodyAccJerk_std_X  
fBodyAccJerk_std_Y  
fBodyAccJerk_std_Z  
fBodyAccJerk_meanFreq_X  
fBodyAccJerk_meanFreq_Y  
fBodyAccJerk_meanFreq_Z  
fBodyGyro_mean_X  
fBodyGyro_mean_Y  
fBodyGyro_mean_Z  
fBodyGyro_std_X  
fBodyGyro_std_Y  
fBodyGyro_std_Z  
fBodyGyro_meanFreq_X  
fBodyGyro_meanFreq_Y  
fBodyGyro_meanFreq_Z  
fBodyAccMag_mean  
fBodyAccMag_std  
fBodyAccMag_meanFreq  
fBodyBodyAccJerkMag_mean  
fBodyBodyAccJerkMag_std  
fBodyBodyAccJerkMag_meanFreq  
fBodyBodyGyroMag_mean  
fBodyBodyGyroMag_std  
fBodyBodyGyroMag_meanFreq  
fBodyBodyGyroJerkMag_mean  
fBodyBodyGyroJerkMag_std  
fBodyBodyGyroJerkMag_meanFreq  
angle(tBodyAccMean_gravity)  
angle(tBodyAccJerkMean)_gravityMean)  
angle(tBodyGyroMean_gravityMean)  
angle(tBodyGyroJerkMean_gravityMean)  
angle(X_gravityMean)  
angle(Y_gravityMean)  
angle(Z_gravityMean)  

Units: This is a categorical variable, so no units.


### 5. Mean

Variable name: Mean

Description: the average of each feature (from the list of features in point 4) for each activity and each subject.

Type: numeric

Value: 0.277, 0.255, 0.289, 0.261, 0.279 ...

Summary:  
    Min.  1st Qu.   Median     Mean  3rd Qu.     Max.   
-0.99767 -0.94485 -0.29465 -0.38429 -0.01599  0.97451   

Units: unit-free

Note: The acceleration signal from the smartphone accelerometer (for X, Y and Z axis) in standard gravity units 'g', and the angular velocity vector measured by the gyroscope having units radians/second. 

However, because the original data for the 561 features has been normalised, our mean values here are thus unit-free.





