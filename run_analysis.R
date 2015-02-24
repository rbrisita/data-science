# Course Project run_analysis.R

# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# File names
featuresFile = 'features.txt'
activityFile = 'activity_labels.txt'

testXFile = 'test/X_test.txt'
testYFile = 'test/Y_test.txt'
testSubjectFile = 'test/subject_test.txt'

trainXFile = 'train/X_train.txt'
trainYFile = 'train/Y_train.txt'
trainSubjectFile = 'train/subject_train.txt'

# Read data and store into data.frames
columnNames = read.table(featuresFile, stringsAsFactors = FALSE)
activities = read.table(activityFile, stringsAsFactors = FALSE)

testX = read.table('test/X_test.txt', stringsAsFactors = FALSE)
testY = read.table('test/Y_test.txt', stringsAsFactors = FALSE)
testSubject = read.table('test/subject_test.txt', stringsAsFactors = FALSE)

trainX = read.table('train/X_train.txt', stringsAsFactors = FALSE)
trainY = read.table('train/Y_train.txt', stringsAsFactors = FALSE)
trainSubject = read.table('train/subject_train.txt', stringsAsFactors = FALSE)


# Name data appropriately
names(testSubject) = c('subject')
names(trainSubject) = c('subject')

names(testX) = as.character(columnNames$V2)
names(trainX) = as.character(columnNames$V2)

# Map numerical values to activity lables
names(testY) = c('activity')
names(trainY) = c('activity')
for(i in 1:nrow(activities))
{
	testY[testY == i, ] = activities[,2][i]
	trainY[trainY == i, ] = activities[,2][i]
}


# Get working set columns
wsColNames = grep('.+-mean()|.+-std()', names(trainX), value=TRUE)

wsTestX = testX[, wsColNames]
wsTrainX = trainX[, wsColNames]


# Merge Data
wsTest = cbind(wsTestX, testY$activity)
wsTrain = cbind(wsTrainX, trainY$activity)

wsTest = cbind(wsTest, testSubject$subject)
wsTrain = cbind(wsTrain, trainSubject$subject)

# Error
#wsAll = rbind(wsTest, wsTrain)


