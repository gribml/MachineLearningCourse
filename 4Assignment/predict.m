function [ y ] = predict( cbr, testData )
%predict returns a prediction vector associated to data matrix testData

    n = size(testData, 1);
    y = zeros(n, 1);
    % For every example (ie every row of testData)
    % Retrive the nearest neighbour
    % Reuse it
    % Retain the row
    for i = 1:n
        c = createCase(testData(i, :));
        bestCase = retrieve(cbr, c);
        caseToRetain = reuse(bestCase, c);
        cbr = retain(cbr, caseToRetain);
    end
end

