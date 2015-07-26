### Repository information

This repository consist of the following files:
<ul>
<li>README.md - Explains repository contents and script information</li>
<li>CodeBook.md - Explains steps to reproduce results and other information</li>
<li>run_analysis.R - Main R script for the analysis</li>
</ul>

### Script details
The run_analysis.R script fulfills the following requirements:
<ol>
<li>Merges the training and the test sets to create one data set.</li>
<li>Extracts only the measurements on the mean and standard deviation for each measurement.</li>
<li>Uses descriptive activity names to name the activities in the data set</li>
<li>Appropriately labels the data set with descriptive variable names. </li>
<li>From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.</li>
</ol>

The script itself performs the steps in the following manner:
<ul>
<li>Load dplyr library</li>
<li>Read the required files into memory</li>
<li>Create descriptive names for them</li>
<li>Add an activity column to the y tables so it contains both the ID and activity name</li>
<li>Remove columns that are not needed from the test and training tables</li>
<li>Combine the tables from different files to form a complete test data set and training data set</li>
<li>Combine the test and training sets into one main table</li>
<li>Remove columns from the table that are not necessary for the new data set we are creating</li>
<li>Create the final second_table using summarise_each()</li>
<li>Write the result to a file called "second_table.txt"</li>
</ul>