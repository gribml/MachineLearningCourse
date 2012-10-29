function [confMtrx, F, classRate, trees ] = ID3Driver(example_data, attribute_data, target_data, decisionFunction, N)
%% Run exemple : [ C, F, CR, T ] = ID3Driver(x,1:45,y,@igClassify,10)

    alpha = 1;
    numTrees = length(unique(target_data));
    %% train to get 6 trees
    trees = trainer(example_data, attribute_data, target_data);
    %% classify any test data on these trees using decision function
    % classified = classify(example_data, trees, decisionFunction);
    
    %% N-fold validation to measure error rate
    mask = NFoldValidationMask(length(example_data), N);
    confMtrx = zeros(numTrees);
    classRate = 0;
    for i=1:N
        validationTrees = trainer(example_data(mask(i).train,:), attribute_data, target_data(mask(i).train,:));
        validClassify = classify(example_data(mask(i).test,:), validationTrees, decisionFunction);
        confMtrx = confMtrx + confusionMatrix(validClassify, target_data(mask(i).test));
        classRate = classRate + sum( validClassify == target_data(mask(i).test) ) / length(validClassify);
    end
    
    confMtrx = confMtrx / N;
    classRate = 1 - classRate / N;
    %errorRate = zeros(size(confMtrx, 1));
    recall = 0;
    precision = 0;
    for i=1:numTrees
        recall = recall + confMtrx(i,i) / sum(confMtrx(i, :));
        precision = precision + confMtrx(i,i) / sum(confMtrx(:, i));
    end
    
    recall = recall / size(confMtrx, 1);
    precision = precision / size(confMtrx, 1);
    F = (1 + alpha) * precision * recall / (alpha * precision + recall);
end
