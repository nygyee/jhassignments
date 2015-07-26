library(dplyr)

#Read files
featureslist <- read.table("./data/UCI HAR Dataset/features.txt", sep = " ", header=FALSE)
activitylabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", sep = " ", header=FALSE)
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header=FALSE, colClasses="numeric")
x_test <- read.table("./data/UCI HAR Dataset/test/x_test.txt", header=FALSE, colClasses="numeric")
subj_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header=FALSE, colClasses="numeric")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header=FALSE, colClasses="numeric")
x_train <- read.table("./data/UCI HAR Dataset/train/x_train.txt", header=FALSE, colClasses="numeric")
subj_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header=FALSE, colClasses="numeric")

#Create descriptive names
names(activitylabels) <- c("activitylabelID","activity")
names(x_test) <- as.character(featureslist[,2])
names(y_test) <- "activitylabelID"
names(subj_test) <- "subjectID"
names(x_train) <- as.character(featureslist[,2])
names(y_train) <- "activitylabelID"
names(subj_train) <- "subjectID"

#Merge activity labels to IDs
y_test <- merge(y_test, activitylabels)
y_train <- merge(y_train, activitylabels)

#Remove unneeded columns (keep mean and std)
features_keep <- grep("mean\\(\\)|std\\(\\)",featureslist[,2])
x_test <- x_test[,c(features_keep)]
x_train <- x_train[,c(features_keep)]

#Merge parts of the sets together, creating one full test table and train table
set <- rep('test',nrow(x_test))
test_table <- cbind(subj_test, y_test, set, x_test)
set <- rep('train',nrow(x_train))
train_table <- cbind(subj_train, y_train, set, x_train)

#Merge train and test tables together ("set" column distinguishes the two)
main_table <- rbind(test_table, train_table)

#Create a second, independent data set with the average of each variable for each activity and each subject.
#Remove 2 columns that are not used here
temp_table <- main_table[,-c(2,4)]
#Set group by to be activity and subject
group_activity_subj <- group_by(temp_table, activity, subjectID)
#Generate table
second_table <- summarise_each(group_activity_subj, funs(mean))

#Write second table to file
write.table(second_table, file="./data/UCI HAR Dataset/second_table.txt", row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)