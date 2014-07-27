# If the data diretory not exist, download it, unzip it and delete the zip file.
data_dir <- "UCI HAR Dataset"
if (!file.exists(data_dir)) {
        url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        zip_file <- "data.zip"
        download.file(url, destfile = zip_file, method = "curl")
        unzip(zip_file)
        file.remove(zip_file)
}

# Set the directory to the data directory
setwd(data_dir)

# The data without labels and subjects for training and testing respectively
raw_train_x <- read.table("train/X_train.txt")
raw_test_x <- read.table("test/X_test.txt")

# Combining training set and test set
raw_x <- rbind(raw_train_x, raw_test_x)

# Name of all features
feature_names <- as.character(read.table("features.txt")[,2])

# Name the features in data set
names(raw_x) <- feature_names

# Function to determine if the feature should remain
useful <- function(x) {
        grepl("mean()", x) | grepl("std()", x)
}

# Filter out the useful features
feature_useful <- apply(as.matrix(feature_names), MARGIN = 2, FUN = useful)
feature_indices <- which(feature_useful)
data_x <- raw_x[,feature_indices]

# Read the activity labels and combine those in training set and test set
raw_train_y <- read.table("train/y_train.txt")
raw_test_y <- read.table("test/y_test.txt")
raw_y <- rbind(raw_train_y, raw_test_y)

# Read the activity names
activity_names <- as.character(read.table("activity_labels.txt")[,2])

# Name the activities
data_y <- data.frame(apply(as.matrix(raw_y), MARGIN = 2, FUN = function(x) {activity_names[x]}))

# Name the variable "activitiy"
names(data_y) <- "activity"

# Read the subject numbers
raw_train_s <- read.table("train/subject_train.txt")
raw_test_s <- read.table("test/subject_test.txt")

# Combine the subjects in training set and test set and cast to a data frame
raw_s <- rbind(raw_train_s, raw_test_s)
data_s <- data.frame(raw_s)

# Name the variable "subject"
names(data_s) <- "subject"

# Combine all the variables
data <- cbind(data_x, data_y, data_s)

# Aggregate the tidy data set
tidy <- aggregate(data[,1:79], by = list(data$activity, data$subject), FUN = mean)

# Name the first 2 columns as what they mean
names(tidy)[1:2] <- c("activity", "subject")

# Name all other columns to add mean- in front of them
names(tidy)[3:81] <- as.vector(apply(as.matrix(names(tidy)[3:81]), MARGIN = 2, FUN = function(x) {paste0("mean-", x)}))

# Save the tidy data set
write.table(tidy, file = "../tidy.txt")