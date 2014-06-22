# run_analysis.R 

# set working directory to parent folder of extracted data
setwd('E:/getcleandata/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset')


# Assuming the working directory is set to the top level (e.g.'C:/UCI HAR Dataset')  with with subfolders 'test' and 'train' 
# Load all relevant files
x_test<-read.table('./test/X_test.txt')
y_test<-read.table('./test/y_test.txt')
subject_test<-read.table('./test/subject_test.txt')
x_train<-read.table('./train/X_train.txt')
y_train<-read.table('./train/y_train.txt')
subject_train<-read.table('./train/subject_train.txt')
activity.labels<-read.table('activity_labels.txt')
feature.labels<-read.table('features.txt')


# label features
names(x_train)<-names(x_test)<-feature.labels$V2


# name and label activities
library(plyr)
y_test$V1 <- join(y_test, activity.labels, by = "V1")[,2]
y_train$V1 <- join(y_train, activity.labels, by = "V1")[,2]
names(y_test)<-names(y_train)<-'activity'


# name subjects column
names(subject_test)<-names(subject_train)<-'subject'


# merge training and test sets

training<-cbind(y_train,subject_train,x_train)
testing<-cbind(y_test,subject_test,x_test)
all.data<-rbind(training,testing)


# find variable columns that describe mean or standard deviation variables
vars.mean.std<-names(all.data)[(grep('-mean\\()|std()',names(all.data)))]


# make subset of all.data with activity , subject, and mean/std variables
subset<-c('activity','subject',vars.mean.std)
data.mean.std<-all.data[,subset]

# make tidy data set with average of each variable for each activity and each subject
library(reshape2)
foo<-melt(data.mean.std,id=c('activity','subject'),measure.vars=vars.mean.std)
tidy.data <- ddply(foo, c('activity','subject','variable'), summarise,
                mean = mean(value))


# write tidy data to working directory for upload in browser.
write.table(tidy.data,file='tidy.data.txt')

