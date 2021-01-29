# Peer-Review-Assignment
G&amp;C Data Week 4 Peer Review
he  R script, run_analysis.R, and works like this:

Read both the train and test datasets and merge them into x(measurements), 
y(activity) and subject, respectively.
cbind binds the first class of data in step 1 and then binds the already bound data into allData data set
Load the data feature, activity info and extract columns named 'mean'(-mean) and 'standard'(-std). 

Add column names to descriptive. (-mean to Mean, -std to Std, and remove symbols like -, (, ))
Extract data by selected columns(from step 3), and merge x, y(activity) and subject data. Also, replace y(activity) 
column to it's name by refering activity label (loaded step 3).
Generate 'Tidy Dataset' that consists of the average (mean) of each variable for each subject and each activity. 
The result is shown in the file tidy_dataset.txt.
