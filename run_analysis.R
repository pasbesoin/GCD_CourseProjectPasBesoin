# This is the key file for the Course Project of the Getting and Cleaning
# Data course.
#
# Follow the instructions in the README.md to get the raw data upon which
# this acts.

# Course project instructions:
#   1. Merge the training and the test sets to create one data set.
#   2. Extract only the measurements on the mean and standard deviation for
#      each measurement.
#   3. Use descriptive activity names to name the activities in the data set.
#   4. Appropriately label the data set with descriptive variable names. 
#   5. From the data set in step 4, create a second, independent tidy data
#      set with the average of each variable for each activity and each
#      subject.
#
# I have broken each one of these out into separate functions. There are also
# quite a few helper functions.

### Run this script by running "R CMD BATCH run_analysis.R" at the command
### line.

require(plyr)

DATA_DIR <- "UCI HAR Dataset"

FEATURES_INFO_FILE <- file.path(DATA_DIR, "features.txt")	
ACTIVITY_LABELS_FILE <- file.path(DATA_DIR, "activity_labels.txt")	

# When we select for just the columns that are measurements on the mean and
# standard deviations, I am not including the angle measurements on things
# ending in "Mean". I am selecting here for anything that includes "-mean()"
# or "-std()". This looks ugly because we need to escape each paren with a
# backslash (because they are meta-characters) and then we need to escape
# the backslashes (because R interprets backslashes in strings in its own,
# Unix-y way).

MEAN_STD_REGEX <- "-mean\\(\\)|-std\\(\\)"


# Reads the column names for the main data from the "features.txt" file
get_feature_col_names <- function() {
	featuresData <- read.table(FEATURES_INFO_FILE, stringsAsFactors=F)
	featuresData[, 2]
}

# Abstracts out the code for importing data for test or train from each
# directory and collecting the measurement data, the activity class, and
# the subject number into one table.
#
# The first two columns are activity class and subject number; the rest are
# the measurements.
#
# subset_name should be either "test" or "train" for this assignment.
get_data_for_subset <- function(subset_name) {
	mainDataFilename <- paste0("X_", subset_name, ".txt")
	activityClassFilename <- paste0("y_", subset_name, ".txt")
	subjectNumberFilename <- paste0("subject_", subset_name, ".txt")

	# create the full (relative) path to the data files:
	mainDataFile <- file.path(DATA_DIR, subset_name, mainDataFilename)
	activityClassFile <- file.path(DATA_DIR, subset_name, activityClassFilename)
	subjectNumberFile <- file.path(DATA_DIR, subset_name, subjectNumberFilename)

	testData <- read.table(mainDataFile, colClasses=c("numeric"))

	# col.names arg to read.table changes the values! So we do this instead:
	colnames(testData) <- get_feature_col_names()

	activityClassCol <- read.table(activityClassFile, col.names=c("Activity.Class"))
	subjectNumberCol <- read.table(subjectNumberFile, col.names=c("Subject.Number"))
	allData <- cbind(activityClassCol, subjectNumberCol, testData)
	return(allData)
}

# This merges the two data sets as required in step 1; it also provides
# somewhat descriptive column names, thus fulfilling step 4.
merge_step1 <- function() {
	testData <- get_data_for_subset("test")
	trainData <- get_data_for_subset("train")
	rbind(testData, trainData)
}

extract_mean_and_std_step2 <- function(combinedData) {
	colNames <- colnames(combinedData)

	# Keep the first two columns, activity class and subject number
	columnsIndicesToKeep <- c(1:2, grep(MEAN_STD_REGEX, colNames))

	combinedData[, colNames[columnsIndicesToKeep]]
}

# Activity.Class is a number from 1 to 6. From ACTIVITY_LABELS_FILE we load
# factor names to use instead. We return a table with an "Activity.Name"
# column that replaces the previous "Activity.Class" column.
label_activities_step3 <- function(narrowedData) {
	activityLabels <- read.table(ACTIVITY_LABELS_FILE,
		col.names=c("Activity.Class", "Activity.Name")
	)
	merged <- merge(activityLabels, narrowedData)
	merged[, colnames(merged) != "Activity.Class"]
}

# This table has 68 columns: Activity.Name, Subject.Number, and then 66 cols
# that look like "tBodyAcc-std()-Y". We give nicer descriptions to these 66.
label_variables_step4 <- function(data) {
	colNames <- colnames(data)
	newColNames <- unname(sapply(colNames, make_nice_column_name))
	colnames(data) <- newColNames
	return(data)
}

# For some of the fields there appears to be a typo - "Body" is duplicated.
# We handle these.
column_part_translate <- function(colpart) {
	if (substring(colpart, 1, 8) == 'BodyBody') {
		colpart <- substring(colpart, 5)
	}
	retval <- switch(colpart,
		"BodyAcc" = "acceleration.due.to.body",
		"BodyAccJerk" = "jerks.due.to.body",
		"BodyGyro" = "body.gyroscope.signal",
		"BodyGyroJerk" = "jerks.in.body.gyroscope.signal",
		"GravityAcc" = "acceleration.due.to.gravity"
	)
	if (!is.null(retval)) {
		return(retval)
	}
	return(colpart)
}

# We take column names like "tBodyAcc-mean()-Y" and turn them into things
# like "Mean.Y.axis.of.acceleration.due.to.body".
#
# We check the first letter to see if this is 't' for time (regular) or
# 'f' for frequency data. Then we split by '-' and examine each piece.
make_nice_column_name <- function(colname) {
	firstLetter <- substring(colname, 1, 1)
	if (! firstLetter %in% c('t', 'f')) {
		return(colname);   # leave it alone
	}
	pieces <- strsplit(colname, '-')[[1]]
	if (! pieces[2] %in% c("mean()", "std()")) {
		return(colname)
	}

	niceName <- if (pieces[2] == "mean()") {
		"Mean"
	} else {
		"Stddev.of"
	}
	if (!is.na(pieces[3])) {
		niceName <- paste(niceName, pieces[3], "axis", "of", sep=".")
	}
	variable <- substring(pieces[1], 2)   # remove the initial "t" or "f"

	# If it ends in "Mag", trim and include "magnitude.of" in the nice name
	if (substring(variable, nchar(variable) - 2) == 'Mag') {
		niceName <- paste(niceName, "magnitude", "of", sep=".")
		variable <- substring(variable, 1, nchar(variable) - 3)
	}

	if (firstLetter == 'f') {
		niceName <- paste(niceName, "frequency", "of",
			column_part_translate(variable), sep='.'
		)
	} else {
		niceName <- paste(niceName, column_part_translate(variable), sep='.')
	}
	return(niceName)
}

# Remember the definition of tidy:
# Each variable should be in one column.
# Each different observation of that variable should be in a different row.
#
# We are asked for "the average of each variable for each activity and each
# subject."
#
# I'm choosing to do the "wide" format. We will calculate the averages for
# each set of (subject, activity). This will generate 180 rows by 66 columns
# of raw data (plus two columns of identifying information - subject and
# activity).

tidy_dataset_step5 <- function(data) {
	# Split by activity and subject number. We do data[, 3 : <end>]
	# so that the activity and subject number values are not in the
	# splitted data itself.
	colNames <- colnames(data)
	splitted <- split(data[, 3 : ncol(data)],
		c(data["Activity.Name"], data["Subject.Number"])
	)

	# This applies mean() across all columns
	allMeans <- lapply(splitted, colMeans)

	# This funky thing turns this list into a data frame:
	# See http://stackoverflow.com/questions/4227223/r-list-to-data-frame
	rawDf <- do.call(rbind.data.frame, allMeans)

	# We take the rownames (now in the format "WALKING.30") and turn
	# them back into the Activity Name and Subject Number columns:
	identifierList <- strsplit(rownames(rawDf), '\\.')

	# Do the same dataframe trick:
	identifierDf <- do.call(rbind.data.frame, identifierList)
	matrixOfMeans <- cbind(identifierDf, rawDf)

	# Now we give it back its column names:
	colnames(matrixOfMeans) <- colNames

	matrixOfMeans
}

do_all_the_work <- function() {
	combined <- merge_step1()
	narrowed <- extract_mean_and_std_step2(combined)
	labeled <- label_activities_step3(narrowed)
	labeled2 <- label_variables_step4(labeled)
	tidy <- tidy_dataset_step5(labeled2)
	write.table(tidy, file="gcd_course_project_tidy_means.txt", row.name=F)
	tidy
}

tidyData <- do_all_the_work()
