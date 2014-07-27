# Code Book

## Raw Data

The raw data set before cleaning can be downloaded at [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The description of the raw data set can be found at [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Operations done on the raw data set

+ Merge those 6 files into a single large data set
	
	> /train/X_train.txt
	> /train/y_train.txt
	> /train/subject_train.txt
	> /test/X_test.txt
	> /test/y_test.txt
	> /test/subject_test.txt

+ Filter the features, use only those measurements by taking mean and standard deviation from raw measurements

+ Use descriptive name to replace numbers for activities using the names in

	> /activity_labels.txt

+ Use descriptive names on features using the names in

	> /features.txt

+ Group the data set by activity and subject, then for each group, take the means of all features to generate a new tidy data set

## Output data set

A matrix with 180 rows and 81 variables, where

+ The first column is activities which fall into 6 categories which can be found in
	
	> /activity_labels.txt

+ The second column is subjects denoted by numbers

+ First 2 columns are ids to break raw observations into groups

+ Other columns are means of measurements taken on each group, named as in features.txt but with prefixes "mean-"