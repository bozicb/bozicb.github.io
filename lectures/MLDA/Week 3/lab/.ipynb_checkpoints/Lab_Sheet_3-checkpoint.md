Lab Sheet 3
===========

In this labsheet we will try our first real prediction with a fitted model and we will use a `Decision Tree` as discussed in the lecture. The idea is to go through the whole process of choosing the data, selecting features, building the model and making a prediction.

Task 1: Selecting Data for Modelling
------------------------------------
To select variables, we first need to know what's in the dataset. So do the following to find out:

1. Import the `pandas` library (typically data scientists abbreviate the `pandas` namespace to `pd` with `import pandas as pd`).
2. Use `pandas` to read in the **melbourne** dataset and have a look at the columns (i.e. possible features).
3. Drop missing values.
4. Select the prediction target (find the target feature and save in in a variable named `y`.

Task 2: Choosing Features
-------------------------
The variables we select to train the model on are called *features*. We should always try to select meaningful features which provide lots of information for the model. To extract features do the following:

1. Look for 5 features you think are the most relevant.
2. Save their names as `strings` in a list.
3. Use the list to filter the `DataFrame` and save the subframe in a variable called `X`.
4. Generate basic statistics for your features.
5. Inspect the first few rows of your subframe.

Task 3: Building Your Model
---------------------------
Here we will use the [sklearn][https://scikit-learn.org/stable/] library to fit our model.

Task 4: Make Predictions
------------------------

