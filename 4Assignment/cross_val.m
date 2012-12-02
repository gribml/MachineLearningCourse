function [ error, errors ] = cross_val( trainFunc, testFunc, X, y, K )
%cross_val performs stratified KFolds cross validation
%   train : training function
%   predict : prediction function
%   X : data
%   y : target vector (labels)
%   K : number of folds
    mask = stratifiedKFold(y, K);
    errors = zeros(K, 1);
    
    for i = 1:K
        test_indices = (mask == i);
        train_indices = (mask ~= i);
        cbr = trainFunc(X(train_indices, :), y(train_indices));
        cbr.similarityMeasure = @(a, b)( minkowski(a, b, 2, 5, 1) );
        ypred = testFunc( cbr, X(test_indices, :));
        errors(i) = mean(ypred ~= y(test_indices));
    end
    error = mean(errors)
end

