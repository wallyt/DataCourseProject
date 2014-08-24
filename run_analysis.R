####################################################################################

## Coursera Getting and Cleaning Data Course Project
## Wally Thornton
## August 24, 2014

# The run_analysis function reads, cleans and reformats activity tracking
# data collected and made available by the University of California at
# Irvine. See README.md file for an overview and Codebook.md for details
# on reading and running run_analysis.

####################################################################################

run_analysis <- function() {
    # Set working directory
    setwd("/users/wallythornton/datasciencecoursera/Getting_and_Cleaning_Data/")
    
    # Read everything in
    x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
    y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
    subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
    x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
    y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
    x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
    subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
    features <- read.table("./UCI HAR Dataset/features.txt")
    
    # Combine the two groups and add features as column headers
    total_x <- rbind(x_test, x_train)
    total_y <- rbind(y_test, y_train)
    colnames(total_x) <- as.vector(features[[2]])
    
    # Find and extract the columns that measure mean and std
    filtered_data <- total_x[, grep("[Mm]ean|[Ss][Tt][Dd]", names(total_x))]
    
    # Load plyr and join total_y with activity_labels to convert from
    # activity codes to activity names
    library(plyr)
    total_y <- join(total_y, activity_labels, by = "V1")
    
    # Delete now-unused activity code column, rename and add to filtered_list
    total_y[ ,1] <- NULL
    colnames(total_y)[1] <- "Activity"
    final_set <- cbind(total_y, filtered_data)
    
    # Combine subject groups, rename and add to final_set
    total_subjects <- rbind(subject_test, subject_train)
    colnames(total_subjects)[1] <- "Test_Subject"
    final_set <- cbind(total_subjects, final_set)
    
    # Melt final_set and recast
    library(reshape2)
    set_melt <- melt(final_set, id = c("Test_Subject", "Activity"), measure.vars = colnames(final_set[,-1:-2]))
    set_cast <- dcast(set_melt, Test_Subject + Activity ~ variable, mean)
    
    # Write out the recasted data set
    write.table(set_cast, file = "./set_cast.txt", row.names=FALSE)
}