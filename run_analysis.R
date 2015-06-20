#You should create one R script called run_analysis.R that does the following. 
#1.Merges the training and the test sets to create one data set.
#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
#3.Uses descriptive activity names to name the activities in the data set
#4.Appropriately labels the data set with descriptive variable names. 
#5.From the data set in step 4, creates a second, independent tidy data set with the 
#average of each variable for each activity and each subject.
#---------------------------------------------------------------------------

#First this script needs to install and load the dplyr and reshape2 libraries:
if (!require("dplyr")) {
  install.packages("dplyr")}
library(dplyr)

if (!require("reshape2")) {
  install.packages("reshape2")}
library(reshape2)

#1.Merges the training and the test sets to create one data set
#1a. read in all the training data information and add labels and columns:

#read in training data:
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", colClasses = "numeric")
#read in column labels:
features <- read.table("./UCI HAR Dataset/features.txt", colClasses = "character")[,2]
#replace default column names with names in features.txt:
names(X_train)=features

#read in the labels for the actual activity (values from 1 to 6) and rename the column:
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
names(y_train)="Activity.Number"

#read in the subjects number (ie, the volunteer people)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
#rename the column to a more descriptive name
names(subject_train)="Subject"

#column bind the subject name and activity number with the data:
All_train_data<-cbind(subject_train, y_train, X_train)
#--------------------------

#1b. read in all the test data information and add labels and columns:
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", colClasses = "numeric")
#replace default column names with names in features.txt:
names(X_test)=features

#read in the labels for the actual activity (values from 1 to 6) and rename the column:
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
names(y_test)="Activity.Number"

#read in the subjects number (ie, the volunteer people)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
#rename the column to a more descriptive name
names(subject_test)="Subject"

#column bind the subject name and activity number with the data:
All_test_data<-cbind(subject_test, y_test, X_test)

#1c. Merge together the training and test data tables
Mergeddata<-rbind(All_train_data,All_test_data)
#---------------------------------------------------------------------------

#2.Extracts only the measurements on the mean and standard deviation for each measurement: 
#Make a subset of the merged data with only the columns of interest
#note, using "\\ with grep will mean we will only collect mean() and std(), vs collecting anything 
#that states mean in the column name, such as Angle measurements.
data_of_interest<-Mergeddata[,grep("Subject|Activity|mean\\(\\)|std\\(\\)",names(Mergeddata))]

#---------------------------------------------------------------------------
#3.Uses descriptive activity names to name the activities in the data set
#rename the activity number using descriptive activity names which are listed in the activity_lables.txt file
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", colClasses = "character")
names(activity_labels)=c("Activity.Number", "Activity")

oldvalues<-activity_labels$Activity.Number
newvalues<-activity_labels$Activity

data_of_interest$Activity.Number<-newvalues[match(data_of_interest$Activity.Number,oldvalues)]

#now rename Activity.Number column to Activity, since we are using Character Names, not activity number
data_of_interest<-rename(data_of_interest, Activity = Activity.Number)

#---------------------------------------------------------------------------
#4.Appropriately labels the data set with descriptive variable names.
names(data_of_interest)<-gsub("\\(\\)","", names(data_of_interest))
names(data_of_interest)<-gsub("-","", names(data_of_interest))
names(data_of_interest)<-gsub("mean","Mean", names(data_of_interest))
names(data_of_interest)<-gsub("std","Std", names(data_of_interest))

#---------------------------------------------------------------------------
#5.From the data set in step 4, creates a second, independent tidy data set with the 
#average of each variable for each activity and each subject
melted <- melt(data_of_interest, id=c("Subject","Activity"))
tidydata <- dcast(melted, Activity+Subject ~ variable, mean)

write.table(tidydata, "./UCI HAR Dataset/Tidydata.txt", row.name=FALSE)
