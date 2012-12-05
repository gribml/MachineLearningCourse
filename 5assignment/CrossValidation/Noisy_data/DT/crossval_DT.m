function [classRate] = crossval_DT( trainer, classify, example_data, attribute_data, target_data, mask )
    mask = NFoldValidationMask(length(example_data), N);
    classRate = 0;
    for i=1:N
        validationTrees = trainer(example_data(mask(i).train,:), attribute_data, target_data(mask(i).train,:), beta);
        validClassify = classify(example_data(mask(i).test,:), validationTrees, decisionFunction, model_examples);
        confMtrx = confMtrx + confusionMatrix(validClassify, target_data(mask(i).test));
        classRate = classRate + sum( validClassify == target_data(mask(i).test) ) / length(validClassify);
    end
end
