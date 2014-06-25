library(reshape2)
library(plyr)

#Step 1: Extract Test data and Training Data and Merges the sets to create one data set.

## Read in test file

subject <- read.table("test//subject_test.txt",sep=" ")
Xdata <- read.table("test//X_test.txt")
Ydata <- read.table("test//y_test.txt",sep=" ")
testdata <- cbind(subject, Ydata, Xdata)


## Read in train file

subject <- read.table("train//subject_train.txt",sep=" ")
Xdata <- read.table("train//X_train.txt")
Ydata <- read.table("train//y_train.txt",sep=" ")
traindata <- cbind(subject, Ydata, Xdata)

totaldata <- rbind(testdata, traindata)
names(totaldata) <- c("Subject_id","Activity_id")
 
# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement
# Required columns containing "mean()" and "std()" , also "meanFreq()" are extracted
features <- read.table("features.txt", sep="",stringsAsFactors=F)
colExtract <- c(grep(("mean\\(\\)|std\\(\\)|meanFreq\\(\\)"),features[,2]))

newdata <- totaldata[,c(c(1,2),colExtract+2)]
#newdata <- melt(alldata, id=colnames(alldata[c(1,2)]),measure.vars=colnames(alldata[,rowreq+2]))

# Step 3: Uses descriptive activity names to name the activities in the data set

activitylab <- read.table("activity_labels.txt", sep="",stringsAsFactors=F)

newdata$Activity_id <- as.factor(newdata$Activity_id)
levels(newdata$Activity_id) <- activitylab[,2]

# Step 4: Appropriately labels the data set with descriptive variable names. 
colnames(newdata) <- c("Subject_id","Activity_id",features[,2][colExtract])

# Step 5: Creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.
# Melt data
datamelt <- melt(newdata, id=colnames(newdata[c(1,2)]), 
                 measure.vars=colnames(newdata[,3:length(names(newdata))]))
# Calculate Mean
datameltmean <- ddply(datamelt, .(Subject_id, Activity_id, variable), summarize, mean=mean(value))

## Recast Data
final <- dcast(datameltmean, Subject_id + Activity_id ~ variable, value.var="mean")

## Export tidy data set as text csv
write.table(final, file="TidyData.txt", row.names=FALSE, sep=",")

