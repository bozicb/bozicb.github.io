Lab Sheet 5
===========
In this labsheet we will use a Naïve Bayes model, as discussed in the lecture, to classify a spam dataset.We will use `sklearn` to train the model and make predictions. Some evaluation is covered here as well, however the theory part of this will be covered in week 8.

Task 1: Import Libraries and Dataset
------------------------------------
Import all required libraries including, but not limited to, `pandas`, `numpy`, `matplotlib` as well as the `feature_extraction`, `model_selection`, `naive_bayes`, and `metrics` packages from `sklearn`.

Task 2: Explore the Data
------------------------
Import the `spam.csv` dataset and have a look at the structure. Count how many spam and ham emails it contains and visualise this in a bar chart or pie chart (if you have to).

Task 3: Analyse the Text and Select Features
--------------------------------------------
Find frequencies of words for spam and ham and visualise them (usually we would remove stopwords here, lemmatise, etc. but we can ignore this for now). Use the functions `feature_extraction` to remove stopwords with a `CountVectorizer` and then `fit_transform` the data frame column *v2* (message text). Have a look at the shape of your feature matrix.

Task 4: Training and Test Set Preparation
-----------------------------------------
Use the `train_test_split` function to split the dataset in training and test (1/3). Test the split by printing out the shape of both sets.

Task 5: Prediction
------------------
Use the `MultinomialNB` classifier from the `naive_bayes` package to fit and predict the target variable. Find out what the regularisation parameter &alpha; means and try to find the best value for it.

Task 6: Evaluation
------------------
The `MultinomialNB` object you used for your prediction, also has variables for `score` (accuracy), `precision` and `recall`. Use them to create a matrix with your results (ideally for different &alpha; values). How good was your prediction on the test set?