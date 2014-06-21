features <- read.table("./data/UCI HAR Dataset/features.txt")
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt",col.names=c("activityId","activity"))

SubTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",col.names="subject")
XTest <- read.table("./data/UCI HAR Dataset/test/X_test.txt",col.names=features[,2])
XTest <- XTest[,(grepl("mean",names(XTest)) | grepl("std",names(XTest))) & !grepl("meanFreq",names(XTest))]
YTest <- read.table("./data/UCI HAR Dataset/test/Y_test.txt",col.names="activityId")
DS1 <- cbind(SubTest,XTest,YTest)

SubTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",col.names="subject")
XTrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt",col.names=features[,2])
XTrain <- XTrain[,(grepl("mean",names(XTrain)) | grepl("std",names(XTrain))) & !grepl("meanFreq",names(XTrain))]
YTrain <- read.table("./data/UCI HAR Dataset/train/Y_train.txt",col.names="activityId")
DS2 <- cbind(SubTrain,XTrain,YTrain)

DS <- rbind(DS1,DS2)

mergedDS = merge(DS,activities,by.x="activityId",by.y="activityId",all=TRUE)
wideTidySet <- aggregate(.~subject + activityId + activity, FUN=mean, data=mergedDS)
tidyDataSet <- melt(wideTidySet, id.vars = c("subject","activityId", "activity"), variable.name = "measurement",value.name = "mean")

tidyDataSet[,4] <- gsub("BodyBody", "Body", tidyDataSet[,4])

tidyDataSet$domain <- ifelse(grepl("^t",tidyDataSet$measurement) == TRUE, "time", "frequency")
tidyDataSet$source <- ifelse(grepl("Body",tidyDataSet$measurement) == TRUE, "body", "gravity")
tidyDataSet$sensor <- ifelse(grepl("Acc",tidyDataSet$measurement) == TRUE, "acceleration", "gyroscopic")
tidyDataSet$jerk <- ifelse(grepl("Jerk",tidyDataSet$measurement) == TRUE, "yes", "no")
tidyDataSet$magnitude <- ifelse(grepl("Mag",tidyDataSet$measurement) == TRUE, "yes", "no")
tidyDataSet$statistic <- ifelse(grepl("mean",tidyDataSet$measurement) == TRUE, "mean", "standard deviation")
tidyDataSet$axis <- ifelse(grepl("X$",tidyDataSet$measurement) == TRUE, "X", ifelse(grepl("Y$",tidyDataSet$measurement) == TRUE,"Y","Z"))
tidyDataSet <- tidyDataSet[,c(1,3,6:12,5)]

write.table(tidyDataSet, "./data/GACD_ASSN_Tidy_Data.txt", sep="\t")