#Final Project - Week 4 for Getting & Cleaning Data for JHU Data Science Course
#Getting and clearing data from the UCI for Human Activity Recognition Using Smartphones Dataset
#Prepared by B. Kavalar - 31 July 2017 - post submission revision

#set working directory
setwd("C:/Getting & Cleaning Data/Week 4/Project")

#read in csv files for X, Y, and Subject Test that were imported into Excel from the provided UCI text files
#x_test is the raw data results for each subject with 561 variables per row
#y_test show what activity was being performed during each sample per row
#sub_test is the subject number in the sample run - 1-30 subjects (people)
X_Test <- data.frame()
X_Test <- read.csv("./UCI HAR Dataset/test/x_test.csv")
Y_Test <- data.frame()
Y_Test <- read.csv("./UCI HAR Dataset/test/y_test.csv")
Sub_Test <- data.frame()
Sub_Test <- read.csv("./UCI HAR Dataset/test/subject_test.csv")

#read in features.csv converted from text to create column names for X Test/Train dataset
Features <- data.frame()
Features <- read.csv("./UCI HAR Dataset/features.csv", check.names = FALSE, header = FALSE)

#read in activity labels.csv converted from text to rename for descriptive names later in final dataset
Act_Names <- data.frame()
Act_Names <- read.csv("./UCI HAR Dataset/activity_labels.csv", check.names = FALSE, header = FALSE)

#remove numeric characters before the space in each variable name
Features <- sub(".+? ", "", Features$V1)

#transform features file to create single row of data
Features <- t(Features)
write.csv(Features, "./UCI HAR Dataset/New Features.csv")

#rename column names in X_Test to match feature data file
colnames(X_Test) <- c(Features[1, 1:561])

#subset and filter for columns with only mean, Mean, std, or Std in column names
filtered_Test <- X_Test[,grepl("mean|Mean|std|Std", names(X_Test))]

#column bind the three files created above to create a new "imported test" file
imported_Test <- cbind(Y_Test, filtered_Test)
imported_Test <- cbind(Sub_Test, imported_Test)

#save merged data to a csv file to create a combined tidy data set for later inspection
write.csv(imported_Test, file = "./UCI HAR Dataset/test/imported_test.csv")

#rename header in filtered columns to match data provided by UCI Dataset "features.txt" file
names(imported_Test)[1] <- "Subject_Number"
names(imported_Test)[2] <- "Activity"

#save filtered test data to a csv file to create a small data set prior to merging with train data
write.csv(imported_Test, file = "imported_test.csv")

#repeat process for training data set

#read in csv files for X, Y, and Subject Train that were imported into Excel from the provided UCI text files
#x_train is the raw data results for each subject with 561 variables per row
#y_train show what activity was being performed during each sample per row
#subject_train is the subject number in the sample run - 1-30 subjects (people)
X_Train <- data.frame()
X_Train <- read.csv("./UCI HAR Dataset/train/x_train.csv")
Y_Train <- data.frame()
Y_Train <- read.csv("./UCI HAR Dataset/train/y_train.csv")

#subset and filter for columns with only mean or std in column names
Sub_Train <- data.frame()
Sub_Train <- read.csv("./UCI HAR Dataset/train/subject_train.csv")

#rename column names to match feature data file in X_Train
colnames(X_Train) <- c(Features[1, 1:561])

#subset and filter for columns with only mean or std in column names
filtered_Train <- X_Train[,grepl("mean|Mean|std|Std", names(X_Train))]

#column bind the three files created above to create a new "imported test" file
imported_Train <- cbind(Y_Train, filtered_Train)
imported_Train <- cbind(Sub_Train, imported_Train)

#save merged data to a csv file to create a combined tidy data set for later inspection
write.csv(imported_Train, file = "./UCI HAR Dataset/train/imported_train.csv")

#rename header in filtered columns to match data provided by UCI Dataset "features.txt" file
names(imported_Train)[1] <- "Subject_Number"
names(imported_Train)[2] <- "Activity"

#merge data sets but ensure we only use common columns names to avoid issues with rbind
cols <- intersect(colnames(imported_Test), colnames(imported_Train))
mergedBodyData <- rbind(imported_Test[,cols], imported_Train[,cols])

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
finalSubjectData_i <- data.frame()
subjectData_i <- ordered_Bodydata[ordered_Bodydata$Subject_Number == i,]

  #add second for loop for processing activity numbers (1-6) in each subject number run
  for (isub in 1:6) {
    
    #read in each activity number per subject, calcuate mean, and transpose data back in row format
    activityData_isub <- subjectData_i[subjectData_i$Activity == isub,] 
    meansubject_isub <- colMeans(activityData_isub)
    transposeSubject_isub <- t(meansubject_isub)
  
    #recursively rbind each mean tidy data set for each subject number
    finalSubjectData_i <- rbind(finalSubjectData_i, transposeSubject_isub)
    
  }

#rename column data in finalSubjectData_i for descriptive names using the activity labels file from UCI dataset
finalSubjectData_i$Activity <- Act_Names$V2

#recursively rbind each mean tidy data set for each subject number
finalTidyDataSet <- rbind(finalTidyDataSet, finalSubjectData_i)

#recursively update the final dataset file for each subject number and save file for inspection
#file should contain six activity rows for each of the 30 subject numbers (people) (180 total data rows)
#column results appear for the mean of each of the activities for each subject number
write.csv(finalTidyDataSet, file = "finalTidyDataSet.csv")

}

#read in csv file and convert to text file per assignment submission instructions
convertFileTxt <- read.csv("finalTidyDataSet.csv", check.names = FALSE)
write.table(convertFileTxt, "finalTidyDataSet.txt", row.names = FALSE, sep = "\t")
