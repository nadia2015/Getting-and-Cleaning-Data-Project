# README.md #

Data is taken from "Human Activity Recognition Using Smartphones Dataset Version 1.0"

Set your working directory to be the same UCI directory which also contains the train and test folders. The run_analysis script should be in the same directory as well. A code book is provided to explain the analysis performed.

tidydata.txt is the name of the file containing the final tidy dataset resulting from running some analysis on data, including merging the training and the test sets to create one data set, extracting only the measurements on the mean and standard deviation for each measurement, using descriptive activity names to name the activities in the data set, labeling the data set with descriptive variable names,  and creating a new tidy data set with the average of each variable for each activity and each subject.

 To view tidydata.txt, set your working directory to be the same one containing the file and use the following code

```{r}
read.table("tidydata.txt", header=TRUE)
```