function [ error, errors, conf, F1, precision, recall ] = cross_val( trainFunc, testFunc, X, y, K )
%cross_val performs stratified KFolds cross validation
%   train : training function
%   predict : prediction function
%   X : data
%   y : target vector (labels)
%   K : number of folds
    mask = stratifiedKFold(y, K);
    errors = zeros(K, 1);
    F1 = 0; precision = 0; recall = 0;
    conf = zeros(length(unique(y)));
    for i = 1:K
        test_indices = (mask == i);
        train_indices = (mask ~= i);
        cbr = trainFunc(X(train_indices, :), y(train_indices));
%        cbr.similarityMeasure = @canberra;
%        cbr.similarityMeasure = @(a,b)(minkowski(a,b, 2, 10, 1));
         cbr.similarityMeasure = @(a,b)(manhattan(a,b, 10, 1));
%        cbr.similarityMeasure = @similarity1;
        sprintf('using canberra similarity measure')
        yPred = testFunc( cbr, X(test_indices, :));
        [ cm, r, p, F, cr] = confusion( yPred, y(test_indices) );
        conf = conf + cm;
        recall = recall + r;
        precision = precision + p;
        F1 = F1 + F;
        
        errors(i) = mean(yPred ~= y(test_indices));
    end
    yAct = y(test_indices);
    error = mean(errors)
    recall = recall/K;
    precision = precision/K;
    F1 = F1/K;
    conf = conf/K;
end

