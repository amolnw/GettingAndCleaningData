## Extracted the downloaded folder into data folder inside your working directory
## Read the features file into R
features <- read.table("./data/UCI HAR Dataset/features.txt")

## Read the activity labels file into R
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt",
                         col.names=c("activityId","activity"))

## Read subject Test data file into R
SubTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",col.names="subject")

## Read X test file into R and map column names with loaded feature data
XTest <- read.table("./data/UCI HAR Dataset/test/X_test.txt",col.names=features[,2])

## Subset XTest to columns which contain "std" or "mean" keywords in their names. 
## This excludes column Names with "meanFreq" keyword
XTest <- XTest[,(grepl("mean",names(XTest)) | grepl("std",names(XTest))) & 
                   !grepl("meanFreq",names(XTest))]

## Read Y Test data file into R
YTest <- read.table("./data/UCI HAR Dataset/test/Y_test.txt",col.names="activityId")

## Concatenate column wise (cbind) SubTest, XTest and YTest into one dataset DS1
DS1 <- cbind(SubTest,XTest,YTest)

## Read subject Train data file into R
SubTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",col.names="subject")

## Read X Train file into R and map column names with loaded feature data
XTrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt",col.names=features[,2])

## Subset XTrain to columns which contain "std" or "mean" keywords in their names. 
## This excludes column Names with "meanFreq" keyword
XTrain <- XTrain[,(grepl("mean",names(XTrain)) | grepl("std",names(XTrain))) & 
                     !grepl("meanFreq",names(XTrain))]

## Read Y Test data file into R
YTrain <- read.table("./data/UCI HAR Dataset/train/Y_train.txt",col.names="activityId")

## Concatenate column wise (cbind) SubTrain, XTrain and YTrain into one dataset DS2
DS2 <- cbind(SubTrain,XTrain,YTrain)

## Concatenate row wise (rbind) DS1 and DS2 into dataset DS
DS <- rbind(DS1,DS2)

## Merge activities and DS based on activity Id to get activity names into dataset 
## and name this datset as mergedDS
mergedDS = merge(DS,activities,by.x="activityId",by.y="activityId",all=TRUE)

## Calculate mean for all the variable columns with the help of aggregate function 
## and name this dataSet as wideTidySet
wideTidySet <- aggregate(.~subject + activityId + activity, FUN=mean, data=mergedDS)

## Transform wideTidySet into long tidy set with the help of melt function based on 
## subject, activityId and activity name. Name this as tidyDataSet. Keep variable 
## column name as "measurement" and value column name as "mean"
tidyDataSet <- melt(wideTidySet, id.vars = c("subject","activityId", "activity"), 
                    variable.name = "measurement",value.name = "mean")

## Remove the redundant "Body" keyword from values in measurement column
tidyDataSet[,4] <- gsub("BodyBody", "Body", tidyDataSet[,4])

## Create new column "domain" in the tidyDataSet based on whether value in measurement 
## column starts with "t" i.e time or "f" i.e frequency
tidyDataSet$domain <- ifelse(grepl("^t",tidyDataSet$measurement) == TRUE, "time", "frequency")

## Create new column "source" in the tidyDataSet based on whether value in measurement column 
## has "Body" or "Gravity"
tidyDataSet$source <- ifelse(grepl("Body",tidyDataSet$measurement) == TRUE, "body", "gravity")

## Create new column "sensor" in the tidyDataSet based on whether value in measurement column 
##has "Acc" i.e accelerometer or "Gyro" i.e gyroscope
tidyDataSet$sensor <- ifelse(grepl("Acc",tidyDataSet$measurement) == TRUE, "acceleration", 
                             "gyroscopic")

## Create new column "jerk" in the tidyDataSet based on whether value in measurement column 
## has "Jerk" or not
tidyDataSet$jerk <- ifelse(grepl("Jerk",tidyDataSet$measurement) == TRUE, "yes", "no")

## Create new column "magnitude" in the tidyDataSet based on whether value in measurement
## column has "Mag" or not
tidyDataSet$magnitude <- ifelse(grepl("Mag",tidyDataSet$measurement) == TRUE, "yes", "no")

## Create new column "statistic" in the tidyDataSet based on whether value in measurement 
## column has "mean" i.e Mean or "std" i.e Standard Deviation
tidyDataSet$statistic <- ifelse(grepl("mean",tidyDataSet$measurement) == TRUE, "mean", 
                                "standard deviation")

## Create new column "axis" in the tidyDataSet based on whether value in measurement column 
## ends with "X", "Y" or "Z"
tidyDataSet$axis <- ifelse(grepl("X$",tidyDataSet$measurement) == TRUE, "X", 
                           ifelse(grepl("Y$",tidyDataSet$measurement) == TRUE,"Y","Z"))

## Reorder columns in tidyDataSet so that the subject and activity columns come in beginning 
## and statistic column comes in end.
tidyDataSet <- tidyDataSet[,c(1,3,6:12,5)]

## Write tidyDataSet to file
write.table(tidyDataSet, "./data/GACD_ASSN_Tidy_Data.txt", sep="\t")