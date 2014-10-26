datacleaningproject
===================

Data Cleaning Class Project

Data should be downloaded from

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Background info on the data can be found at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


The run_analysis.R script assumes the unzipped data file is in your working directory.

execute run_analyis.R

The script first loads all the data files from both test and training directory.

The separate data frames are then combined into one master dataframe.

Only the data columns for the mean and std of the variables are then displayed

The data then is grouped and summarized to display the mean of the the variables
