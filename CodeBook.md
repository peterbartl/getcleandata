CodeBook
========================================================

Download the data
----
A zip file containing the data was downloaded from the course page (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

Extract zip file
----
The zip file is extracted to a folder of choice

Folder structure
----
The parent folder (UCI HAR Dataset) contains four text files (README.txt, features_info.txt, features.txt, activity_labels.txt) and two subfolders (train, test) with more text files.

Set working directory (start of run_analysis.R)
-----
As a first step, the working directory in R has to be set to the parent folder (UCI HAR Dataset). The path is depending on where the zip file was extracted to on the hard drive.

Load all relevant files from working directory
-----
The following list of files is loaded into R with the read.table() function


* X_test.txt (data.frame with features in test set)
* y_test.txt (data.frame with activities in test set)
* subject_test.txt (data.frame with subject labels for test set)
* X_train.txt (data.frame with features in train set)
* y_train.txt (data.frame with activities in train set)
* subject_train.txt (data.frame with subject labels for train set)
* activity_labels.txt (data.frame with descriptive activity names)
* features.txt (data.frame with descriptive feature names)

Feature names
-----
The descriptive feature names are used to label the columns of the train and test data.

Activity names and labeling
-----
The descriptive activity names are used to replace the numberic activity designations and the activity column is named as 'activity' in the training and test data. 

Subject name
-----
The subject column is named as 'subject' in the training and test data.


Merge training and test sets
-----
The columns for activity, subject and features are combinded (cbind) for the train and test data separately.
Then the two data.frames are combined (rbind) to get one merged data set with all observations.


Find variable columns that describe mean or standard deviation variables
-----
Via regular expressions, a vector of column names is created containing all variables that describe a mean or standard deviation for a measurement.

Create subset
----
A subset of the merged data is created where the variable columns are reduced to the specified mean/std measurements. The columns for activity and subject remain in the new data set.

Reshape subset
-----
The new data set is reshaped into a tall data set with four columns. The id-variables 'activity' and 'subject' are columns one and two. All measurement variables and values are in columns three and four.

Calculate average of each variable for each activity and each subject
-----
The data.frame is split by 'activity','subject' and 'variable' to calculate the average of the corresponding values

Write result to file
-----
The tidy data.frame is saved with the write.table() function to a text file for submission.
