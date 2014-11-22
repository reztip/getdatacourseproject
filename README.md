#README

For this file, there is only one script.  The run_analysis script.  For a breakdown of steps, see below. See the markdown file for an explanation of the data: in includes README information from the data's source.

#$Pre-processing the data- NOTE THROUGHOUT THE PROJECT, ALL UNITS ARE KEPT THE SAME AS IN THE ORIGINAL DATA

*First, this script sets the directory to my data directory.

*Next, the activity data names are parsed into a vector.  This will we used for identification purposes later.

*The features dataset, which summarizes all of the data by types of calculations is then parsed.  The names here represent the columns in the large X_train and X_test datasets.

*The desired features variable gives the full list of column names in the datasets that have a desired standard deviation or mean attached.

##Processing the test data
*The X_test, y_test and subject test datasets are parsed.

*The subject test information includes labels on the test subjects, relevant for identifying individuals observed.

*The Xtestdata variable only includes the columns of the X_data which included mean or standard deviation values.

*Y_test is then identified as a set of columns that identify the activity ids and labels.  These are important in identifying which activity is performed in each Xtestdata variable.

*The subject_test, y_test and x_test data variables are column bound.  The subject_test and y_test variables exist for identification.

##Processing the train data

*The same set of instructions applies for the train data as did the test data.

##Data merging and aggregation

The reshape libraries are required.

*First, the test and train data are column-bound (Stacked on top of eeach other).  The subject id still uniquely identifies who is in which group: test or control.

*The data is then melted.  Type ?melt in R for more information.  The identification variables are those from the subject and y_test/train data, and the measure variables are all the other X columns that pass the desired feature threshold.

*The data is then casted.  Type ?dcast in R for more info.  The melted data is esentially recast:  subject_ids and activity labels jointly form the identifying criteria.  Reported then are all the other variables.  All of the variables are actually summarized using the mean function, as desired.

*Finally, the data is written out using a write.table function.  The row.name parameter was set as true in order to keep the variable names that existed in the features dataset.  Otherwise it might get confusing.
