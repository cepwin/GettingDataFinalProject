run_analysis<-function() {
  ##downloading and upzipping the data
  dir.create(file.path("./data1"), showWarnings = FALSE)
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",dest = "./data1/dataset.zip")
  unzip("./data1/dataset.zip", exdir = "./data1")
  
  training<-read.table("./data1/UCI HAR Dataset/train/x_train.txt") ##load in training data
  testing<-read.table("./data1/UCI HAR Dataset/test/x_test.txt") ##load in training data
  subject_train<-read.table("./data1/UCI HAR Dataset/train/subject_train.txt")
  y_train<-read.table("./data1/UCI HAR Dataset/train/y_train.txt")
  subject_test<-read.table("./data1/UCI HAR Dataset/test/subject_test.txt")
  y_test<-read.table("./data1/UCI HAR Dataset/test/y_test.txt")
  
  nm<-read.table("./data1/UCI HAR Dataset/features.txt") ##load in names
  n1<-nm$V2
  names(training)<-n1 ##set the names for the two data frames 
  names(testing)<-n1
  ## get these columns for training and test data frames
  ##then bind the subject and activity columns for each set

  training<-cbind(y_train,training)
  training<-cbind(subject_train,training)

  testing<-cbind(y_test,testing)
  testing<-cbind(subject_test,testing)
  
  ##bind the two sets together
  allDataMeanStd<-rbind(training,testing)
  
  ##set the appropriate names for subject and activity
  names(allDataMeanStd)[1]<-"Subject"
  names(allDataMeanStd)[2]<-"Activity"
  
  ##replace the activity numbers with activity labels
  activity<-read.table("H:/Coursera/GettingData/UCI HAR Dataset/activity_labels.txt")
  names(activity)<-c("Activity","Activity Desc")
  allDataMeanStd<-merge(activity,allDataMeanStd,by="Activity" )
  allDataMeanStd<-allDataMeanStd[,2:ncol(allDataMeanStd)]  ##remove the old number column

  
  ##make ths eecond dataset
  vec<-sapply(n1,grep,pattern="mean\\(\\)|std\\(\\)") ## get a vector with fields with mean() and std()
  vec<-as.logical(vec)   ##create a logical vector
  vec[is.na(vec)]<-FALSE  ##set the na's to FALSE
  vec<-c(TRUE,TRUE,vec)  ##add back subject and activity
  allDataMeanStd<-allDataMeanStd[,vec]  ##use the vector to get the colums with mean/std measurements for each activity/subject
  
  ##create the aggregate (means) by subject and activity
  means<-aggregate(x=allDataMeanStd[,3:ncol(allDataMeanStd)],by=list(allDataMeanStd$`Activity Desc`,allDataMeanStd$Subject),FUN=mean)

  ##rename the columns
  names(means)[1]<-"Activity"
  names(means)[2]<-"Subject"
  
  ##turn it into skinny data
  meansRes<-gather(means,measurement,value,-Activity,-Subject)


  ##we're going to  create a vector of a measurement being a mean or std 
  ##and use mutate to add it to the data frame
  vec2<-sapply(meansRes$measurement,FUN=grep,pattern="mean\\(\\)")
  vec2<-as.logical(vec2)
  vec2[is.na(vec2)]<-FALSE
 meansRes<-mutate(meansRes,type = ifelse(vec2,"mean of means","mean of stds")) ## if it's a mean, replace it with mean of mean, std, replace with "mean of stds"
 
 ##since we now have a column deliniating means vs std I can noew remove that from measurement
 lst<-lapply(meansRes$measurement,FUN = gsub,pattern = "-mean\\(\\)|-std\\(\\)",replacement="")
 lst<-unlist(lst)
 meansRes<-mutate(meansRes,measurement=mes2)
 
 ##now I can spread it so we have for each activity and subject we have the measurement it's mean of means 
 ## and its mean of stds
 meansRes<-spread(meansRes,type,value)
 
 ##write out the table
 write.table(meansRes,file="tidy_sensor.txt")

  meansRes
}