% Simple script to load the data and perform cross_validation

% load the data as X and y
load('cleandata_students.mat');

error = cross_val(@CBRInit, @predict, x, y, 3);