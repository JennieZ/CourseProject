The data against which the analysis is performed in this course project is obtained here http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

See 'CodeBook.md' for more details about features in the result data set. 

####There are three files in this repository. They are:

* **README.md** - explains how all scripts work and how they are connected.
* **run_analysis.R** - script that performs the operations reqired in course project.
* **CodeBook.md** - explains the variables in tidy data set in the output of the analysis script.

####Explanations for how run_analysis.R script accomplishes the 5 steps in the course project:

####Step 1 

- The script first reads in the x, y and subject files for train and test data respectively and merges the vector data (x) with activity labels (y) and subject for each data set.
- The script then reads in the feature names, adds two variable names for activity and subject, and assigned the names to each data set before merging train and test to one data set.
- Unused objects are removed after merging to avoid confusion.

####Step 2

- The script finds the variable names with mean or std in the name and makes a numeric vector out of it including the last two columns (activity and subject).
- The vector is used to subset the result data set from step 1 to get only the measurements on the mean and standard deviation for each measurement
- Unused objects are removed after merging to avoid confusion.

####Step 3

- The script reads in the activity labels data and replaces the actvitiy values in the dataset with factor levels.
- Unused objects are removed after merging to avoid confusion.

####Step 4

- The script uses regular expression to manipulate the names of the variables to make them more descriptive and then renames them in the data set.
- The order of certain words are reoganized to make the names more meaningful.
- X, Y and Z in variable names are denoted as "on the X/Y/Z axis"
- Abbreviated words are spelled out or replaced with meaningful phrases: Acc to acceleration, Gyro to angular velocity, std to standard deviation, Mag to magnitude, t to in time, f to in frequency.
- Body was repeated twice in certain variable names and extra instances are removed by the script.
- All names are converted to lowercase. 

####Step 5

- The result data set from step 4 is melted into a long skinny data set with all measurements collapsing into row values leaving only activity and subject columns and then casted into a tidy data set with each row representing one activity of one subject with averages of each measurement.

