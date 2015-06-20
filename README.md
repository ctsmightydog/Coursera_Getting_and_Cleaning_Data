# Coursera Getting and Cleaning Data

##Introduction
This repository is for a programming assignment for the Coursera course "Getting and Cleaning data" which looks at data collected from the accelerometers from the Samsung Galaxy S smartphone. 
This repository contains this readme.file, the R script for the analysis, and a codebook (markdown file). The goal of the script is to prepare a tidy data set from the Samsung data that can be used for later analysis.

##Background of the data
The full background of the data can be found at this website:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

##Goal of assignment
To create one R script called run_analysis.R that does the following.
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive activity names.
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##How to use the script
* Download the data from the following source and unzip the data into a folder on your local drive. 
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
* You'll have a folder called UCI HAR Dataset folder.
* Copy the run_analysis.R file into the UCI HAR Dataset folder
* Set this as your working directory using setwd() function in RStudio.
* Run source("run_analysis.R")
  *The script will write a text file (Tidydata.txt) in your working directory with the summary results.

###About the Code Book
The CodeBook.md file explains explanations of the data, the transformations of the data and how to run the R script.
