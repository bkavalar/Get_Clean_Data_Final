##JHU Getting and Cleaning Data Course - Final Project
##Prepared by B. Kavalar 24 July 2017

##Codebook.md Content

This codebook describes the dataset used and the processing needed to clean the set, along with the resulting 
variables and description of the final tidy data set provided for the assignment


##Datasets provided by UCI

I first downloaded the zip file of the datasets for the project from the following link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Below is a decription of the data set files from UCI

Human Activity Recognition Using Smartphones Dataset
Version 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws


The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each
person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing
a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured
3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been
video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where
70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in
fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal,
which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body
acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a
filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating
variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:


- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample.
Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis
in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the
'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity
from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each
window sample. The units are radians/second. 

Notes: 

- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.


##Processing performed on UCI datasets

Since these files were all text files I needed to import them into Excel to create .csv files

I read files for X, Y, and Subject Test into Excel from the provided UCI text files

1) x_test is the raw data results for each subject with 561 variables per row
2) y_test shows what activity was being performed during each sample per row
3) subject_test is the subject number in the sample run - 1-30 subjects (people) for each row of data

These files were saved as csv files for easier processing in R.

This process was repeated for the train data set:

I read files for X, Y, and Subject Test into Excel from the provided UCI text files

1) x_train is the raw data results for each subject with 561 variables per row
2) y_train shows what activity was being performed during each sample per row
3) subject_train is the subject number in the sample run - 1-30 subjects (people) for each row of data

These files were saved as csv files for easier processing in R.

I then read in the features file provided by UCI.  I then used expressions to remove leading numbers from
the feature names and used this add correct column names to the X_Test and X_Train files.

I then subsetted / filtered the X_Test and X_Train files to only use columns with mean or std in the name.

Next I used the UCI activity lables.txt to rename the Y_Test and Y_Train column data to more descriptive 
names in the activity labels files. This resulted in using descriptive names using the activity labels 
where:  1=WALKING, 2=WALKING_UPSTAIRS, 3=WALKING_DOWNSTAIRS, 4=SITTING, 5=STANDING, 6=LAYING so it was
easier to understand the data later.

I then performed a cbind on the three dataset files X, Y, and Subject for test and train into a single files for
test and train later processing.

I then renamed the column headers in both the filtered test and train files for the subject number,
activity type.

Once these test and train datasets were filtered and columns renamed I merged the two datasets to form a combined
final dataset for processing for mean and standard deviation.  I reordered the merged dataset on subject number
and activity type to unify the datase related to those variables.  The subject number was selected first then I
sorted on the activity type.

We now have a merged dataset that we can process to find mean and standard deviation values related to the six
activity types for each of the 30 subject numbers.

I used a for loop to process the mean and standard deviation each of the subject numbers during each loop. During
each loop colMeans was run. Since colMeans only works on numberic data I need to remove the columns for subject
number and activity type before running the mean.  However, colMeans created a single column of data and I then
needed to transpose this information into required columns of data for each subject number run.  Once the data was
transposed I recombined into a single data set for each of the six activity types for the given subject number.
Then I added back in the columns for subject number and activity type.


##Final Tidy Data Set Created

The resultant data created six rows for each subject number since there are six activities.  I used colMeans to
find the overall values for each variable. This data was recursively written to a saved data file for each subject
number 1-30. The resultand data file has the format for columns and rows shown below with 180 rows of data:

|  Column 1:     |      Column 2:         |                             Columns 3-64:     
| Subject Number |    Activity Types      |                            Calculated Mean
|                |                        | Column  |      Variable          |               Units    
|                |                        | 3       |  tBodyAcc-mean()-X     |      standard gravity units 'g' 
|                |                        | 4       |  tBodyAcc-mean()-Y     |      standard gravity units 'g' 
|                |                        | 5       |  tBodyAcc-mean()-Z     |      standard gravity units 'g' 
|                |                        | 6       |  tBodyAcc-std()-X      |      standard gravity units 'g' 
|                |                        | 7       |  tBodyAcc-std()-Y      |      standard gravity units 'g' 
|                |                        | 8       |  tBodyAcc-std()-Z      |      standard gravity units 'g' 
|                |                        | 9       |  tGravityAcc-mean()-X  |      standard gravity units 'g' 
|                |                        | 10      |  tGravityAcc-mean()-Y  |      standard gravity units 'g' 
|                |                        | 11      |  tGravityAcc-mean()-Z  |      standard gravity units 'g'
|                |                        | 12      |  tGravityAcc-std()-X   |      standard gravity units 'g' 
|                |                        | 13      |  tGravityAcc-std()-Y   |      standard gravity units 'g' 
|                |                        | 14      |  tGravityAcc-std()-Z    |     standard gravity units 'g' 
|                |                        | 15      |  tBodyAccJerk-mean()-X  |     standard gravity units 'g' 
|                |                        | 16      |  tBodyAccJerk-mean()-Y  |     standard gravity units 'g' 
|                |                        | 17      |  tBodyAccJerk-mean()-Z  |     standard gravity units 'g' 
|                |                        | 18      |  tBodyAccJerk-std()-X   |     standard gravity units 'g' 
|                |                        | 19      |  tBodyAccJerk-std()-Y   |     standard gravity units 'g' 
|                |                        | 20      |  tBodyAccJerk-std()-Z   |     standard gravity units 'g' 
|                |                        | 21      |  tBodyGyro-mean()-X     |          radians/second 
|                |                        | 22      |  tBodyGyro-mean()-Y     |          radians/second 
|                |                        | 23      |  tBodyGyro-mean()-Z     |          radians/second 
|                |                        | 24      |  tBodyGyro-std()-X      |          radians/second 
|                |                        | 25      |  tBodyGyro-std()-Y      |          radians/second 
|                |                        | 26      |  tBodyGyro-std()-Z      |          radians/second
|                |                        | 27      |  tBodyGyroJerk-mean()-X  |         radians/second 
|                |                        | 28      |  tBodyGyroJerk-mean()-Y  |         radians/second 
|                |                        | 29      |  tBodyGyroJerk-mean()-Z  |         radians/second 
|                |                        | 30      |  tBodyGyroJerk-std()-X   |         radians/second 
|                |                        | 31      |  tBodyGyroJerk-std()-Y   |         radians/second 
|                |                        | 32      |  tBodyGyroJerk-std()-Z   |         radians/second 
|                |                        | 33      |  tBodyAccMag-mean()       |   standard gravity units 'g' 
|                |                        | 34      |  tBodyAccMag-std()        |   standard gravity units 'g' 
|                |                        | 35      |  tGravityAccMag-mean()    |   standard gravity units 'g'
|                |                        | 36      |  tGravityAccMag-std()     |   standard gravity units 'g' 
|                |                        | 37      |  tBodyAccJerkMag-mean()   |   standard gravity units 'g' 
|                |                        | 38      |  tBodyAccJerkMag-std()    |   standard gravity units 'g' 
|                |                        | 39      |  tBodyGyroMag-mean()      |         radians/second 
|                |                        | 40      |  tBodyGyroMag-std()       |         radians/second 
|                |                        | 41      |  tBodyGyroJerkMag-mean()  |         radians/second 
|                |                        | 42      |  tBodyGyroJerkMag-std()   |         radians/second 
|                |                        | 43      |  fBodyAcc-mean()-X        |   standard gravity units 'g' 
|                |                        | 44      |  fBodyAcc-mean()-Y        |   standard gravity units 'g' 
|                |                        | 45      |  fBodyAcc-mean()-Z        |   standard gravity units 'g  
|                |                        | 46      |  fBodyAcc-std()-X         |   standard gravity units 'g' 
|                |                        | 47      |  fBodyAcc-std()-Y         |   standard gravity units 'g'  
|                |                        | 48      |  fBodyAcc-std()-Z         |   standard gravity units 'g' 
|                |                        | 49      |  fBodyAcc-meanFreq()-X     |             Hertz
|                |                        | 50      |  fBodyAcc-meanFreq()-Y     |             Hertz
|                |                        | 51      |  fBodyAcc-meanFreq()-Z     |             Hertz
|                |                        | 52      |  fBodyAccJerk-mean()-X    |   standard gravity units 'g'  
|                |                        | 53      |  fBodyAccJerk-mean()-Y    |   standard gravity units 'g' 
|                |                        | 54      |  fBodyAccJerk-mean()-Z    |   standard gravity units 'g' 
|                |                        | 55      |  fBodyAccJerk-std()-X     |   standard gravity units 'g' 
|                |                        | 56      |  fBodyAccJerk-std()-Y     |   standard gravity units 'g' 
|                |                        | 57      |  fBodyAccJerk-std()-Z     |   standard gravity units 'g'
|                |                        | 58      |  fBodyAccJerk-meanFreq()-X  |             Hertz
|                |                        | 59      |  fBodyAccJerk-meanFreq()-Y  |             Hertz
|                |                        | 60      |  fBodyAccJerk-meanFreq()-Z  |             Hertz
|                |                        | 61      |  fBodyGyro-mean()-X       |         radians/second  
|                |                        | 62      |  fBodyGyro-mean()-Y       |         radians/second 
|                |                        | 63      |  fBodyGyro-mean()-Z       |         radians/second 
|                |                        | 64      |  fBodyGyro-std()-X        |         radians/second 
|                |                        | 65      |  fBodyGyro-std()-Y        |         radians/second 
|                |                        | 66      |  fBodyGyro-std()-Z        |         radians/second 
|                |                        | 67      |  fBodyGyro-meanFreq()-X   |             Hertz
|                |                        | 68      |  BodyGyro-meanFreq()-Y    |             Hertz
|                |                        | 69      |  fBodyGyro-meanFreq()-Z   |             Hertz
|                |                        | 70      |  fBodyAccMag-mean()       |   standard gravity units 'g' 
|                |                        | 71      |  fBodyAccMag-std()        |   standard gravity units 'g'
|                |                        | 72      |  fBodyAccMag-meanFreq()   |             Hertz
|                |                        | 73      |  fBodyBodyAccJerkMag-mean()   |    standard gravity units 'g'
|                |                        | 74      |  fBodyBodyAccJerkMag-std()    |    standard gravity units 'g'
|                |                        | 75      |  fBodyBodyAccJerkMag-meanFreq()  |      Hertz
|                |                        | 76      |  fBodyBodyGyroMag-mean()  |         radians/second 
|                |                        | 77      |  fBodyBodyGyroMag-std()   |         radians/second
|                |                        | 78      |  fBodyBodyGyroMag-meanFreq()  |         Hertz
|                |                        | 79      |  fBodyBodyGyroJerkMag-mean()  | standard gravity units 'g'
|                |                        | 80      |  fBodyBodyGyroJerkMag-std()   | standard gravity units 'g'
|                |                        | 81      |  fBodyBodyGyroJerkMag-meanFreq()    |   Hertz
|                |                        | 82      |  angle(tBodyAccMean,gravity)          | gravity units 'g'
|                |                        | 83      |  angle(tBodyAccJerkMean),gravityMean) | gravity units 'g'
|                |                        | 84      |  angle(tBodyGyroMean,gravityMean)     | gravity units 'g'
|                |                        | 85      |  angle(tBodyGyroJerkMean,gravityMean) | gravity units 'g'
|                |                        | 86      |  angle(X,gravityMean)   |               gravity units 'g'
|                |                        | 87      |  angle(Y,gravityMean)   |               gravity units 'g'
|                |                        | 88      |  angle(Z,gravityMean)   |               gravity units 'g'
              

The data was saved to a file called "finalTidyDataSet.csv" for later inspection.


##Varibles used in the script file

- X_Test: data with 561 columns data for each test row that corresponds to the Y_Test data and Sub_Test data
- Y_Test: data with single column of data for each activity type on each data sample
- Sub_Test: data with single column of data subject numbers for each data sample

- X_Train: data with 561 columns data for each train row that corresponds to the Y_Train data and Sub_Train data
- Y_Train: data with single column of data for each activity type on each data sample
- Sub_Train: data with single column of data subject numbers for each data sample

- Features: data with single row of data from the features.txt file with numeric values removed

- imported_Test: data with combined data from X_Test, Y_Test, and Sub_Test
- imported_Train: data with combined data from X_Train, Y_Train, and Sub_Train

- filtered_Test: data with reduced columns for only mean & std names along with subject number and activity columns
- filtered_Train: data with reduced columns for only mean & std names along with subject number and activity columns

- mergedBodyData: data created by combining filtered_Test and filtered_Train data frames

- ordered_Bodydata: data created by reordering mergedBodyData by subject number and activity type

- subjectDatai: data in loop for each subject number that contains only information for that subject number
   filtered down from the orderedBodyData data frame

- subjectLaying_i: filtered data from subjectData for only the LAYING rows of data
- subjectSitting_i: filtered data from subjectData for only the SITTING rows of data
- subjectStanding_i: filtered data from subjectData for only the STANDING rows of data
- subjectWalking_i: filtered data from subjectData for only the WALKING rows of data
- subjectWalkingDown_i: filtered data from subjectData for only the WALKING DOWNSTAIRS rows of data
- subjectWalkingUp_i: filtered data from subjectData for only the WALKING UPSTAIRS rows of data

- meansubjectLaying_i: averaged data from the LAYING rows of data for each subject number 
- meansubjectSitting_i: averaged data only the SITTING rows of data for each subject number
- meansubjectStanding_i: averaged data only the STANDING rows of data for each subject number
- meansubjectWalking_i: averaged data only the WALKING rows of data for each subject number
- meansubjectWalkingDown_i: averaged data only the WALKING DOWNSTAIRS rows of data for each subject number
- meansubjectWalkingUp_i: averaged data only the WALKING UPSTAIRS rows of data for each subject number

- transpose_subjectLaying_i: transpose colMean output back into 62 columns of LAYING data for each subject
- transpose_subjectSitting_i: transpose colMean output back into 62 columns of SITTING data for each subject
- transpose_subjectStanding_i: transpose colMean output back into 62 columns of STANDING data for each subject
- transpose_subjectWalking_i: transpose colMean output back into 62 columns of WALKING data for each subject
- transpose_subjectWalkingDown_i: transpose colMean output back into 62 columns of WALKING DOWN data for each
  subject
- transpose_subjectWalkingUp_i: transpose colMean output back into 62 columns of WALKING UP each subject

- recombine_subjectData_i: data frame that merges all six transposed data frames (Laying, Sitting, Standing,
  Walking, Walking Downstairs, Walking Upstairs) listed above for each subject number

- finalTidyMeanData_i: data set for during for loop to create data for each subject number for the final data set.
  This data is combined with finaTidyDataSet in a recurive manner to create the final data set

- finalTidyDataSet: data set used to create final tidy data set that only shows mean and Std Dev for each subject
  and activity type 

- convertFileTxt - data frame used to hold csv data to convert to a text file for output per assignment
  requirement



