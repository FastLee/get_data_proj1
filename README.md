# Getting and Cleaning Data - Course Project
Submission by: Liran Bareket
  
 
 This repo contain my work for the course project  
 In Here you will find:  
 * run_analyis.R - The r code to read and analyze the data
 * activity_average.txt - the output of the R script. A table with the averages for the measures by activity and subject
 * activity_average_dict.txt - Data dictionary for the content of activity_average.txt
 * activity_average_dict.txt - Data dictionary for the content of activity_average.txt in PDF format
 * README.md - this readme markdown file
   
   
### Program description:
The run_analysis.R performs the following operations:

1. First we read the "features.txt" file. This file contains the column names for the measures.
2. We filter this list to extract the index and name of all the columns that contain the word mean or std (for standard diviation).
3. We clean up the names and remove parantheses and - signs. This make it easier to address these names when we use them as columns.
4. We load the 6 elements of the data. We have train and test data. For each we have:
	* x file - contains all the findings
	* y file - contains a list of the activities matching the findings
	* subject file - contains the number of the test subject
5. We capture the files using the LaF package. read.fwf failed to read the file. We read only the columns we need from the file and name them approprietly.
6. We merge all the read data frame into one data frame.
7. We load the activity file that decodes the names for the activities.
8. We merge the activity file with the combined result file.
9. We are now in full compliance with instructions 1-4 of the project
10. We average all the columns using the aggregate function. The reason we use aggregate is that we can summarize all the columns without specifying them individually.
11. We output the result DF to a file.



