---
title: 'ReadMe File'
author: "Zhao Zheng"
date: "6/27/2020"
---


## Files contained in the Repo

Thank you for spending time to review my project.

There are four files in my GitHub repo "GettingnCleaningData_Project", and they are:  
1. run_analysis.R  
2. tidydata.txt  
3. CodeBook.md  
4. README.md  

The Weblink to my repo is: https://github.com/ZhaoZ-2020/GettingnCleaningData_Project

### 1. run_analysis.R

After running this R code you will be able to get a tidy data txt file named "tidydata.txt". Please note, in order to run the scrip, you will need to save the project data (in the folder) "UCI HAR Dataset" in to your working directory.

Inside this R script, I have also included some comments to explain what does each section of the codes do. I will give a more detailed step-by-step description later in this README.md file.


### 2. tidydata.txt

This is the final tidy data txt file. Once saving it to your working directory, you can use the R code below to read it:

```{r}
data<-read.table("tidydata.txt", header=T)
```

If you have problem downloading the txt file, you can try to open it directly with its url address, using the code below:
```{r}
address <- "https://raw.githubusercontent.com/ZhaoZ-2020/GettingnCleaningData_Project/master/tidydata.txt"
address <- sub("^https", "http", address)
data <- read.table(url(address), header = TRUE) 
```

It meets the principles of tidy data (from Hadley Wickham’s Tidy Data paper) below:  
1. Each variable forms a column: there are only 5 columns in my tidy data set and each one of them corresponds to one variable. Refer to CodeBook.md for more details.  
2. Each observation forms a row: in my tidy data set, one row refers to one mean value of a feature, for one subject under one activity.  
3. Each type of observational unit forms a table: the first four columns are categorical variables. The last column contains measurements (i.e. mean of the features) and this variable is unit-free as the origional data is normalized.


### 3. CodeBook.md

This R markdown file give some description of my tidy data, and there is a data dictionary for all variables (columns) in the data set, including information like variable type, values, units, etc.


### 4. README.md

This file explains what does each of the four files do and give a step-by-step description on how to obtain the tidy data set from the origional data sets provided.



## Step-by-step explaination on how to get the tidy data

### Step 1: Merges the training and the test data sets
Read in the training data set from the project data folder, and check the dimension. There are 7354 rows and 561 columns.

```{r}
data_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
dim(data_train)
```

Read in the data on Subject ID for this training group and check that it also has 7352 row, but only 1 column.
After tabulating, I find that there are 21 subjects in this group, with subject IDs: 1, 3, 5, 6, 7, 8, 11, 14, 15, 16, 17, 19, 21, 22, 23, 25, 26, 27, 28, 29 and 30.

```{r}
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
dim(subject_train)
table(subject_train)
```

Read in the data with the activity IDs, and the data contains 7352 rows and 1 columns. The activity IDs ranges from 1 to 6.

```{r}
label_train<-read.table("./UCI HAR Dataset/train/Y_train.txt")
dim(label_train)
table(label_train)
```

Combine the three sets of data above into one single data set, and add one extra column to indicate that this data set is for the training group. Change the column names accordingly. (The other 561 columns, will have their names changed in Step 2)
Since the dataset is quite big, I only preview the first 3 rows with the first 10 columns.

```{r}
data_train<-cbind(subject_train, "training group", label_train, data_train)
names(data_train)[1:3]<-c("Subject", "Group", "Activity")
```

Repeat the same steps for the test data set.
The test data set has 2947 rows, and the 9 subjects are: 2, 4, 9, 10, 12, 13, 18, 20 and 24.
Combine the test data with its corresponding the Subject IDs and Activity IDs, and also add a column to indicate this is the "test group".


```{r}
data_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
dim(data_test)

subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
dim(subject_test)
table(subject_test)

label_test<-read.table("./UCI HAR Dataset/test/Y_test.txt")
dim(label_test)
table(label_test)

data_test<-cbind(subject_test, "test group", label_test, data_test)
names(data_test)[1:3]<-c("Subject", "Group", "Activity")
```

Check the dimension for the training data and test data again. They have the same number of columns, and the subject IDs are different. Therefore, just use function *rbind()* to append the two data sets together.
The combined data set "data" has 10299 rows and 564 columns.

```{r}
dim(data_train); table(data_train$Subject)
dim(data_test); table(data_test$Subject)

data<-rbind(data_train, data_test)
dim(data)
```




### Step 2: Extract the measurements on the mean and standard deviation


Load the names for the 561 features from the project data folder. This data contains 561 rows and 2 columns.

```{r}
feature<-read.table("./UCI HAR Dataset/features.txt")
str(feature)
```

Assign these features as the column names of my data for colummn 4 to column 564. 

```{r}
length(names(data)[-(1:3)])  
names(data)[-(1:3)]<-feature[,2]  
names(data)
```

Select those columns with "Mean", "mean" or "std" in their column names using *grep()* function with regular expression. These are the features on the mean and standard deviation, and there are 86 of such features. 
Keep the first three columns (Subject, Group, Activity) as well, and now the data set has 10299 rows and (3+86=89) columnns.

```{r}
index<-grep("[Mm]ean|std", names(data))
data<-data[,c(1:3, index)]
names(data)
dim(data)
```


### Step 3: Uses descriptive activity names to name the activities

Load in the data with activity ID (ranges from 1 to 6) and activity names (in descriptive words). 
Set the Activity column in my data set as factor, and assign the activity ID as the factor levels and assign the activity names as the lables. In this way, when you view the data you can see that the activity columns now have descriptive activity names instead of integer 1 to 6.

```{r}
label_activity<-read.table("./UCI HAR Dataset/activity_labels.txt")
label_activity

data$Activity<-factor(data$Activity, levels=label_activity[,1], labels=tolower(label_activity[,2]))
head(data$Activity)
```




### Step 4: Appropriately labels the data set with descriptive variable names

The current names (obtained from the features.txt) are quite descriptive with the abbreviations, some of the examples are given below:  
- Prefix 't' refers to time domain signals;  
- Prefix 'f' indicate frequency domain signals;  
- BodyAcc stands for body acceleration signals;  
- GravityAcc stands for gravity acceleration signals;  
- BodyAccJerk refers to the Jerk signals calculated from body linear acceleration;  
- "X", "Y" and "Z" are used to denote 3-axial signals in the X, Y and Z directions;  
For more details on what does each of the abbreviation mean, please refer to README.

Therefore, I just remove the "()" and change "-" and "," to "_", using the *sub()* and *gsub()* functions.

```{r}
names(data)<-sub("\\()", "", names(data))
names(data)<-gsub("-|,", "_", names(data))
names(data)
```{r}



### Step 5: Create a tidy data set contains the average of each variable for each activity and each subject.

Just to recap that the currect data set has 10299 rows and 89 columns. The first three columns give you the Subject ID, Group information and Activity names, while the remaining 86 columns contain the features on the mean and standard deviation. 

I use the function *aggregate()* to calculate the average of the measurements for the 86 features, by Subject, Group and Activity, and store the results in the data frame called "meandata".
Each row of this "meandata" contains the average values for the 86 features for one subject (belongs to one group of course) for one activity. 

```{r}
dim(data)
names(data)
meandata<-aggregate(data[,4:dim(data)[2]], by=data[,1:3], mean)
meandata[1,]
```

### Reshape the data into long format so that 
### the names of the 561 features are in one column named feature

I reshape the meandata to long form using *melt()* function in the library **reshape2**, and save the results in a data frame called "tidydata". 
This tidydata has 15480 rows and 5 columns. It contains the mean values for the 86 features, for each subjects and each activitys, i.e. 86X30X6=15480 rows.

I have also sort the data so that within each feature, The Subject ID is in ascending order, and within each subject ID the activity also in ascending order (based on the factor levels 1 to 6 instead of the characters in the labels)


```{r}
library(reshape2)
tidydata<-melt(meandata, id.vars=c("Subject", "Group", "Activity"))
names(tidydata)[4:5]<-c("Feature", "Mean")
names(tidydata)

tidydata<-tidydata[order(tidydata$Feature, tidydata$Subject, tidydata$Activity),]
rownames(tidydata)<-NULL
head(tidydata)
str(tidydata)
```

The final step is to save the tidy data set (tidydata) in to a txt file. Add in the row.name=FALSE as requested.

```{r}
write.table(tidydata, "tidydata.txt", row.name=FALSE)
```

Please note that, you can simple use the code below to read the tidy data file, but instead of factor you will have Group, Activity and Feature Columns as class = character. 

Note: if you want to read them in as factors, can use argument *as.is*. But to keep the read.table command simple, I will leave it out for my project.

```{r}
newdata<-read.table("tidydata.txt", header=T) 
str(newdata)
head(newdata)
```


