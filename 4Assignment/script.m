% Simple script to load the data and perform cross_validation

% load the data as X and y
load('cleandata_students.mat');

% Result with clustering
%[ error, errors, conf, F1, precision, recall ] = cross_val(@CBRInit, @testCBR, x, y, 10)

% [ confMtrx, recall, precision, F, classRate] = confusion(y, ypred)

% Result with KNN algorithm
 error2 = cross_val(@basicKNNtrain, @basicKNNtest, x, y, 10)