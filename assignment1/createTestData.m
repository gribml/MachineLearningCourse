function [Items] = createTestData(examples, N)

shuffledArray = examples(randperm(size(examples,1)),:);

%get size

noRows = size(shuffledArray,1);
noRowsEachUnit = floor(noRows / N);
noColumns = size(shuffledArray, 2);

% a representative element of the final matrix
element = struct('testData',zeros(noRows,noColumns),'trainData',zeros((noRows- noRowsEachUnit), noColumns));

% initialize final matrix 
Items = repmat(element, 1, N); 

for i=1:N
    %get test data
    testMask = logical( [zeros( (i-1)*noRowsEachUnit, 1); ones(noRowsEachUnit, 1)] );
    Items(i).testData = shuffledArray(testMask,:);
    
    %get training data
    remainingRows = noRows - (i * noRowsEachUnit);
    trainingMask = logical( [ones((i-1)*noRowsEachUnit, 1); zeros(noRowsEachUnit, 1); ones(remainingRows, 1)] );
    Items(i).trainData = shuffledArray(trainingMask, :);
end


     
