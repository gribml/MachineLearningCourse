% Simple script to load the data and perform cross_validation

% load the data as X and y
load('cleandata_students.mat');

% Result with Sedef's code
%error1 = cross_val(@CBRInit, @predict, x, y, 3);

% Result with a very basic KNN algorithm
error2 = cross_val(@basicKNNtrain, @basicKNNtest, x, y, 200)