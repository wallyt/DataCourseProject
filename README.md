# Getting and Cleaning Data Course Project
### Wally Thornton
## What the analysis files do
The run_analysis.R script reads, cleans and reformats a data set of activity-tracking measurements, collected and made available by the University of California at Irvine. The data can be downloaded [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and a description of the data can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

run\_analysis.R contains two functions: run\_analysis(), which performs all of the reading, cleaning and shaping of the data; and ensurePkg(), which is a helper function to ensure the packages needed by run_analysis() are installed and loaded into R.

**Details and step-by-step explanations of the functions are in the [code book](https://github.com/wallyt/DataCourseProject/blob/master/Codebook.md).**

## Project Summary
Using the data sets provided, run_analysis.R:

1. Merges the training and test sets to create one data set
2. Extracts only the measurements that include mean and standard deviation
3. Applies descriptive activity names to the activities
4. Labels the data set with descriptive variable names
5. Creates and writes a tidy data set that shows the average (mean) of each variable for each activity

Before running, make sure to read the accompanying [code book](https://github.com/wallyt/DataCourseProject/blob/master/Codebook.md).

## Code Modifications
Note that the UCI HAR data set should be unzipped into the working directory where run_analysis.R is located and that line 29 should be changed to this working directory before running.