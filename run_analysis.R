#################################################################################

## Coursera Getting and Cleaning Data Course Project
## Wally Thornton
## August 24, 2014

# The run_analysis function reads, cleans and reformats activity tracking
# data collected and made available by the University of California at
# Irvine. See README.md file for an overview and Codebook.md for details
# on reading and running run_analysis.R.

#################################################################################

# ensurePkg tests whether the packages that run_analysis uses are installed
# and, if not, installs them.

ensurePkg <- function(x) {
    if (!require(x,character.only = TRUE)) {
        install.packages(x,dep=TRUE, repos="http://cran.r-project.org")
        if(!require(x,character.only = TRUE)) stop("Package not found")
    }
}
ensurePkg("plyr")
ensurePkg("reshape2")
rm(ensurePkg) # keep workspace clean

run_analysis <- function() {
    # Set working directory
    setwd("/users/wallythornton/datasciencecoursera/Getting_and_Cleaning_Data/Data_Course_Project/")
    
    # Read in all needed files
    x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
    y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
    subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
    x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
    y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
    x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
    subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
    features <- read.table("./UCI HAR Dataset/features.txt")
    
    # Combine the two groups and add features as column names
    total_x <- rbind(x_test, x_train)
    total_y <- rbind(y_test, y_train)
    colnames(total_x) <- as.vector(features[[2]])
    
    # Find and extract to a new table the columns that measure mean and std
    filtered_data <- total_x[, grep("[Mm]ean|[Ss][Tt][Dd]", names(total_x))]
    
    # Clean up the column names for readability and consistency
    names(filtered_data) <- gsub("\\()", "", names(filtered_data))
    names(filtered_data) <- gsub("-mean", "Mean", names(filtered_data))
    names(filtered_data) <- gsub("-std", "StdDev", names(filtered_data))
    names(filtered_data) <- gsub("([Bb]ody)\\1+", "Body", names(filtered_data))
    names(filtered_data) <- gsub("^f", "frequency", names(filtered_data))
    names(filtered_data) <- gsub("^t", "time", names(filtered_data))
    names(filtered_data) <- gsub("[Aa]cc", "Accel", names(filtered_data))
    names(filtered_data) <- gsub("\\(t", "(time", names(filtered_data))
    names(filtered_data) <- gsub("", "", names(filtered_data))
    
    # Join total_y and activity_labels to convert from activity codes to
    # activity names using join() from the plyr package
    total_y <- join(total_y, activity_labels, by = "V1")
    
    # Delete now-unused activity code column, rename and add to filtered_data
    total_y[ ,1] <- NULL
    colnames(total_y)[1] <- "Activity"
    combined_set <- cbind(total_y, filtered_data)
    
    # Combine subject groups, rename the column and add to combined_set, creating final_set
    total_subjects <- rbind(subject_test, subject_train)
    colnames(total_subjects)[1] <- "Test_Subject"
    final_set <- cbind(total_subjects, combined_set)
    
    # Melt final_set and recast using melt() and dcast() from the reshape2 package
    # This reshape also calculates the mean for each of the measurements for each
    # combination of test subject and activity
    set_melt <- melt(final_set, id = c("Test_Subject", "Activity"), measure.vars = colnames(final_set[,-1:-2]))
    set_cast <- dcast(set_melt, Test_Subject + Activity ~ variable, mean)
    
    # Write out the recasted data set
    write.table(set_cast, file = "./set_cast.txt", row.names=FALSE)
}