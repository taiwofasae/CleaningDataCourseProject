Getting & Cleaning Data Course Project
===========================================

Code Book
============

*Data Structure*  
Data is in 81 cols and 180 rows
- Columns 1: subject
- Columns 2: Activity
- Columns 3 to 68 contain the experimental data
- Experimental data was normalised and bounded to [-1,1]

**Column 1: Subject_id**  
A number from 1 to 30 that links to the test person in the experiment.


**Column 2: Activity_id**  
1 of 6 activities that define the activity the subject was doing when the measurements were taken  
1. WALKING: subject was walking  
2. WALKING_UPSTAIRS: subject was walking upstairs  
3. WALKING_DOWNSTAIRS: subject was walking downstairs  
4. SITTING: subject was sitting  
5. STANDING: subject was standing up  
6. LAYING: subject was laying down


**Column 3 to 68**
These columns have headings that define the measurement. Each measurement is the mean for the relevant subject, for the relevant activity, over a number of tests.  
The original data was first normalised and bounded to [-1,1]  
The header breaks down as follows:(note not all headers have all levels)  
