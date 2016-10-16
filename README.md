# Cleaning-UCI-HAR-Dataset
Coursera Data Science Project - Cleaning Data

Files Description:
  1. MeanHAR_UsingSmartphone.txt: the tidy dataset required by the assignment
  2. codebook.md: instruction about the variables in the tidy dataset
  3. run_analysis.R: R scripts to load the data, analyze, and output the tidy dataset
  
R script Description:
  1. Download the dataset from the source. Unzip the file.
  2. Read the Activity, Subject and Feature data. (Test and train data for each)
  3. Row combine Test and Train data for Activity, Subject and Feature respectively. Define a header for each combined dataset.
  4. Column combine Activity, Subject and Feature datasets into one table.
  5. Extract only mean and standard deviation measurement from the 561 Feature variables.
  6. Change the numeric values of activity into descriptive values.
  7. Change the name of the header of the measures to make it understandable and consistant.
  8. Calculate the mean of the measures group by subject and activity, and generate a new dataset with these aggregations.
  9. Order the new dataset by subject and activity.
  10. Output the new aggregated dataset as MeanHAR_UsingSmartphone.txt.
