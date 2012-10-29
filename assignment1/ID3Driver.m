function [confMtrx , errorRate, trees ] = ID3Driver(example_data, attribute_data, target_data, decisionFunction, N)
%% Run exemple : ID3Driver(x,1:45,y,@igClassify,10).

    alpha = 1;
    numTrees = length(unique(target_data));
    %% train to get 6 trees
    trees = trainer(example_data, attribute_data, target_data);
    %% classify any test data on these trees using decision function
    % classified = classify(example_data, trees, decisionFunction);
    
    %% N-fold validation to measure error rate
    mask = nFoldValidationMask(length(example_data), N);
    confMtrx = zeros(numTrees);
    for i=1:N
        validationTrees = trainer(example_data(mask(i).train,:), attribute_data, target_data(mask(i).train,:));
        validClassify = classify(example_data(mask(i).test,:), validationTrees, decisionFunction);
        confMtrx = confMtrx + confusionMatrix(validClassify, target_data(mask(i).test));
    end
    
    confMtrx = confMtrx / N;
    %errorRate = zeros(size(confMtrx, 1));
    recall = 0;
    precision = 0;
    for i=1:numTrees
        recall = recall + confMtrx(i,i) / sum(confMtrx(i, :));
        precision = precision + confMtrx(i,i) / sum(confMtrx(:, i));
    end
    
    recall = recall / size(confMtrx, 1);
    precision = precision / size(confMtrx, 1);
    errorRate = (1 + alpha) * precision * recall / (alpha * precision + recall);
end
