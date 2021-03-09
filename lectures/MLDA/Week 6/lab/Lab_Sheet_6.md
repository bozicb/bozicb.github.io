Lab Sheet 6
===========
In this lab sheet we will use Linear Regression to predict house prices and Logistic Regression to predict heart disease. We will use `sklearn` to train the models and make predictions. Some evaluation is covered here as well, however the theory part of this will be covered in week 8.

Task 1: Import Libraries and Dataset
------------------------------------
Import all required libraries including, but not limited to, `pandas`, `numpy`, `matplotlib`, `seaborn` as well as the `confusion_matrix` and `train_test_split` functions, `metrics` package and `LinearRegression` and `LogisticRegression` classes from `sklearn`. For both types of regression and their respecitive datasets, do the following tasks.

Task 2: Explore the Data
------------------------
Import the `USA_Housing.csv` and `framingham.csv` datasets and have a look at the structure. Plot out pairplots with `seaborn` and look at `distplot` and `heatmap`.

Task 4: Training and Test Set Preparation
-----------------------------------------
Select the appropriate features and use the `train_test_split` function to split the dataset in training and test (1/3). Test the split by printing out the shape of both sets. 

Task 5: Prediction
------------------
Use the `LinearRegression` and `LogisticRegression` classifier from the `linear_model` package to fit and predict the target variables. Find out what parametres you need and how to add them. Make your prediction and plot them against the actual values.

Task 6: Evaluation
------------------
Evaluate by looking into accuracy and confusion matrix for `LogisticRegression` and mean absolute error, mean squared error, root mean squared error and r2 square for `LinearRegression`.