README
======================

#Import tidy data set into R:

1. Download the GACD_ASSN_Tidy_Data.txt
2. Use the following command to load the dataset into R
```
read.table("./data/GACD_ASSN_Tidy_Data.txt", sep="\t")
```
#Steps to be performed to run the script:

1. Download the data set from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Create a folder named "Data" in your working directory
3. Unzip the downloaded data set on step 1 into "Data" folder created on Step 2
4. Open the "run_analysis.R" script and run it
5. The "run_analysis.R" script will create a tidy data set in your "Data" directory by the name "GACD_ASSN_Tidy_Data.txt"

#What the script Does

1. Subset XTest and XTrain to columns which contain "std" or "mean" keywords in their names. This excludes column Names with "meanFreq" keyword
2. Concatenate column wise (cbind) SubTest, XTest and YTest into one dataset DS1
3. Concatenate column wise (cbind) SubTrain, XTrain and YTrain into another dataset DS2
4. Concatenate row wise (rbind) DS1 and DS2 into dataset DS
5. Merge activities and DS based on activity Id to get activity names into dataset and name this datset as mergedDS
6. Calculate mean for all the variable columns with the help of aggregate function and name this dataSet as wideTidySet
7. Transform wideTidySet into long tidy set with the help of melt function based on subject, activityId and activity name. Name this as tidyDataSet. Keep variable column name as "measurement" and value column name as "mean"
8. Remove the redundant "Body" keyword from values in measurement column
9. Create new column "domain" in the tidyDataSet based on whether value in measurement column starts with "t" i.e time or "f" i.e frequency
10. Create new column "source" in the tidyDataSet based on whether value in measurement column has "Body" or "Gravity"
11. Create new column "sensor" in the tidyDataSet based on whether value in measurement column has "Acc" i.e accelerometer or "Gyro" i.e gyroscope
12. Create new column "jerk" in the tidyDataSet based on whether value in measurement column has "Jerk" or not
13. Create new column "magnitude" in the tidyDataSet based on whether value in measurement column has "Mag" or not
14. Create new column "statistic" in the tidyDataSet based on whether value in measurement column has "mean" i.e Mean or "std" i.e Standard Deviation
15. Create new column "axis" in the tidyDataSet based on whether value in measurement column ends with "X", "Y" or "Z"
16. Reorder columns in tidyDataSet so that the subject and activity columns come in beginning and statistic column comes in end.
