function [confMtrx, F,recall,precision, classRate, trees ] = ID3Driver(example_data, attribute_data, target_data, decisionFunction, N, beta)
%% Run exemple : [ C, F, CR, T ] = ID3Driver(x,1:45,y,@igClassify,10)
%    rng(50000); %% seeding random number generate to reproduce results from report
    alpha = 1;
    numTrees = length(unique(target_data));
    %% train to get 6 trees
    trees = trainer(example_data, attribute_data, target_data, beta);
    
    
    %% classify any test data on these trees using decision function
    preClassified = classify(example_data, trees, @prelimClassify,0);
    model_examples = zeros(length(trees), size(example_data, 2));
    for i=1:length(trees)
        model_examples(i,:) = mean(example_data(find(preClassified==i), :));
    end
    
    %% N-fold validation to measure error rate
    mask = NFoldValidationMask(length(example_data), N);
    confMtrx = zeros(numTrees);
    classRate = 0;
    for i=1:N
        validationTrees = trainer(example_data(mask(i).train,:), attribute_data, target_data(mask(i).train,:), beta);
        validClassify = classify(example_data(mask(i).test,:), validationTrees, decisionFunction, model_examples);
        confMtrx = confMtrx + confusionMatrix(validClassify, target_data(mask(i).test));
        classRate = classRate + sum( validClassify == target_data(mask(i).test) ) / length(validClassify);
    end
    
    confMtrx = confMtrx / N;
    classRate = classRate / N;
    %errorRate = zeros(size(confMtrx, 1));
    recall = zeros(1,6);
    precision = zeros(1,6);
    F =  zeros(1,6);
    for i=1:numTrees
        recall(i) = (confMtrx(i,i) / sum(confMtrx(i, :) ) ) * 100;
        precision(i) = ( confMtrx(i,i) / sum(confMtrx(:, i) ) ) * 100;
         F(i) = (1 + alpha) * precision(i) * recall(i) / (alpha * precision(i) + recall(i));
    end
    
   
end
