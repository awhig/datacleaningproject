## Load data from source files into dataframes
activity_labels <- read.csv("./getdata-projectfiles-UCI HAR Dataset/activity_labels.txt", header=FALSE, sep="", col.names=c("activity_id", "activity"))
features <- read.csv("./data/features.txt", header=FALSE, sep="", col.names=c("feature_id", "feature"),
                     stringsAsFactors=FALSE)

subject_train <- read.csv("./getdata-projectfiles-UCI HAR Dataset/train/subject_train.txt", header=FALSE, col.names=c("Subject"))
x_train <- read.csv("./getdata-projectfiles-UCI HAR Dataset/train/X_train.txt", header=FALSE, sep="")
y_train <- read.csv("./getdata-projectfiles-UCI HAR Dataset/train/y_train.txt", header=FALSE, col.names=c("activity_id"))

## combine data into one set
library(plyr)

train_activity <- join(y_train,activity_labels, by="activity_id", match="first")

all_train <- cbind(subject_train, train_activity, x_train)

subject_test <- read.csv("./getdata-projectfiles-UCI HAR Dataset/test/subject_test.txt", header=FALSE, col.names=c("Subject"))
x_test <- read.csv("./getdata-projectfiles-UCI HAR Dataset/test/X_test.txt", header=FALSE, sep="")
y_test <- read.csv("./getdata-projectfiles-UCI HAR Dataset/test/y_test.txt", header=FALSE, col.names=c("activity_id"))


test_activity <- join(y_test,activity_labels, by="activity_id", match="first")

all_test <- cbind(subject_test, test_activity, x_test)

## combined set created
all_data <- rbind(all_train, all_test)

## add column names to the set
colnames(all_data) <- c(c("Subject", "a_id", "Activity"), features[[2]])

colnames <- colnames(all_data)

## extract only columns that describe the mean or standard deviation of the measurements
wantedcolnames <- (colnames[(grepl("mean()",colnames)
                             != grepl("meanFreq()", colnames)
                       | grepl("std()",colnames)
                       
                       | grepl("Subject",colnames)
                       
                       | grepl("Activity",colnames)) == TRUE])

meansandstds <- all_data[,wantedcolnames]

## create final data set with the average of each variable for each activity and each subject.
library(dplyr)

grouped <- group_by(meansandstds, Subject, Activity)

by_sub_act <- grouped %>% summarise_each(funs(mean))

write.table(by_sub_act, file="output.txt", row.names=FALSE)
