function [ error, errors ] = cross_val( train, predict, X, y, K )
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
        cbr = train(X(train_indices, :), y(train_indices));
        ypred = predict( cbr, X(test_indices, :));
        errors(i) = sum(ypred ~= y(test_indices)) / length(ypred);
    end
    error = mean(errors);
end

