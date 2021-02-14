Lab Sheet 4
===========
In this labsheet we will apply a *k*-NN model as discussed in the lecture. We will use `sklearn` to train the model and make predictions. 

Task 1: Import Libraries and Dataset
------------------------------------
As usual, import `numpy`, `pandas` and `matplotlib`. Import the following [dataset]("https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data") and rename its columns to 'sepal-length', 'sepal-width', 'petal-length', 'petal-width', 'Class'. Lastly, print the first 5 rows to see what the dataset is about.

Task 2: Preprocess and Split Dataset
------------------------------------
1. Split the dataset into descriptive feature matrix (`X`) and target feature vector (`y`). 
2. Use the `train_test_split` function from the (`sklearn`) module `model_selection` to split the dataset into test (20%) and training.

Task 3: Scale Features, Train and Predict
-----------------------------------------
1. Use the `StandardScaler` from `sklearn.preprocessing` to fit the training set and scale training and test sets.
2. Showtime: Use the `KNeighborsClassifier` with `k = 5` to fit training and test set.
3. Use the created classifier to predict labels for the test set.

Task 4: Evaluate Results
------------------------
To evaluate your results, you can use the 'confusion_matrix' and 'classification_report' from `sklearn.metrics`.

Task 5 (Optional): Balance k Value with Error Rate
--------------------------------------------------
Try out different values of *k* to optimise your results. Plot the error rate in a graph.