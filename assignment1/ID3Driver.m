function [confMtrx , errorRate] = ID3Driver(example_data, attribute_data, target_data, decisionFunction, N)
    alpha = 1;
    % train to get 6 trees
    trees = trainer(example_data, attribute_data, target_data);
    % classify any test data on these trees using decision function
    classified = classify(target_data, trees, decisionFunction);
    
    % N-fold validation to measure error rate
    mask = NFoldValidationMask(length(example_data), N);
    confMtrx = zeros(length(unique(target_data)));
    for i=1:N
        validationTrees = trainer(example_data(mask.train(i),:), attribute_data, target_data(mask(i).train,:));
        validClassify(i) = classify(example_data(mask(i).test), validTrees{i}, attribute_data, decisionFunction);
        confMtrx = confMtrx + confusionMatrix(validClassify(i), target_data(mask(i).test));
    end
    
    confMtrx = confMtrx / N;
    errorRate = zeros(size(confMtrx, 1));
    recall = 0;
    precision = 0;
    for i=1:size(confMtrx,1)
        recall = recall + confMtrx(i,i) / sum(confMtrx(i, :));
        precision = precision + confMtrx(i,i) / sum(confMtrx(:, i));
    end
    
    recall = recall / size(confMtrx, 1);
    precision = precision / size(confMtrx, 1);
    errorRate = (1 + alpha) * precision * recall / (precision + recall);