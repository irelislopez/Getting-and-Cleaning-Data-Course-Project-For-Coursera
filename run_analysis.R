#PREPARATION TO READ THE FILE
#Loading required packages
library(dplyr)

#MERGE THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET.
#Step 1: Read Supporting Metadata:'activity_labels.txt': Links the class labels with their activity name and 'features.txt': List of all features.
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
features_labels <- read.table("UCI HAR Dataset/features.txt")

#The file 'UCI HAR Dataset' has two folders: test and train
#Step 2. Read test data that contains 'test/X_test.txt': Test set, 'test/y_test.txt': Test labels, and subject_test.
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)

#Step 3. Read training data hat contains 'train/X_train.txt': Training set, 'train/y_train.txt': Training labels and subject_train.
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

#PART 1 - MERGE THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET
#Step 1: rbind subjects, then sets and then labels
subject <- rbind(subject_test, subject_train) #all subjects together
y <- rbind(y_test, y_train) #all y
x <- rbind(x_test, x_train) #all x

#Step 2: name the columns
# Naming columns
colnames(x) <- features_labels[, 2]
colnames(subject) <- "Subject"
colnames(y) <- "Activity"

#Step 3: creating full dataset
ucidataset <- cbind(y,x,subject) 

#PART 2 - EXTRACTS ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT
dataMSD <- grep("mean\\(\\)|std\\(\\)", names(ucidataset))
requesteddata <- c(1, 2, dataMSD)
data_subset <- ucidataset[, requesteddata]

#PART 3 - USES DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET
#Replace activity codes with names
data_subset$Activity <- factor(data_subset$Activity, 
                               levels = activity_labels[, 1], 
                               labels = activity_labels[, 2])

#STEP 4 - APPROPRIATELY LABELS THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES.
#Clean up column names to be more descriptive
names(data_subset) <- gsub("^t", "Time", names(data_subset))
names(data_subset) <- gsub("^f", "Frequency", names(data_subset))
names(data_subset) <- gsub("Acc", "Accelerometer", names(data_subset))
names(data_subset) <- gsub("Gyro", "Gyroscope", names(data_subset))
names(data_subset) <- gsub("Mag", "Magnitude", names(data_subset))
names(data_subset) <- gsub("BodyBody", "Body", names(data_subset))
names(data_subset) <- gsub("-mean\\(\\)", "Mean", names(data_subset), ignore.case = TRUE)
names(data_subset) <- gsub("-std\\(\\)", "STD", names(data_subset), ignore.case = TRUE)
names(data_subset) <- gsub("-freq\\(\\)", "Frequency", names(data_subset), ignore.case = TRUE)
names(data_subset) <- gsub("angle", "Angle", names(data_subset))
names(data_subset) <- gsub("gravity", "Gravity", names(data_subset))

#STEP 5 - FROM THE DATA SET IN STEP 4, CREATES A SECOND, INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT.
#Step 1: fixed columns names 
colnames(data_subset) #Activity and Subject mislabeled 
colnames(data_subset)[1] <- "Subject" 
colnames(data_subset)[2] <- "Activity"
colnames(data_subset) #everything is correct now

#Step2: Create tidy dataset with the average of each variable for each activity and subject
FinalData <- data_subset %>%
  group_by(Subject, Activity) %>%
  summarise_all(mean)
#Step 3: Create "TidyData.txt"
write.table(FinalData, "TidyData.txt", row.names = FALSE)
#Check if everything is ok
str(FinalData)