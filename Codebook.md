Codebook for Getting and Cleaning Data Course Project
=====================================================

Instructions on getting the data and how the script works are in `README.md`.

The original data represent linear acceleration and angular velocity in 3 dimensions. The linear acceleration is broken out into
components attributed to gravity and those attributed to the body's movements. The data is recorded as regular,
time-series data and as Fourier-transformed frequency data. The mean and standard deviation were calculated from all measurements in one experiment, among other statistics.

Transformations I did
---------------------

I took this data and selected only the mean and standard deviation data for all variables. I commbined both the test and the training data into one set. Then I averaged all values for each set of (activity, subject number), made the column names more human-understandable, and used activity names rather than numbers to produce the end result of
a summary table: 180 rows of 68 columns. The 180 rows are 30 subjects times 6 activities.

The output file `gcd_course_project_tidy_means.txt` contains two factor columns:

1. Activity.Name - the name of the activity engaged in when the data was taken. Is one of:
        LAYING
        SITTING
        STANDING
        WALKING
        WALKING_DOWNSTAIRS
        WALKING_UPSTAIRS

2. Subject.Number - the anonymized reference to the experimental subject. This is a number from 1 to 30 inclusive.

The other 66 columns are all numeric data, derived from the UCI Human Activity Recognition dataset (see http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The units match the units of the incoming data. These 66 columns are:

 * Mean.X.axis.of.acceleration.due.to.body
 * Mean.Y.axis.of.acceleration.due.to.body
 * Mean.Z.axis.of.acceleration.due.to.body
 * Stddev.of.X.axis.of.acceleration.due.to.body
 * Stddev.of.Y.axis.of.acceleration.due.to.body
 * Stddev.of.Z.axis.of.acceleration.due.to.body

Mean and standard deviation of linear acceleration in X, Y, and Z directions due to the body's own movements.

 * Mean.X.axis.of.acceleration.due.to.gravity
 * Mean.Y.axis.of.acceleration.due.to.gravity
 * Mean.Z.axis.of.acceleration.due.to.gravity
 * Stddev.of.X.axis.of.acceleration.due.to.gravity
 * Stddev.of.Y.axis.of.acceleration.due.to.gravity
 * Stddev.of.Z.axis.of.acceleration.due.to.gravity

Mean and standard deviation of linear acceleration in X, Y, and Z directions due to gravity.

 * Mean.X.axis.of.jerks.due.to.body
 * Mean.Y.axis.of.jerks.due.to.body
 * Mean.Z.axis.of.jerks.due.to.body
 * Stddev.of.X.axis.of.jerks.due.to.body
 * Stddev.of.Y.axis.of.jerks.due.to.body
 * Stddev.of.Z.axis.of.jerks.due.to.body

Mean and standard deviation of jerks in X, Y, and Z directions due to the body's own movements.

 * Mean.X.axis.of.body.gyroscope.signal
 * Mean.Y.axis.of.body.gyroscope.signal
 * Mean.Z.axis.of.body.gyroscope.signal
 * Stddev.of.X.axis.of.body.gyroscope.signal
 * Stddev.of.Y.axis.of.body.gyroscope.signal
 * Stddev.of.Z.axis.of.body.gyroscope.signal

Mean and standard deviation of angular momentum in X, Y, and Z directions. These are assumed, reasonably, to be all due to the body's own movements.

 * Mean.X.axis.of.jerks.in.body.gyroscope.signal
 * Mean.Y.axis.of.jerks.in.body.gyroscope.signal
 * Mean.Z.axis.of.jerks.in.body.gyroscope.signal
 * Stddev.of.X.axis.of.jerks.in.body.gyroscope.signal
 * Stddev.of.Y.axis.of.jerks.in.body.gyroscope.signal
 * Stddev.of.Z.axis.of.jerks.in.body.gyroscope.signal

Mean and standard deviation of jerks in the angular momentum in X, Y, and Z directions. These are assumed, reasonably, to be all due to the body's own movements.

 * Mean.magnitude.of.acceleration.due.to.body
 * Stddev.of.magnitude.of.acceleration.due.to.body

Mean and standard deviation of total magnitude of linear acceleration due to the body's movements.

 * Mean.magnitude.of.acceleration.due.to.gravity
 * Stddev.of.magnitude.of.acceleration.due.to.gravity

Mean and standard deviation of total magnitude of linear acceleration due to gravity.

 * Mean.magnitude.of.jerks.due.to.body
 * Stddev.of.magnitude.of.jerks.due.to.body

Mean and standard deviation of total magnitude of jerks in linear acceleration due to the body's movements.

 * Mean.magnitude.of.body.gyroscope.signal
 * Stddev.of.magnitude.of.body.gyroscope.signal

Mean and standard deviation of total magnitude of angular momentum due to the body's movements.

 * Mean.magnitude.of.jerks.in.body.gyroscope.signal
 * Stddev.of.magnitude.of.jerks.in.body.gyroscope.signal

Mean and standard deviation of total magnitude of jerks in the angular momentum due to the body's movements.

 * Mean.X.axis.of.frequency.of.acceleration.due.to.body
 * Mean.Y.axis.of.frequency.of.acceleration.due.to.body
 * Mean.Z.axis.of.frequency.of.acceleration.due.to.body
 * Stddev.of.X.axis.of.frequency.of.acceleration.due.to.body
 * Stddev.of.Y.axis.of.frequency.of.acceleration.due.to.body
 * Stddev.of.Z.axis.of.frequency.of.acceleration.due.to.body

Mean and standard deviation of FFT-transposed linear acceleration in X, Y, and Z directions due to the body's own movements.

 * Mean.X.axis.of.frequency.of.jerks.due.to.body
 * Mean.Y.axis.of.frequency.of.jerks.due.to.body
 * Mean.Z.axis.of.frequency.of.jerks.due.to.body
 * Stddev.of.X.axis.of.frequency.of.jerks.due.to.body
 * Stddev.of.Y.axis.of.frequency.of.jerks.due.to.body
 * Stddev.of.Z.axis.of.frequency.of.jerks.due.to.body

Mean and standard deviation of jerks in the FFT-transposed linear acceleration in X, Y, and Z directions due to the body's own movements.

 * Mean.X.axis.of.frequency.of.body.gyroscope.signal
 * Mean.Y.axis.of.frequency.of.body.gyroscope.signal
 * Mean.Z.axis.of.frequency.of.body.gyroscope.signal
 * Stddev.of.X.axis.of.frequency.of.body.gyroscope.signal
 * Stddev.of.Y.axis.of.frequency.of.body.gyroscope.signal
 * Stddev.of.Z.axis.of.frequency.of.body.gyroscope.signal

Mean and standard deviation of FFT-transposed angular momentum in X, Y, and Z directions due to the body's own movements.

 * Mean.magnitude.of.frequency.of.acceleration.due.to.body
 * Stddev.of.magnitude.of.frequency.of.acceleration.due.to.body

Mean and standard deviation of total magnitude of FFT-transposed linear acceleration due to the body's movements.

 * Mean.magnitude.of.frequency.of.jerks.due.to.body
 * Stddev.of.magnitude.of.frequency.of.jerks.due.to.body

Mean and standard deviation of total magnitude of jerks in the FFT-transposed linear acceleration due to the body's movements.

 * Mean.magnitude.of.frequency.of.body.gyroscope.signal
 * Stddev.of.magnitude.of.frequency.of.body.gyroscope.signal

Mean and standard deviation of total magnitude of FFT-transposed angular momentum due to the body's movements.

 * Mean.magnitude.of.frequency.of.jerks.in.body.gyroscope.signal
 * Stddev.of.magnitude.of.frequency.of.jerks.in.body.gyroscope.signal
 
 Mean and standard deviation of total magnitude of jerks in the FFT-transposed angular momentum due to the body's movements.
 