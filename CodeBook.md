###Code Book

##Background:
This code book describes the variables, the data, and transformations that were performed to clean up the data for a Coursera Project for "getting and Cleaning data".

##Information about the Experiment and Data Set:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on their waist. 
Using the phones embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity measurements were collected at a constant rate of 50Hz. 
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). 
The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. 
The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. 
From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

A full description of the experiment is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
* Reference: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 
21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.

##Structure of Data present in source data(zip) folders
* README.txt: Details of all the files in downloaded folder
* features_info.txt: Shows information about the variables used on the feature vector.
* features.txt: List of all features.i.e list of all measurement labels.
* activity_labels.txt: Lists the activity Id with their corresponding activity name.
* train/X_train.txt: Training data set.
* train/y_train.txt: Training activity Id Labels
* train/subject_train.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
* test/X_test.txt: Test data set.
* test/y_test.txt: Test activity Id Labels
* test/subject_train.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
The following files are available for the train and test data. Their descriptions are equivalent. 
- train/Inertial Signals/total_acc_x_train.txt: The acceleration signal from the smartphone accelerometer X axis in standard gravity units g. 
Every row shows a 128 element vector. The same description applies for the total_acc_x_train.txt and total_acc_z_train.txt files for the Y and Z axis. - train/Inertial Signals/body_acc_x_train.txt: The body acceleration signal obtained by subtracting the gravity from 
the total acceleration. - train/Inertial Signals/body_gyro_x_train.txt: The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.
* Note: All the files in train/Inertial Signals and test/Inertial Signals will not be used for in this analysis

##Information about the files to be used in analysis from Source Data
###These two files are used for both the training and test groups:
* features.txt: 561 rows of 2 varibles (feature Identifier and feature Name) 
* activity_labels.txt: 6 rows of 2 variables (activity identifier and activity name)

###Training data set:
* X_train.txt: 7352 rows of 561 measurement variables. These are the actual measurement variables listed in features.txt
* y_train.txt: 7352 rows of 1 variable. This is the activity identifier
* subject_train.txt: 7352 rows of 1 variable. This is the person (subject) identifier.

###Test Data set:
* X_Test.txt: 2947 rows of 561 measurement variables. These are the actual measurement variables listed in features.txt 
* y_test.txt: 2947 rows of 1 variables. This is the activity Identifier
* subject_test.txt: 2497 rows of 1 variable (subject Identifier)


##Map of aggregated Data
| Subject           | ActivityId  | data(variable names from features.txt) |
|-------------------|-------------|----------------------------------------|
| subject_train.txt | y_train.txt | X_testTest.txt                         |
| subject_test.txt  | y_test.txt  | X_train                                |


##Requirements of the run_analysis.R script
run_analysis.R script has the following requirements to perform transformation on UCI HAR Dataset.
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Transformations performed on the original data set:
1. Merging of training and test data sets to combine one large data frame:
1a. Reads and formats the training data set to one form training data frame by the following steps:
* reads in the training data information and add replaces default column names with names in features.txt
* reads in the labels for the activity ID (values from 1 to 6) and renames the column (Activity.Number)
* reads in the subjects number and renames the column to a more descriptive name (Subject)

1b. Reads and formats the test data set to form another data frame (test) data frame:
* reads in the test data information and add replaces default column names with names in features.txt
* reads in the labels for the activity ID (values from 1 to 6) and renames the column (Activity.Number)
* reads in the subjects number and renames the column to a more descriptive name (Subject)

* Merges the training and test data frames together to make one large data frame of 10299 rows x 561 columns.

2. Extracted only the data of interest (means and standard deviations of measurements) using a grep command that 
only collect mean() and std(), vs collecting anything that states mean in the column name, such as meanFreq()-X measurements 
or angle measurements where the term mean exists. This resulted in a data frame of 10299 rows by 68 columns.

3. Labelled the activities with actual names (like WALKING, etc) by matching the activity_labels with the activity number.

4. Renamed the variable columns with more descriptive names by removing dashes and parenthesis, ex:
tBodyAcc-Mean()-X becomes tBodyAccMeanX	(Average of Mean Value time doman Body Accelration in x direction)
tBodyAcc-Std()-X becomes tBodyAccStdX	Average of Standard deviation time doman Body Accelration in x direction
This format is the same for all 66 variables and the detailed description of each variable can be found in the original data set link above.

5. Created a new tidy data set with the average of each variable for each activity and subject.
This data frame has 180 observations/rows and 68 columns/variables
68 columns(1 column for Activity and one column for Subject and 66 columns for measurement variables)

##Tidy Data File
The Tidy data frame is written to a file using write.table function to create a 
Tidydata.txt file that puts this file in the users working directory.
