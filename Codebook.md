---
title: "Codebook"
output: html_document
---



# Codebook for Final Data Project

##Analytical Decisions
Given the definition of the problem (mean of means and stds) I determined that the best shape of the data was for each independent measurement of a particular subject performing a particular activity I would have two variables, the mean of the means and the mean of the standard deviations.  Thus for each independent measurement the two datapoints would be the variables provided.

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

###mean of means: The mean of the mean values for the particular measurement - floating point number  
###mean of stds: The mean of the standard deviation values for that particular measurement - floating point number  

