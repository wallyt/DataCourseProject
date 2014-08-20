# Explain what's about to happen

run_analysis <- function() {
    # Read everything in
    x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
    y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
    x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
    y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
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
    
    # Melt final_set and recast
    set_melt <- melt(final_set, id = "Activity", measure.vars = colnames(final_set[,-1]))
    set_cast <- dcast(set_melt, Activity ~ variable,mean)
    
    # Write out the recasted data set
    write.table(set_cast, file = "./set_cast.txt", row.names=FALSE)
}