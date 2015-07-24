
The script run_analysis.R performs the 5 steps described in the course project's definition.

Step 1 merging the training and test sets
    The data gathered during the Test of the experience ('subject_test.txt, X_test.txt, y_test.txt') have been merged in a dataset called datasetTest
    The data gathered during the Training of the experience ('subject_train.txt, X_train.txt, y_train.txt') have been merged in a dataset called datasetTrain
    
    The names of 2 identified columns in both datasets have been renamed  appropriately 'subject' 'activity'
    'subject' column was identified as column 1 in both datasets and 'activity' column was identified as column 564
    
    The document 'features.txt' was imported in a dataset, the second column was identified as containing the names of the tests which were gathered in a 'vector'
    
    Using the 'plyr' library, the columns of the two datasets containing the information were renamed from the 'features.txt' document
    
    The two datasets were then merged in a single one named 'dataT'
    Two redundant columns were then removed from 'datasetTest' and 'datasetTrain' column 'V1'
    The duplicated columns prohibiting the use of the select command were then removed, those column were of no use for the exercise
    
Step 2, extracting only mean and std for each measurement
    using 'dplyr' library 'dataT' was arranged and only the columns containing mean or std were kept using a 'select' command.
    
Step 3 Uses descriptive activity names to name the activities in the data set
    All the observations of the activity variable were renamed according to the request.
    
Step 4 renaming columns names
    In order to conserve our worked data set a second has been created containing only the names of the columns.
    all columns ranging from position 2 to position 88 were renames using more human readable names through a serie of operations.
    Then the new and friendly names of columns were implemented back to our main data set.
    
Step 5 create a second data set with the average of each variable for each activity and each subject
    Using the 'reshape2' library, the melt command was applied to the data set using 'subject' and 'activity' as id and the names of the columns ranging from 3 to 88 'colnames(datas[,3:88])'
    Then the dcast function was used to extract the mean of each variable for each activity and each subject (30 subjects * 6 activities = 180 rows)
    
Variables

    x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
    datasetTest and datasetTrain merge the previous datasets for each analysis, test and train.
    features contains the correct names for the dfeature dataset, which are used to rename the column names of datasetTest and datasetTrain.
    dataT if the data set of the merged previous data sets.
    The file average_data.txt contains the exported observation of the mean of each variable for each subject and each activity
