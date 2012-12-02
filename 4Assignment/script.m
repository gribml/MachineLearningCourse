% Simple script to load the data and perform cross_validation

% load the data as X and y
load('cleandata_students.mat');

% Result with clustering
error1 = cross_val(@CBRInit, @testCBR, x, y, 10);

% Result with KNN algorithm
% error2 = cross_val(@basicKNNtrain, @basicKNNtest, x, y, 20)