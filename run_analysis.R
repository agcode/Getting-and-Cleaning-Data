# Getting and Cleaning Data Course Project (September 2015)
# Data for the project : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

library(dplyr)

# List of files
X_train <- "UCI HAR Dataset/train/X_train.txt" # Training set
y_train <- "UCI HAR Dataset/train/y_train.txt" # Training labels 
subject_train <- "UCI HAR Dataset/train/subject_train.txt" # 1-30 subjects who performed the activity
X_test <- "UCI HAR Dataset/test/X_test.txt" # Test set
y_test <- "UCI HAR Dataset/test/y_test.txt" # Test labels
subject_test <- "UCI HAR Dataset/test/subject_test.txt" #subjects who performed the activity
activity_labels <- "UCI HAR Dataset/activity_labels.txt" # Links the class labels with their activity name
features <- "UCI HAR Dataset/features.txt" # List of all features (561 variable names)

#Reading the files into tables
X_train_t <- read.table(X_train)
y_train_t <- read.table(y_train)
subject_train_t <- read.table(subject_train)
X_test_t <- read.table(X_test)
y_test_t <- read.table(y_test)
subject_test_t <- read.table(subject_test)
activity_labels_t <- read.table(activity_labels)
features_t <- read.table(features)
# Assign names
names(X_test_t)<-features_t[,2]
names(subject_test_t)<-"subject"
names(y_test_t)<-"activity"
names(X_train_t)<-features_t[,2]
names(subject_train_t)<-"subject"
names(y_train_t)<-"activity"
# create data frame 

# 1 Merging the training and the test sets to create one data set
data_set <- data.frame(subject = bind_rows(subject_train_t,subject_test_t), activity = bind_rows(y_train_t,y_test_t),bind_rows(X_train_t,X_test_t))

# 2 Extracts only the measurements on the mean and standard deviation for each measurement
extract <- data_set %>% select(subject,activity,contains("mean"),contains("std"))
# 3 Uses descriptive activity names to name the activities in the data set
extract<-mutate(extract,activity=activity_labels_t[[2]][activity])
# 4 Appropriately labels the data set with descriptive variable names. 
# This is already done in line 25. The measurements of mean and sd are extracted after this.
# 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
grouped<-group_by(extract,activity,subject)
#Source: local data frame [10,299 x 88]
#Groups: activity, subject [180]
summarized<-summarise_each(grouped,funs(mean))
# Write tidy data set created in step 5 to text file
write.table(summarized,"dataset.txt",row.names=FALSE)
# Generates 180 observations of 88 variables
