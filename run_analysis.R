

library(plyr)
library(reshape2)

# all have 7352 records, train_values has 561 columns

train_values <- read.table('train/X_train.txt',header=FALSE)
train_label <- read.table('train/y_train.txt',header=FALSE)	# 1 numeric column
train_subject <- read.table('train/subject_train.txt',header=FALSE) # 1 numeric column


# all have 2947 records, test_values has 561 columns

test_values <- read.table('test/X_test.txt',header=FALSE)
test_label <- read.table('test/y_test.txt',header=FALSE)	# 1 numeric column
test_subject <- read.table('test/subject_test.txt',header=FALSE)	# 1 numeric column

# read in 2 general files

features <- read.table('features.txt',header=FALSE)     # has 561 occurrences of 2 columns
activity_labels <- read.table('activity_labels.txt',header=FALSE) # has 6 occurrences of 2 cols

# quick check for nulls

sum(is.na(test_values))
sum(is.na(train_values))

# change the names to something I can understand

colnames(features) <- c('feature_id','feature_name')
colnames(activity_labels) <- c('activity_id','activity_name')

colnames(train_label) <- 'activity_id'
colnames(test_label) <- 'activity_id'

colnames(train_subject) <- 'subject_id'
colnames(test_subject) <- 'subject_id'

#merge the activities and their labels

train_label_1 <- join(train_label,activity_labels,by='activity_id')
test_label_1 <- join(test_label,activity_labels,by='activity_id')

# pick out feature_ids for 'mean' and 'std' features, and convert from factor to char

wanted_features <- subset(features,grepl("(mean|std)",tolower(feature_name)))

i <- sapply(wanted_features, is.factor)
wanted_features[i] <- lapply(wanted_features[i], as.character)

# only keep the values I want - mean and std

test_values_1 <- test_values[wanted_features$feature_id]
train_values_1 <- train_values[wanted_features$feature_id]

# meaningful variable names

for (i in 1:nrow(wanted_features)) {
	colnames(train_values_1)[i] <- wanted_features$feature_name[i]
	colnames(test_values_1)[i] <- wanted_features$feature_name[i]
}
 
# merge all into the measurements data frames

train_values_2 <- cbind(train_subject$subject_id,train_label_1$activity_name,train_values_1)
test_values_2 <- cbind(test_subject$subject_id,test_label_1$activity_name,test_values_1)

# rename the columns that were added back to what I want -is there a better way to do this?

colnames(train_values_2)[1:2] <- c('subject_id','activity_name')
colnames(test_values_2)[1:2] <- c('subject_id','activity_name')

# merge train and test into one df

all_values <- rbind(test_values_2,train_values_2)

# create a 2nd, independent tidy data set with the average of each variable for each
#  activity and each subject

values_melt <- melt(all_values,id=c('subject_id','activity_name'))

all_tidy <- ddply(values_melt, .(subject_id, activity_name, variable),
 summarize, mean=mean(value))

# write the table - there are commas in the text, so use default colsep

write.table(all_tidy,'all_tidy.txt', row.names = FALSE) 








