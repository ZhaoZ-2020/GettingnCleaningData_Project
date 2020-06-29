

##########################################################
## Step 1: Merges the training and the test data sets   
##########################################################

### 1.1 Prepare the training data set
data_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
dim(data_train)

### Add tree columns into the training data set:
### 1)subject ID, 2)Group and 3)activity ID (refer to README for more details)
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
dim(subject_train)
table(subject_train)

label_train<-read.table("./UCI HAR Dataset/train/Y_train.txt")
dim(label_train)
table(label_train)

data_train<-cbind(subject_train, "training group", label_train, data_train)
names(data_train)[1:3]<-c("Subject", "Group", "Activity")



### 1.2 Prepare the test data set
data_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
dim(data_test)

### Add tree columns into the training data set:
### 1)subject ID, 2)Group and 3)activity ID (refer to README for more details)
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
dim(subject_test)
table(subject_test)

label_test<-read.table("./UCI HAR Dataset/test/Y_test.txt")
dim(label_test)
table(label_test)

data_test<-cbind(subject_test, "test group", label_test, data_test)
names(data_test)[1:3]<-c("Subject", "Group", "Activity")



### 1.3 Put these two data sets together 
### Note: since the two data sets have different subjects, 
###       to merge (append) them can just use rbind() instead of join().

dim(data_train); table(data_train$Subject)
dim(data_test); table(data_test$Subject)

data<-rbind(data_train, data_test)
dim(data)




#######################################################################
## Step 2: Extract the measurements on the mean and standard deviation
#######################################################################

### Load the names for the 561 features
feature<-read.table("./UCI HAR Dataset/features.txt")
str(feature)

### Assign these features as the column names of my data for columns 4 to 564
length(names(data)[-(1:3)])  
names(data)[-(1:3)]<-feature[,2]
names(data)

### Extract columns with their names contain "[Mm]ean" or "std"
index<-grep("[Mm]ean|std", names(data))
data<-data[,c(1:3, index)]
names(data)
dim(data)



#######################################################################
## Step 3: Uses descriptive activity names to name the activities
#######################################################################

### Load in the activity ID and activity names
label_activity<-read.table("./UCI HAR Dataset/activity_labels.txt")
label_activity

### Label the activity IDs with activity names
data$Activity<-factor(data$Activity, levels=label_activity[,1], labels=tolower(label_activity[,2]))
head(data$Activity)



#############################################################################
## Step 4: Appropriately labels the data set with descriptive variable names
#############################################################################
### Note: The current names (obtained from the features.txt) are quite descriptive with the abbreviations, 
###       so I just remove the "()" and change "-" and "," to "_".
### For more details on what does each of the abbreviation mean, please refer to README.

names(data)
names(data)<-sub("\\()", "", names(data))
names(data)<-gsub("-|,", "_", names(data))



#############################################################################
## Step 5: Create a tidy data set contains the average of each variable
##         for each activity and each subject.
#############################################################################

dim(data)
names(data)
meandata<-aggregate(data[,4:dim(data)[2]], by=data[,1:3], mean)

### Reshape the data into long format so that 
### the names of the 561 features are in one column named feature

library(reshape2)
tidydata<-melt(meandata, id.vars=c("Subject", "Group", "Activity"))
names(tidydata)[4:5]<-c("Feature", "Mean")
names(tidydata)
dim(tidydata)

### sort the data by feature, subject ID and activity, 
### and remove row names as they are not in order
tidydata<-tidydata[order(tidydata$Feature, tidydata$Subject, tidydata$Activity),]
rownames(tidydata)<-NULL
head(tidydata)
str(tidydata)



### Write the final tidy data into a txt file.
write.table(tidydata, "tidydata.txt")


