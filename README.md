# Data Source
The run_analysis.R function reads, cleans and reformats a data set of activity tracking measurements, collected and made available by the University of California at Irvine. The data can be found at
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

and a description of the data can be found at
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Function Overview
Using the data sets provided, run_analysis.R:
1. Merges the training and test sets to create one data set
2. Extracts only the measurements that include mean and standard deviation
3. Applies descriptive activity names to the activities
4. Labels the data set with descriptive variable names
5. Creates and writes a tidy data set that shows the average (mean) of each variable for each activity

