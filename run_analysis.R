
#This is project setup
setwd("C:/Users/Alexander/Desktop/Coursera/getdata/UCI HAR Dataset")
activity_dataset_headers<-read.table("activity_labels.txt")$V2
features<-read.table("features.txt")
setwd("./test")

main_labels<-features[2]
#This line gives a list of indices where mean and standard deviation values are reported
desired_features<-grep("mean|std",main_labels[,1])
#End of project setup

#Data tidying/compilation on behalf of the test data
subject_test<-read.table("subject_test.txt",col.names="subject")
X_test<-read.table("X_test.txt")
y_test<-read.table("y_test.txt")
testlabs<-subject_test[,1]
names(X_test)<-main_labels[,1]
X_test$id<-y_test[,1]

Xtestdata<-X_test[,desired_features]
y_test[,2] <- activity_dataset_headers[y_test[,1]]
names(y_test)<-c("act_id","act_label")

all_test_data<-cbind(subject_test,y_test,Xtestdata)
#End of test data compilation

setwd("..")
setwd("./train")


#Data tidying/compilation on behalf of the training data

subject_train<-read.table("subject_train.txt",col.names="subject")
X_train<-read.table("X_train.txt")
y_train<-read.table("y_train.txt")
trainlabs<-subject_train[,1]
names(X_train)<-main_labels[,1]
X_train$id<-y_train[,1]
Xtraindata<-X_train[,desired_features]
y_train[,2] <- activity_dataset_headers[y_train[,1]]
names(y_train)<-c("act_id","act_label")
all_train_data<-cbind(subject_train,y_train,Xtraindata)

#End of training data compilation

#Start of all data merging & aggregation
library(reshape)
library(reshape2)
all_irvine_data<-rbind(all_test_data,all_train_data)
#This next line melts the data using subject, activity id and activity labels as identification variables
#The other desired_features are then represented as measure variables
melted_irvine_data<-melt(all_irvine_data,measure.vars=names(all_irvine_data[-which(names(all_irvine_data) %in% c("subject","act_id","act_label"))])
                         ,id=c("subject","act_id","act_label"))
output_table <- dcast(melted_irvine_data,subject+act_label ~ variable, mean)
setwd("..")
setwd("..")
#This next line should output the table into the same directory as the extracted datasets
#Rowname was chosen as TRUE in order to easily keep the names in the features file
write.table(output_table,"tidy_data_set.txt",row.name=TRUE)

