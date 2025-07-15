##PREPARATION TO READ THE FILE
#Loading required packages
library(dplyr)

#Download the dataset
filename <- "getdata_projectfiles_UCI HAR Dataset"

# Checking if archive already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

#Read metadata and assigning all data frames from .zip

#MERGE THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET.
#STEP 1: Read Supporting Metadata:'activity_labels.txt': Links the class labels with their activity name and 'features.txt': List of all features.
 
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

#The file 'UCI HAR Dataset' has two folders: test and train
#STEP 2. Read test data that contains 'test/X_test.txt': Test set, 'test/y_test.txt': Test labels, and subject_test.
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)

#STEP 3. Read training data hat contains 'train/X_train.txt': Training set, 'train/y_train.txt': Training labels and subject_train.
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)

#PART 1 - MERGE THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET
subject <- rbind(subject_test, subject_train) #all subjects together
y <- rbind(y_test, y_train) #all y
x <- rbind(x_test, x_train) #all x

merged_data <- cbind(subject, y, x) #Total dataset

dim(merged_data)
# 10299   563
print(merged_data)

#PART 2 - EXTRACTS ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT
columnsmeanandSTD  <- merged_data %>% select(subject, code, contains("mean"), contains("std"))

#PART 3 - USES DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET
columnsmeanandSTD$code <- activities[columnsmeanandSTD$code, 2]

#STEP 4 - APPROPRIATELY LABELS THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES.
names(columnsmeanandSTD)[2] = "activity"
names(columnsmeanandSTD)<-gsub("Acc", "Accelerometer", names(columnsmeanandSTD))
names(columnsmeanandSTD)<-gsub("Gyro", "Gyroscope", names(columnsmeanandSTD))
names(columnsmeanandSTD)<-gsub("BodyBody", "Body", names(columnsmeanandSTD))
names(columnsmeanandSTD)<-gsub("Mag", "Magnitude", names(columnsmeanandSTD))
names(columnsmeanandSTD)<-gsub("^t", "Time", names(columnsmeanandSTD))
names(columnsmeanandSTD)<-gsub("^f", "Frequency", names(columnsmeanandSTD))
names(columnsmeanandSTD)<-gsub("tBody", "TimeBody", names(columnsmeanandSTD))
names(columnsmeanandSTD)<-gsub("-mean()", "Mean", names(columnsmeanandSTD), ignore.case = TRUE)
names(columnsmeanandSTD)<-gsub("-std()", "STD", names(columnsmeanandSTD), ignore.case = TRUE)
names(columnsmeanandSTD)<-gsub("-freq()", "Frequency", names(columnsmeanandSTD), ignore.case = TRUE)
names(columnsmeanandSTD)<-gsub("angle", "Angle", names(columnsmeanandSTD))
names(columnsmeanandSTD)<-gsub("gravity", "Gravity", names(columnsmeanandSTD))

names(columnsmeanandSTD)

#STEP 5 - FROM THE DATA SET IN STEP 4, CREATES A SECOND, INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT.
tidydata <- columnsmeanandSTD %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(tidydata, "tidydata.txt", row.name=FALSE)
