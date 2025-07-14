# Instructions for Getting-and-Cleaning-Data-Course-Project-For-Coursera
## Grading criteria overview
1. The submitted data set is tidy. 
2. The Github repo contains the required scripts.
3. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
4. The README that explains the analysis files is clear and understandable.
5. The work submitted for this project is the work of the student who submitted it.

## Getting-and-Cleaning-Data-Course-Project-For-Coursera  <br /> 
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example 
this article. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
 
Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  
You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# My Submission for Peer-graded Assignment: Getting and Cleaning Data Course Project  <br /> 
##Files in this Repository
1. run_analysis.R: This R script performs the following steps:

a. Merges the training and test sets to create one data set.
b. Extracts only the measurements on the mean and standard deviation for each measurement.
c. Uses descriptive activity names to name the activities in the data set.
d. Appropriately labels the data set with descriptive variable names.
e. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

2. CodeBook.md: This file describes the variables, the data, and any transformations or work that was performed to clean up the data.

3. tidy_data.txt: This file contains the final tidy data set with the average of each variable for each activity and each subject.

##How to Run the Script
To run the analysis, follow these steps:

1. Download the Data: If you haven't already, download the data from the following link: Data for the project. Extract the contents of the zip file to your working directory.

2. Run the Script: Open R or RStudio and run the run_analysis.R script. This script will read the data, perform the necessary transformations, and generate the tidy_data.txt file with the tidy data set.

## About the Data
The data used in this project were collected from the accelerometers of the Samsung Galaxy S smartphone. A full description of the data is available at the following link: Human Activity Recognition Using Smartphones.

## Code Book
For details about the variables, data, and transformations used in this analysis, please refer to the CodeBook.md file in this repository.

