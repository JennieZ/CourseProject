#------------------- Step 1 -----------------------------------------------
#Read train data, labels and subjects
traindata <- read.table("./train/X_train.txt", header = FALSE)
trainlabel <- read.table("./train/y_train.txt", header = FALSE)
trainsubject <- read.table("./train/subject_train.txt", header = FALSE)
train <- cbind(traindata, trainlabel, trainsubject)
rm(traindata, trainlabel, trainsubject)

#Read test data, labels and subjects
testdata <- read.table("./test/X_test.txt", header = FALSE)
testlabel <- read.table("./test/y_test.txt", header = FALSE)
testsubject <- read.table("./test/subject_test.txt", header = FALSE)
test <- cbind(testdata, testlabel, testsubject)
rm(testdata, testlabel, testsubject)

#Read features
features <- read.table("./features.txt", header = FALSE)
colnames <- as.character(features[,2])
colnames <- c(colnames,"activity","subject")
rm(features)

#Merge train and test data sets and update column names
data <- rbind(test, train)
rm(train, test)
names(data) <- colnames
rm(colnames)

#------------------- Step 2 -----------------------------------------------
#Subset only mean and standard deviation data
meancols <- grep("mean\\(", names(data))
stdcols <- grep("std\\(", names(data))
columns <- sort(c(meancols, stdcols, 562:563))
subset <- data[,columns]
rm(meancols, stdcols, columns, data)

#------------------- Step 3 -----------------------------------------------
#Replace activity values with activity labels
labels <- read.table("./activity_labels.txt", header = FALSE)
activities <- as.character(labels[,2])
subset$activity <- factor(subset$activity, levels = 1:6, labels = activities)
rm(labels, activities)

#------------------- Step 4 -----------------------------------------------
#Add descriptive variable names
varnames <- names(subset)
varnames <- gsub("^([t|f])(.+)-(.+)\\(\\)-(.)", "\\2 \\3 in \\1 on the \\4 axis", varnames)
varnames <- gsub("^([t|f])(.+)-(.+)\\(\\)$", "\\2 \\3 in \\1", varnames)
varnames <- gsub("^(.+)(Jerk|JerkMag)", "\\2 of \\1", varnames)
varnames <- gsub("^(.+(Acc|Gyro))(Mag)", "\\3 of \\1", varnames)
varnames <- gsub("Acc", " acceleration", varnames)
varnames <- gsub("Gyro", " angular velocity", varnames)
varnames <- gsub("std", "standard deviation", varnames)
varnames <- gsub("JerkMag", "jerk magnitude", varnames)
varnames <- gsub("Mag", "magnitude", varnames)
varnames <- gsub("in t", "in time", varnames)
varnames <- gsub("in f", "in frequency", varnames)
varnames <- gsub("BodyBody", "body", varnames)
varnames <- tolower(varnames)
names(subset) <- varnames

#------------------- Step 5 -----------------------------------------------
#Reshape data
subsetMelt <- melt(subset, id = varnames[67:68], measure.vars = varnames[1:66])
tidy <- dcast(subsetMelt, activity + subject ~ variable, mean)

#--------------------------------------------------------------------------
write.table(tidy, file = "./tidydata.txt", row.names = FALSE)
