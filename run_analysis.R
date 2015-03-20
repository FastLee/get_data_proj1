library(dplyr)
library(LaF)
## Getting the list of features (Variables)
features<-read.csv("../r/UCI HAR Dataset/features.txt",sep=" ", header=FALSE)
## Subsetting the list of measure to extract the standard diviations and means
std_mean_features<-features[c(grep("mean",features$V2),grep("std",features$V2)),]
names(std_mean_features)<-c("col_no","col_name")
std_mean_features$col_name<-gsub("-","_",gsub("\\(\\)","",std_mean_features$col_name))
## The data is split to 4 files x_train.txt,y_train.txt,x_test.txt,y_test.txt 
## We will first read them using the LaF package.
## We will pick only the column specified in std_mean_features
## Test Data
x_test_fwf<-laf_open_fwf("../r/UCI HAR Dataset/test/X_test.txt",rep("numeric",561), rep(16,561))
x_test<-x_test_fwf[,std_mean_features$col_no]
names(x_test)<-std_mean_features$col_name
y_test_file<-laf_open_csv("../r/UCI HAR Dataset/test/subject_test.txt","numeric","Activity")
y_test<-y_test_file[,1]
sub_test_file<-laf_open_csv("../r/UCI HAR Dataset/test/subject_test.txt","numeric","Subject")
sub_test<-sub_test_file[,1]
## Train Data
x_train_fwf<-laf_open_fwf("../r/UCI HAR Dataset/train/x_train.txt",rep("numeric",561), rep(16,561))
x_train<-x_train_fwf[,std_mean_features$col_no]
names(x_train)<-std_mean_features$col_name
y_train_file<-laf_open_csv("../r/UCI HAR Dataset/train/Y_train.txt","numeric","Activity")
y_train<-y_train_file[,1]
sub_train_file<-laf_open_csv("../r/UCI HAR Dataset/train/subject_train.txt","numeric","Subject")
sub_train<-sub_train_file[,1]
## Combining the data frames, now that we have the data in 4 data frames we will combine them together.
test<-cbind(y_test,sub_test,x_test)
train<-cbind(y_train,sub_train,x_train)
train_test<-rbind(train,test)
## Now we will decode the Activity Names
activity<-read.csv("../r/UCI HAR Dataset/activity_labels.txt",sep=" ",col.names=c("Activity","Activity_Name"),colClasses=c("numeric","character"), header=FALSE)
act_train_test<-merge(activity,train_test,by="Activity") %>% dplyr::select(-Activity)
## We write out the table for the submission
write.table(act_train_test,"activity_subset.txt",row.names=FALSE)
## Next we will group by and summarise the data ****5th element
avg_act_train_test<-aggregate(. ~ Activity_Name+Subject ,data=act_train_test,mean,na.rm=TRUE)
write.table(avg_act_train_test,"activity_average.txt",row.names=FALSE)