---
title: "Codebook"
output: html_document
---



# Codebook for Final Data Project

##Introduction
This codebook is intended to suppliment the codebook information at the links below.
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
and at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  

In this codebook I will describe the analytical decsions I made and the data points included in the data.


##Analytical Decisions
Given the definition of the problem (mean of means and stds) I determined that the best shape of the data was for each independent measurement of a particular subject performing a particular activity I would have two variables, the mean of the means and the mean of the standard deviations.  Thus for each independent measurement the two datapoints would be the variables provided.  
The second important decision was which columns to include.   I chose to include the columns that were the means and the standard deviations of the raw data.  These are designated in the original data with the _mean() or _std() in the feature label.

##Codebook

###Activity: This is the activity that was involved when the measurement was made
  *Possible Values:  
    WALKING  
    WALKING_UPSTARES  
    WALKING_DOWNSTARES  
    SITTING  
    STANDING  
    LAYING  

###Subject: This is the subject being measured  
  numeric: 1:20  
    
###measurement: the measurements coming off the instruments  
*Possible values:  
"fBodyAcc-X"
"fBodyAcc-Y"           
"fBodyAcc-Z"           
"fBodyAccJerk-X"       
"fBodyAccJerk-Y"       
"fBodyAccJerk-Z"       
"fBodyAccMag"         
"fBodyBodyAccJerkMag"  
"fBodyBodyGyroJerkMag" 
"fBodyBodyGyroMag"     
"fBodyGyro-X"          
"fBodyGyro-Y"          
"fBodyGyro-Z"          
"tBodyAcc-X"          
"tBodyAcc-Y"           
"tBodyAcc-Z"           
"tBodyAccJerk-X"       
"tBodyAccJerk-Y"       
"tBodyAccJerk-Z"       
"tBodyAccJerkMag"      
"tBodyAccMag"         
"tBodyGyro-X"          
"tBodyGyro-Y"          
"tBodyGyro-Z"          
"tBodyGyroJerk-X"      
"tBodyGyroJerk-Y"      
"tBodyGyroJerk-Z"      
"tBodyGyroJerkMag"    
"tBodyGyroMag"         
"tGravityAcc-X"        
"tGravityAcc-Y"        
"tGravityAcc-Z"        
"tGravityAccMag"      

NOTE: the full explanation of these measurements can be found in the features_info.txt file in the original data set. 

###mean of means: The mean of the mean values for the particular measurement - floating point number  -1.000000:1.000000
###mean of stds: The mean of the standard deviation values for that particular measurement - floating point number  -1.000000:1.000000 

##Transformations
The script perfroms the following transformations  
1. Downloads in the data file and extracts it  
2. Reads in the main data table containing the calculations on the raw sensor data  
3. Reads in the files containing features(table headers), activities and subjects.   
4. The activitiy/subject files are joined to the main data table to complete the columns(activities/subjects) and the column names are provided by the features (except the activity/subject that are provided manually)  
5. The label table of activity numbers and labels is read in  
6, The activity numbers are replaced with the labels by merging the lable table on Activity and the numeric column for activities is removed  
7.  A logical vector is created of the columns with yes or no depending on whether it is a mean or std.   
8   This logical vector is applied to retain only the desired columns  
9   The data is then aggregated over activity/subject  
10. The aggregated data is now turned into a skinny dataset using gather on the columns other than activity and subject.  
11,  A column is added which has "mean of means" if it is a mean value and "mean of std" if it is a std deviation value  
12.  This then allows mean() or std() to be removed from the measurment values (ie "fBodyAcc-mean()-X" becomes "fBodyAcc-X".)  
13.  spread can then be used to create the resulting form  of "activity subject measurement mean std"  
14.  Dataset is written out

