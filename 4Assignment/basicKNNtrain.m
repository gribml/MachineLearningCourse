function params = basicKNNtrain(X, y)
%basicKNNtrain
    params.X = X;
    params.y = y;
    params.K = 6; % number of neighbours
    params.distance = 'manhattan';
end