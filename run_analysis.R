# Reading data

activity_label <- read.table("activity_labels.txt")

features <- read.table("features.txt")


subject_test <- read.table("test/subject_test.txt")
# Reading data from y_test file into R, which contains labels of activities
y_test <- read.table("test/y_test.txt")
x_test <- read.table("test/x_test.txt", fill=TRUE, header=FALSE)

# Merging test sets(y_test and x_test as well as subject labels) to create one dataset
test_dataset <- cbind(x_test, subject_test,  y_test )

# Reading data representing training sets
subject_train <- read.table("train/subject_train.txt")
x_train <- read.table("train/X_train.txt",fill=TRUE, header=FALSE)
y_train <- read.table("train/y_train.txt")

#  Merging training sets to create one dataset
train_dataset <- cbind(x_train, subject_train,  y_train )

# Merging the test set and training set to create one data set
mergedDataset <- rbind(test_dataset,train_dataset)


# Searching features file for indices of mean and std measurements of all measurements
std_mean_index <- grep("std\\(\\)|mean\\(\\)", features[,2])

# Extracting mean and std measurements and saving them to a new data frame 
# in addition to columns of activity labels as well as subject labels

newData <- mergedDataset[,c(std_mean_index, 562,563)]

# Step 3
# column 68 includes activity labels(y_train and y_test values )

groups <-as.factor(newData[,68])
value <- as.character(activity_label[,2])
levels(groups) <- value

# Replacing the last column with activity labels as factors
newData<- cbind(newData[,1:67],groups)


# Step 4 : Adding descriptive variable names


col_names <- c(as.character(features[std_mean_index,2]), "subjectlabels",
               "activitylabels")
               
colnames(newData) <- col_names
varNames <- tolower(names(newData))
varNames <- gsub("^t", "time", varNames)
varNames <- gsub("acc", "acceleration", varNames)
varNames <- gsub("^f", "frequency", varNames)
varNames <- gsub("mag", "magnitude", varNames)
varNames <- gsub("\\(|\\)", "", varNames)
varNames <- gsub("-", "", varNames)

colnames(newData) <- varNames



# Step 5 : Creating a new tidy dataset with averages of variables for each 
# subject and each activity 


tidydata <- aggregate(newData[,1:66],
           by=newData[,c("subjectlabels", "activitylabels")], FUN = mean)


# Writing the tidy dataset to a file
write.table(tidydata, file="tidydata.txt", row.names=FALSE)















