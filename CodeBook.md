CODEBOOK
======================
##Data source and brief description:

The data in the UCI HAR Dataset represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 30 volunteers, aged 19-48, performed six activities (walking, walking upstairs, walking downstairs, sitting, standing, and laying) while wearing the smartphone. The linear acceleration and angular velocity were captured by the smartphone's embedded accelerometer and gyroscope. Additional information, including details on pre-processing of the data by the original suppliers of the data, are provided in the README.txt file provided with in the UCI HAR Dataset folder.

The dataset was provided as part of the course project for the Coursera Course called Getting and Cleaning Data (https://class.coursera.org/getdata-003/).

The dataset was originally obtained from the following site which also includes a full description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Data variables:

The following data are imported from the UCI HAR Dataset:

activities: A two column table of the six activities. Column 1 contains the numbers 1 to 6 in sequential order which correspond to the following activities listed in Column 2: walking, walking upstairs, walking downstairs, sitting, standing, and laying.

features: A two column table of the 561 accelerometer and gyroscope measurements. Column 1 contains the numbers 1 to 561 in sequential order with the features described in abbreviated format in Column 2. Feature descriptions were imported as provided.

The accelerometer data is contained in two data sets located in folders called test and train. The entire data set was randomly partitioned in to these two data sets. The test folder contains data for 30% of the volunteers (2947 observations). The train folder contains data for 70% of the volunteers (7352 observations).

SubTest and SubTrain: Each of these are a 1 column table containing the volunteer subject number (1-30). SubTest contains all 2947 rows from subject_test.txt, SubTrain contains all 7352 rows from subject_train.txt.

XTest and XTrain: Each of these contain 561 columns that correspond to the features data. XTest contains all 2947 rows from X_test.txt, XTrain contains all 7352 rows from X_train.txt. While reading the data, column names are applied from features variable. 

YTest and YTrain: Each of these are a 1 column table containing the activity number that corresponds to the activity listed in activities. YTest contains all 2947 rows from y_test.txt, YTrain contains all 7352 rows from y_train.txt.

##Data transformations and processing to form a tidy data set:

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


I have chosen Long Data as tidy data for this assignment. Please refer to following links for reference as to why I have chosen "Long Data over Wide Data"

https://class.coursera.org/getdata-004/forum/thread?thread_id=262
https://class.coursera.org/getdata-004/forum/thread?thread_id=284
https://class.coursera.org/getdata-004/forum/thread?thread_id=217
http://vita.had.co.nz/papers/tidy-data.pdf

http://seananderson.ca/2013/10/19/reshape.html



