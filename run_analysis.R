# Get the data from the source

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./HAR.zip",method = "auto")
unzip(zipfile = "./HAR.zip")

# Read the data from original files

data_path <- file.path("./UCI HAR Dataset")

ActivityTest <- read.table(file.path(data_path,"test","Y_test.txt"),header = FALSE)
SubjectTest <- read.table(file.path(data_path,"test","subject_test.txt"),header = FALSE)
FeatureTest <- read.table(file.path(data_path,"test","X_test.txt"),header = FALSE)

ActivityTrain <- read.table(file.path(data_path,"train","Y_train.txt"),header = FALSE)
SubjectTrain <- read.table(file.path(data_path,"train","subject_train.txt"),header = FALSE)
FeatureTrain <- read.table(file.path(data_path,"train","X_train.txt"),header = FALSE)

# Combine the data of Test and Train, then define the header

Subject <- rbind(SubjectTest,SubjectTrain)
Activity <- rbind(ActivityTest,ActivityTrain)
Feature <- rbind(FeatureTest,FeatureTrain)

names(Subject) <- c("subject")
names(Activity) <- c("activity")
FeatureNames <- read.table(file.path(data_path,"features.txt"),head = FALSE)
names(Feature) <- FeatureNames$V2

# Combine three tables into one big table

dataset <- cbind(Subject,Activity,Feature)

# Extract only mean and std

Extract <- grep("mean\\(\\)|std\\(\\)", FeatureNames$V2)
ExtractNames <- as.character(FeatureNames$V2[Extract])
dataset <- subset(dataset, select=c("subject","activity",ExtractNames))

# Description for the activity

ActivityNames <- read.table(file.path(data_path,"activity_labels.txt"),header = FALSE)
dataset$activity <- factor(dataset$activity,labels = as.character(ActivityNames$V2))

# Description for the Measures

names(dataset) <- gsub("^t","time-",names(dataset))
names(dataset) <- gsub("^f","frequency-",names(dataset))
names(dataset) <- gsub("Acc","Accelerometer",names(dataset))
names(dataset) <- gsub("Mag","Magnitude",names(dataset))
names(dataset) <- gsub("Gyro","Gyroscope",names(dataset))
names(dataset) <- gsub("BodyBody","Body",names(dataset))
names(dataset) <- gsub("\\(\\)","",names(dataset))

# Output the above new dataset

Output <- aggregate(. ~subject + activity, dataset, mean)
Output <- Output[order(Output$subject, Output$activity),]
write.table(Output, file="MeanHAR_UsingSmartphone.txt", row.names = FALSE)

