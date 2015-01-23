# CodeBook.md #

This script performs analysis on data taken from UCI Machine Learning Repository http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The run_analysis script should be in the UCI directory which also contains the train and test folders.

## Variable Description :

activity_label : a variable containing data taken from activity_labels.txt  file representing activities performed

features : a variable containing data taken from features.txt file of the data set. It will be used to provide names for columns in the final tidy dataset.

subject_test: a variable containing data taken from subject_test.txt file containing numbers given to subjects of test group

y_test : a variable (data frame) containing data taken from y_test file, representing activity labels of the test group

x_test : a variable (data frame) containing data taken from x_test file, representing the different measurements taken from test group

test_dataset : a new data frame. cbind() function is used to combine x_test,  subject_test, and y_test files to form one data set with all info related to test set.

subject_train : a variable containing data taken from subject_train.txt file containing numbers given to subjects of training group

x_train : a variable (data frame) containing data taken from x_train file

y_train:a variable (data frame) containing data taken from y_train file, representing activity labels of the train group

train_dataset : cbind() function is used to combine x_train, subject_train, and y_train  to form one data set with all info related to training set.

The training and test data sets are combined into one mergedDataset using the rbind() function.

To extract the measurements on the mean and standard deviation for each measurement, 
features data frame is searched for indices of mean and std measurements of all measurements. All the indices are then saved in a new variable std_mean_index.

Then, mean and std measurements related columns are extracted from mergedDataset in addition to columns containing subject_labels (column 562 ) and activity_labels(column 563) and saving them to newData.

This code takes the column containing activity_labels and transforms it into a factor vector with levels.  The levels are renamed then added to newData using cbind() function, without including the column where activity labels are numeric values. Now, the activities are descriptive.

```{r}
groups <-as.factor(newData[,68])
value <- as.character(activity_label[,2])
levels(groups) <- value

newData<- cbind(newData[,1:67],groups)
```

To add descriptive variable names, names of columns corresponding to mean and std measurements are extracted from features, transformed into characters, then saved in variable col_names. 
New variable names are then added to the data frame newData. Some changes have been made to these names to make them more descriptive, like making all letters lowercase, replacing some abbreviations like t and instead using the full name "time", removing parenthesis, and finally applying all these changes to the column names of newData.  I tried to apply all rules provided in the lectures to make variable names descriptive like using lower-case letters and replacing abbreviations although this made the variable names so long.

```{r}
col_names <- c(as.character(features[std_mean_index,2]), "subjectlabels",
               "activitylabels")
colnames(newData) <- col_names
varNames <- tolower(names(newData))
varNames <- gsub("^t", "time", varNames)
varNames <- gsub("acc", "acceleration", varNames)
varNames <- gsub("^f", "frequency", varNames)
varNames <- gsub("mag", "magnitude", varNames)
varNames <- gsub("\\(|\\)", "", varNames)

colnames(newData) <- varNames
```

To create a new tidy dataset with averages of variables for each subject and each activity, the aggregate() function is used.  It splits the data into subsets, computes the mean for each, and returns the result in a convenient form. The final data set is called tidydata.

The resulting dataset (tidydata) has  68 columns and 180 rows, with one variable per column and one observation per row. The first two columns are unique identifiers for each row. They represent the subject and its activity. The remaining columns are the means of the collected features per (subject, activity) pair.

The following list shows the column names in tidydata:

Names were extracted from the file features.txt. All abbreviations are replaced with full names. All dashes and underscores have been removed. All variable names are in lowercase.

 [1] "subjectlabels"                                 
 [2] "activitylabels"                                
 [3] "timebodyaccelerationmeanx"                     
 [4] "timebodyaccelerationmeany"                     
 [5] "timebodyaccelerationmeanz"                     
 [6] "timebodyaccelerationstdx"                      
 [7] "timebodyaccelerationstdy"                      
 [8] "timebodyaccelerationstdz"                      
 [9] "timegravityaccelerationmeanx"                  
[10] "timegravityaccelerationmeany"                  
[11] "timegravityaccelerationmeanz"                  
[12] "timegravityaccelerationstdx"                   
[13] "timegravityaccelerationstdy"                   
[14] "timegravityaccelerationstdz"                   
[15] "timebodyaccelerationjerkmeanx"                 
[16] "timebodyaccelerationjerkmeany"                 
[17] "timebodyaccelerationjerkmeanz"                 
[18] "timebodyaccelerationjerkstdx"                  
[19] "timebodyaccelerationjerkstdy"                  
[20] "timebodyaccelerationjerkstdz"                  
[21] "timebodygyromeanx"                             
[22] "timebodygyromeany"                             
[23] "timebodygyromeanz"                             
[24] "timebodygyrostdx"                              
[25] "timebodygyrostdy"                              
[26] "timebodygyrostdz"                              
[27] "timebodygyrojerkmeanx"                         
[28] "timebodygyrojerkmeany"                         
[29] "timebodygyrojerkmeanz"                         
[30] "timebodygyrojerkstdx"                          
[31] "timebodygyrojerkstdy"                          
[32] "timebodygyrojerkstdz"                          
[33] "timebodyaccelerationmagnitudemean"             
[34] "timebodyaccelerationmagnitudestd"              
[35] "timegravityaccelerationmagnitudemean"          
[36] "timegravityaccelerationmagnitudestd"           
[37] "timebodyaccelerationjerkmagnitudemean"         
[38] "timebodyaccelerationjerkmagnitudestd"          
[39] "timebodygyromagnitudemean"                     
[40] "timebodygyromagnitudestd"                      
[41] "timebodygyrojerkmagnitudemean"                 
[42] "timebodygyrojerkmagnitudestd"                  
[43] "frequencybodyaccelerationmeanx"                
[44] "frequencybodyaccelerationmeany"                
[45] "frequencybodyaccelerationmeanz"                
[46] "frequencybodyaccelerationstdx"                 
[47] "frequencybodyaccelerationstdy"                 
[48] "frequencybodyaccelerationstdz"                 
[49] "frequencybodyaccelerationjerkmeanx"            
[50] "frequencybodyaccelerationjerkmeany"            
[51] "frequencybodyaccelerationjerkmeanz"            
[52] "frequencybodyaccelerationjerkstdx"             
[53] "frequencybodyaccelerationjerkstdy"             
[54] "frequencybodyaccelerationjerkstdz"             
[55] "frequencybodygyromeanx"                        
[56] "frequencybodygyromeany"                        
[57] "frequencybodygyromeanz"                        
[58] "frequencybodygyrostdx"                         
[59] "frequencybodygyrostdy"                         
[60] "frequencybodygyrostdz"                         
[61] "frequencybodyaccelerationmagnitudemean"        
[62] "frequencybodyaccelerationmagnitudestd"         
[63] "frequencybodybodyaccelerationjerkmagnitudemean"
[64] "frequencybodybodyaccelerationjerkmagnitudestd" 
[65] "frequencybodybodygyromagnitudemean"            
[66] "frequencybodybodygyromagnitudestd"             
[67] "frequencybodybodygyrojerkmagnitudemean"        
[68] "frequencybodybodygyrojerkmagnitudestd" 


The final step is saving tidydata to a text file using the function write.table()
