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
