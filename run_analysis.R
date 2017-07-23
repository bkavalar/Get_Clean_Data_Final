#Final Project - Week 4 for Getting & Cleaning Data for JHU Data Science Course
#Getting and clearing data from the UCI for Human Activity Recognition Using Smartphones Dataset
#Prepared by B. Kavalar - 23 July 2017

#set working directory
setwd("C:/Backup/2017 IRAD/R Programming/JHU Data Science Course/Getting & Cleaning Data/Week 4/Project")

#read in csv files for X, Y, and Subject Test that were imported into Excel from the provided UCI text files
#x_test is the raw data results for each subject with 561 variables per row
#y_test show what activity was being performed during each sample per row
#subject_test is the subject number in the sample run - 1-30 subjects (people)
X_Test <- data.frame()
X_Test <- read.csv("./UCI HAR Dataset/test/x_test.csv")
Y_Test <- data.frame()
Y_Test <- read.csv("./UCI HAR Dataset/test/y_test.csv")
Sub_Test <- data.frame()
Sub_Test <- read.csv("./UCI HAR Dataset/test/subject_test.csv")

#test imported Y_Test to see format
head(Y_Test)

#replace column data in Y_test for descriptive names using the activity labels text file from UCI dataset
#where:  1=WALKING, 2=WALKING_UPSTAIRS, 3=WALKING_DOWNSTAIRS, 4=SITTING, 5=STANDING, 6=LAYING
Y_Test$X5[Y_Test$X5 == 1] <- "WALKING"
Y_Test$X5[Y_Test$X5 == 2] <- "WALKING_UPSTAIRS"
Y_Test$X5[Y_Test$X5 == 3] <- "WALKING_DOWNSTAIRS"
Y_Test$X5[Y_Test$X5 == 4] <- "SITTING"
Y_Test$X5[Y_Test$X5 == 5] <- "STANDING"
Y_Test$X5[Y_Test$X5 == 6] <- "LAYING"

#column bind the three files imported above to create a new "imported test" file
imported_Test <- cbind(Y_Test, X_Test)
imported_Test <- cbind(Sub_Test, imported_Test)

#save merged data to a csv file to create a combined tidy data set for later inspection
write.csv(imported_Test, file = "./UCI HAR Dataset/test/imported_test.csv")

#remove unneeded columns by only using mean and standard deviation columns along with activity & subject columns
#this reduces column variable data from 561 elements per measurement to only 62 needed for mean and std deviation
filtered_Test <- imported_Test[, c(1, 2, 3, 4, 5, 6, 7, 8, 43, 44, 45, 46, 47, 48, 83,
                                    84, 85, 86, 87, 88, 123, 124, 125, 126, 127, 128,
                                    163, 164, 165, 166, 167, 168, 203, 204, 216, 217,
                                    229, 230, 242, 243, 255, 256, 268, 269, 270, 271,
                                    272, 273, 347, 348, 349, 350, 351, 352, 426, 427,
                                    428, 429, 430, 431, 505, 506, 531, 532)]

#rename header in filtered columns to match data provided by UCI Dataset "features.txt" file
names(filtered_Test)[1] <- "Subject_Number"
names(filtered_Test)[2] <- "Activity"
names(filtered_Test)[3] <- "tBodyAcc-mean()-X"
names(filtered_Test)[4] <- "tBodyAcc-mean()-Y"
names(filtered_Test)[5] <- "tBodyAcc-mean()-Z"
names(filtered_Test)[6] <- "tBodyAcc-std()-X"
names(filtered_Test)[7] <- "tBodyAcc-std()-Y"
names(filtered_Test)[8] <- "tBodyAcc-std()-Z"
names(filtered_Test)[9] <- "tGravityAcc-mean()-X"
names(filtered_Test)[10] <- "tGravityAcc-mean()-Y"
names(filtered_Test)[11] <- "tGravityAcc-mean()-Z"
names(filtered_Test)[12] <- "tGravityAcc-std()-X"
names(filtered_Test)[13] <- "tGravityAcc-std()-Y"
names(filtered_Test)[14] <- "tGravityAcc-std()-Z"
names(filtered_Test)[15] <- "tBodyAccJerk-mean()-X"
names(filtered_Test)[16] <- "tBodyAccJerk-mean()-Y"
names(filtered_Test)[17] <- "tBodyAccJerk-mean()-Z"
names(filtered_Test)[18] <- "tBodyAccJerk-std()-X"
names(filtered_Test)[19] <- "tBodyAccJerk-std()-Y"
names(filtered_Test)[20] <- "tBodyAccJerk-std()-Z"
names(filtered_Test)[21] <- "tBodyGyro-mean()-X"
names(filtered_Test)[22] <- "tBodyGyro-mean()-Y"
names(filtered_Test)[23] <- "tBodyGyro-mean()-Z"
names(filtered_Test)[24] <- "tBodyGyro-std()-X"
names(filtered_Test)[25] <- "tBodyGyro-std()-Y"
names(filtered_Test)[26] <- "tBodyGyro-std()-Z"
names(filtered_Test)[27] <- "tBodyGyroJerk-mean()-X"
names(filtered_Test)[28] <- "tBodyGyroJerk-mean()-Y"
names(filtered_Test)[29] <- "tBodyGyroJerk-mean()-Z"
names(filtered_Test)[30] <- "tBodyGyroJerk-std()-X"
names(filtered_Test)[31] <- "tBodyGyroJerk-std()-Y"
names(filtered_Test)[32] <- "tBodyGyroJerk-std()-Z"
names(filtered_Test)[33] <- "tBodyAccMag-mean()"
names(filtered_Test)[34] <- "tBodyAccMag-std()"
names(filtered_Test)[35] <- "tGravityAccMag-mean()"
names(filtered_Test)[36] <- "tGravityAccMag-std()"
names(filtered_Test)[37] <- "tBodyAccJerkMag-mean()"
names(filtered_Test)[38] <- "tBodyAccJerkMag-std()"
names(filtered_Test)[39] <- "tBodyGyroMag-mean()"
names(filtered_Test)[40] <- "tBodyGyroMag-std()"
names(filtered_Test)[41] <- "tBodyGyroJerkMag-mean()"
names(filtered_Test)[42] <- "tBodyGyroJerkMag-std()"
names(filtered_Test)[43] <- "fBodyAcc-mean()-X"
names(filtered_Test)[44] <- "fBodyAcc-mean()-Y"
names(filtered_Test)[45] <- "fBodyAcc-mean()-Z"
names(filtered_Test)[46] <- "fBodyAcc-std()-X"
names(filtered_Test)[47] <- "fBodyAcc-std()-Y"
names(filtered_Test)[48] <- "fBodyAcc-std()-Z"
names(filtered_Test)[49] <- "fBodyAccJerk-mean()-X"
names(filtered_Test)[50] <- "fBodyAccJerk-mean()-Y"
names(filtered_Test)[51] <- "fBodyAccJerk-mean()-Z"
names(filtered_Test)[52] <- "fBodyAccJerk-std()-X"
names(filtered_Test)[53] <- "fBodyAccJerk-std()-Y"
names(filtered_Test)[54] <- "fBodyAccJerk-std()-Z"
names(filtered_Test)[55] <- "fBodyGyro-mean()-X"
names(filtered_Test)[56] <- "fBodyGyro-mean()-Y"
names(filtered_Test)[57] <- "fBodyGyro-mean()-Z"
names(filtered_Test)[58] <- "fBodyGyro-std()-X"
names(filtered_Test)[59] <- "fBodyGyro-std()-Y"
names(filtered_Test)[60] <- "fBodyGyro-std()-Z"
names(filtered_Test)[61] <- "fBodyAccMag-mean()"
names(filtered_Test)[62] <- "fBodyAccMag-std()"
names(filtered_Test)[63] <- "fBodyBodyGyroMag-mean()"
names(filtered_Test)[64] <- "fBodyBodyGyroMag-std()"

#save filtered test data to a csv file to create a small data set prior to merging with train data
write.csv(filtered_Test, file = "filtered_test.csv")

#repeat process for training data set

#read in csv files for X, Y, and Subject Train that were imported into Excel from the provided UCI text files
#x_train is the raw data results for each subject with 561 variables per row
#y_train show what activity was being performed during each sample per row
#subject_train is the subject number in the sample run - 1-30 subjects (people)
X_Train <- data.frame()
X_Train <- read.csv("./UCI HAR Dataset/train/x_train.csv")
Y_Train <- data.frame()
Y_Train <- read.csv("./UCI HAR Dataset/train/y_train.csv")
Sub_Train <- data.frame()
Sub_Train <- read.csv("./UCI HAR Dataset/train/subject_train.csv")

#test imported Y_Test to see format
head(Y_Train)

#rename column data in Y_test for descriptive names using the activity labels text file from UCI dataset
#where:  1=WALKING, 2=WALKING_UPSTAIRS, 3=WALKING_DOWNSTAIRS, 4=SITTING, 5=STANDING, 6=LAYING
Y_Train$X5[Y_Train$X5 == 1] <- "WALKING"
Y_Train$X5[Y_Train$X5 == 2] <- "WALKING_UPSTAIRS"
Y_Train$X5[Y_Train$X5 == 3] <- "WALKING_DOWNSTAIRS"
Y_Train$X5[Y_Train$X5 == 4] <- "SITTING"
Y_Train$X5[Y_Train$X5 == 5] <- "STANDING"
Y_Train$X5[Y_Train$X5 == 6] <- "LAYING"

#column bind the three files imported above to create a new "imported train" file
imported_Train <- cbind(Y_Train, X_Train)
imported_Train <- cbind(Sub_Train, imported_Train)

#save merged data to a csv file to create a combined tidy data set for later inspection
write.csv(imported_Train, file = "./UCI HAR Dataset/train/imported_train.csv")

#remove unneeded columns by only using mean and standard deviation columns along with activity & subject columns
#this reduces column variable data from 561 elements per measurement to only 62 needed for mean and std deviation
filtered_Train <- imported_Train [, c(1, 2, 3, 4, 5, 6, 7, 8, 43, 44, 45, 46, 47, 48, 83,
                                   84, 85, 86, 87, 88, 123, 124, 125, 126, 127, 128,
                                   163, 164, 165, 166, 167, 168, 203, 204, 216, 217,
                                   229, 230, 242, 243, 255, 256, 268, 269, 270, 271,
                                   272, 273, 347, 348, 349, 350, 351, 352, 426, 427,
                                   428, 429, 430, 431, 505, 506, 531, 532)]

#rename columns to match data provided by UCI Dataset "features.txt" file
names(filtered_Train)[1] <- "Subject_Number"
names(filtered_Train)[2] <- "Activity"
names(filtered_Train)[3] <- "tBodyAcc-mean()-X"
names(filtered_Train)[4] <- "tBodyAcc-mean()-Y"
names(filtered_Train)[5] <- "tBodyAcc-mean()-Z"
names(filtered_Train)[6] <- "tBodyAcc-std()-X"
names(filtered_Train)[7] <- "tBodyAcc-std()-Y"
names(filtered_Train)[8] <- "tBodyAcc-std()-Z"
names(filtered_Train)[9] <- "tGravityAcc-mean()-X"
names(filtered_Train)[10] <- "tGravityAcc-mean()-Y"
names(filtered_Train)[11] <- "tGravityAcc-mean()-Z"
names(filtered_Train)[12] <- "tGravityAcc-std()-X"
names(filtered_Train)[13] <- "tGravityAcc-std()-Y"
names(filtered_Train)[14] <- "tGravityAcc-std()-Z"
names(filtered_Train)[15] <- "tBodyAccJerk-mean()-X"
names(filtered_Train)[16] <- "tBodyAccJerk-mean()-Y"
names(filtered_Train)[17] <- "tBodyAccJerk-mean()-Z"
names(filtered_Train)[18] <- "tBodyAccJerk-std()-X"
names(filtered_Train)[19] <- "tBodyAccJerk-std()-Y"
names(filtered_Train)[20] <- "tBodyAccJerk-std()-Z"
names(filtered_Train)[21] <- "tBodyGyro-mean()-X"
names(filtered_Train)[22] <- "tBodyGyro-mean()-Y"
names(filtered_Train)[23] <- "tBodyGyro-mean()-Z"
names(filtered_Train)[24] <- "tBodyGyro-std()-X"
names(filtered_Train)[25] <- "tBodyGyro-std()-Y"
names(filtered_Train)[26] <- "tBodyGyro-std()-Z"
names(filtered_Train)[27] <- "tBodyGyroJerk-mean()-X"
names(filtered_Train)[28] <- "tBodyGyroJerk-mean()-Y"
names(filtered_Train)[29] <- "tBodyGyroJerk-mean()-Z"
names(filtered_Train)[30] <- "tBodyGyroJerk-std()-X"
names(filtered_Train)[31] <- "tBodyGyroJerk-std()-Y"
names(filtered_Train)[32] <- "tBodyGyroJerk-std()-Z"
names(filtered_Train)[33] <- "tBodyAccMag-mean()"
names(filtered_Train)[34] <- "tBodyAccMag-std()"
names(filtered_Train)[35] <- "tGravityAccMag-mean()"
names(filtered_Train)[36] <- "tGravityAccMag-std()"
names(filtered_Train)[37] <- "tBodyAccJerkMag-mean()"
names(filtered_Train)[38] <- "tBodyAccJerkMag-std()"
names(filtered_Train)[39] <- "tBodyGyroMag-mean()"
names(filtered_Train)[40] <- "tBodyGyroMag-std()"
names(filtered_Train)[41] <- "tBodyGyroJerkMag-mean()"
names(filtered_Train)[42] <- "tBodyGyroJerkMag-std()"
names(filtered_Train)[43] <- "fBodyAcc-mean()-X"
names(filtered_Train)[44] <- "fBodyAcc-mean()-Y"
names(filtered_Train)[45] <- "fBodyAcc-mean()-Z"
names(filtered_Train)[46] <- "fBodyAcc-std()-X"
names(filtered_Train)[47] <- "fBodyAcc-std()-Y"
names(filtered_Train)[48] <- "fBodyAcc-std()-Z"
names(filtered_Train)[49] <- "fBodyAccJerk-mean()-X"
names(filtered_Train)[50] <- "fBodyAccJerk-mean()-Y"
names(filtered_Train)[51] <- "fBodyAccJerk-mean()-Z"
names(filtered_Train)[52] <- "fBodyAccJerk-std()-X"
names(filtered_Train)[53] <- "fBodyAccJerk-std()-Y"
names(filtered_Train)[54] <- "fBodyAccJerk-std()-Z"
names(filtered_Train)[55] <- "fBodyGyro-mean()-X"
names(filtered_Train)[56] <- "fBodyGyro-mean()-Y"
names(filtered_Train)[57] <- "fBodyGyro-mean()-Z"
names(filtered_Train)[58] <- "fBodyGyro-std()-X"
names(filtered_Train)[59] <- "fBodyGyro-std()-Y"
names(filtered_Train)[60] <- "fBodyGyro-std()-Z"
names(filtered_Train)[61] <- "fBodyAccMag-mean()"
names(filtered_Train)[62] <- "fBodyAccMag-std()"
names(filtered_Train)[63] <- "fBodyBodyGyroMag-mean()"
names(filtered_Train)[64] <- "fBodyBodyGyroMag-std()"

#save filtered train data to a csv file for inspection prior to merging with test data
write.csv(filtered_Train, file = "filtered_train.csv")

#merge filtered test and training data sets using rbind function into single tidy dataset
mergedBodyData <- rbind(filtered_Test, filtered_Train)

#save merged data to a csv file for later inspection
write.csv(mergedBodyData, file = "merged_bodydata.csv")

#now need to sort merged datasets based on activity and subject number
#sort data using order function
ordered_Bodydata <- mergedBodyData[order(mergedBodyData$Subject_Number, mergedBodyData$Activity), ]

#save ordered data to a csv file to create a combined tidy data set for later inspection
write.csv(ordered_Bodydata, file = "ordered_bodydata.csv")

#create data frame for final data set
finalTidyDataSet <- data.frame()

#use for loop for all 30 subject numbers in merged and ordered dataset to create
#final tidy data set with mean information for each activity type and measurement taken
for (i in 1:30) {

#filter data for each subject number
subjectData_i <- data.frame()
subjectData_i <- ordered_Bodydata[ordered_Bodydata$Subject_Number == i,]

#then split into separate datasets for each activity type
subjectLaying_i <- subjectData_i[subjectData_i$Activity == 'LAYING',]
subjectSitting_i <- subjectData_i[subjectData_i$Activity == 'SITTING',]
subjectStanding_i <- subjectData_i[subjectData_i$Activity == 'STANDING',]
subjectWalking_i <- subjectData_i[subjectData_i$Activity == 'WALKING',]
subjectWalkingDown_i <- subjectData_i[subjectData_i$Activity == 'WALKING_DOWNSTAIRS',]
subjectWalkingUp_i <- subjectData_i[subjectData_i$Activity == 'WALKING_UPSTAIRS',]

#remove first two columns of integer data that are not required for mean calculation
#these were added columns to give context to the subject number and activity type
subjectLaying_i = subjectLaying_i[, -1]
subjectLaying_i = subjectLaying_i[, -1]
subjectSitting_i = subjectSitting_i[, -1]
subjectSitting_i = subjectSitting_i[, -1]
subjectStanding_i = subjectStanding_i[, -1]
subjectStanding_i = subjectStanding_i[, -1]
subjectWalking_i = subjectWalking_i[, -1]
subjectWalking_i = subjectWalking_i[, -1]
subjectWalkingDown_i = subjectWalkingDown_i[, -1]
subjectWalkingDown_i = subjectWalkingDown_i[, -1]
subjectWalkingUp_i = subjectWalkingUp_i[, -1]
subjectWalkingUp_i = subjectWalkingUp_i[, -1]


#calculate the means for each column for the dataset broken down by activity type
#perform required calculations on columns - run colMeans
meansubjectLaying_i <- colMeans(subjectLaying_i)
meansubjectSitting_i <- colMeans(subjectSitting_i)
meansubjectStanding_i <- colMeans(subjectStanding_i)
meansubjectwalking_i <- colMeans(subjectWalking_i)
meansubjectWalkingDown_i <- colMeans(subjectWalkingDown_i)
meansubjectwalkingUp_i <- colMeans(subjectWalkingUp_i)

#transpost data to put back into column orientation format after colMeans converted to single column
transpose_subjectLaying_i <- t(meansubjectLaying_i)
transpose_subjectSitting_i <- t(meansubjectSitting_i)
transpose_subjectStanding_i <- t(meansubjectStanding_i)
transpose_subjectWalking_i <- t(meansubjectwalking_i)
transpose_subjectWalkingDown_i <- t(meansubjectWalkingDown_i)
transpose_subjectWalkingUp_i <- t(meansubjectwalkingUp_i)

#recombine into a single dataset for each subject number
recombine_subjectData_i <- rbind(transpose_subjectLaying_i, transpose_subjectSitting_i,
                                transpose_subjectStanding_i,transpose_subjectWalking_i,
                                transpose_subjectWalkingDown_i, transpose_subjectWalkingUp_i)

#create data frame for mean data for each activity type
finalTidyMeanData_i <- data.frame()

#add columns for Subject Number and Activity
finalTidyMeanData_i <- cbind(Subject_Number = i, Activity = c('Laying', 'Sitting', 'Standing', 
                        'Walking', 'Walking_Downstairs', 'Walking_Upstairs'), recombine_subjectData_i)

#recursively rbind each mean tidy data set for each subject number
finalTidyDataSet <- rbind(finalTidyDataSet, finalTidyMeanData_i)

#recursively update the final dataset file for each subject number and save file for inspection
#file should contain six activity rows for each of the 30 subject numbers (people) (180 total data rows)
#column results appear for the mean of each of the activities for each subject number
write.csv(finalTidyDataSet, file = "finalTidyDataSet.csv")

}

