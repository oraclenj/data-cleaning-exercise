

#README.txt for run_analysis.R script

	1. read in the 3 test files, 3 train files, and 2 reference files
	2. change the column names for activites and feature names
	3. add the activity labes to the test and train fact data frames
	4. choose which features I want, searching for any features that have
		'mean' or 'std' in their feature name. store in wanted_features
	5. convert wanted_features from factor to character
	6. use wanted_features to whittle down the columns in the fact data frames
	7. change the column names in the fact data frames
	8. finally merge the train and test fact data frames
	9. melt the merged data frame to break out every variable and its value
	10. summarize the melted data to get the mean in a tidy data frame
	11. write the tidy data frame out to a file, all_tidy.txt


License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.






