function result = testTrees(T, x2)
    model_examples = zeros(6,45);
    result = classify(x2, T, @depthClassify, model_examples);
end