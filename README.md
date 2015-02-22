# GCD_CourseProjectPasBesoin
Course Project for Getting and Cleaning Data course

Prep
====
Download the dataset from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
and unzip it; place it at the top of the repo. It should be called
"UCI HAR Dataset". This directory will be ignored by Git and will not be added to the repo.

Running
=======
There is only one script. Run it like so:

`R CMD BATCH run_analysis.R`

It produces an output file titled `gcd_course_project_tidy_means.txt` (which I have
also uploaded separately)`.

You can read in the data like so:
`tidyData <- read.table("gcd_course_project_tidy_means.txt", header=T)``

Codebook
========

See the file Codebook.md for a codebook for this data.

How the script works
====================

Step 1 is done by `merge_step1()`. For each directory, test and train, the function `get_data_for_subset()`
reads in the main data file eg `X_test.txt
as well as the activity number file and the subject number file (eg `y_test.txt` and
`subject_test.txt`) and uses `cbind()` to put them together, and gives the results column
names according to features.txt. It then `rbind()`s the two sets of data.

Step 2, done by `extract_mean_and_std_step2()`, uses `grep()` to take just those observation variables that include `-mean()`
or `-std()` in their name.

Step 3, done by `label_activities_step3()`, uses the activity_labels.txt file to replace numbers
with strings (factors, really) for the Activity. It uses `merge()`.

Step 4, done by `label_variables_step4()`, uses some logic to change the column names from
things like `tBodyAcc-mean()-Y` to things like `Mean.Y.axis.of.acceleration.due.to.body`.
It uses a couple of helper functions to do this.

Step 5 is done by `tidy_dataset_step5()` and it does uses `split` and `lapply` to compute the mean
for each variable across each combination of (activity, subject number). This is then put
back into matrix form with some dark magic.

The function `do_all_the_work()` runs all of these in order and writes the result out to disk.

When imported the script runs `do_all_the_work()` automatically. As a bonus, it keeps the
produced matrix in the variable `tidyData`.
