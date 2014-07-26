# If the data diretory not exist, download it, unzip it and delete the zip file.
data_dir <- "UCI HAR Dataset"
if (file.exists(data_dir)) {
        url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        zip_file <- "data.zip"
        download.file(url, destfile = zip_file, method = "curl")
        unzip(zip_file)
        file.remove(zip_file)
}

