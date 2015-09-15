# Getting-and-Cleaning-Data
The Project for Getting and Cleaning Data

Data is sourced from : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Description of the data :

Number of subjects : 30 volunteers

Activities : WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

A 561-feature vector (561 variables) : Using the embedded accelerometer and gyroscope of the Samsung Galaxy S II, they captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

## Objective :
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Analysis Script File :
run_analysis.R

The file is to be run in the same directory in which the data has been unzipped.

## What the script does :
- The script reads *X_train,y_train & subject_train* from the train folder and *X_test, y_test & subject_test* from the test folder into separate tables. 
- The script reads *activity_labels and features* from the *UCI HAR Dataset* folder into separate tables . This is used to give meaningful names to the numbers in *y_test* , *y_train* and meaningful variable names (coloumn headers) to the data in *X_train* & *X_test*.
- Names are assigned to the coloumn headers of the *X_train* & *X_test* from *features*. Fixed names *subject* and *activity* are assigned to y and subject.
- A data frame is created using bind_rows on the corresponding train and test tables within the data.frame command. If check.names=FALSE is used truncation of the variable names can be avoided.
- Only the measurements of mean and standard deviation are extracted from the 561 variables using contains("mean") and contains("std") within the select command. We are left with 88 variables, including subject and activity. At this point the coloumns get rearranged(The mean coloumns come first followed by the standard deviation coloumns)
- Replace the numbers in the activity coloumn with meaningful names
- The data set is now grouped by activity and subject [180 rows]
- Use summarise_each to find mean of each variable for each activity and each subject.
- Use write.table with row.names=FALSE to output the data into a text file
- Generates 180 observations of 88 variables
