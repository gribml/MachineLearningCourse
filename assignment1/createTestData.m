function [a] = createTestData(initMatrix)

shuffledArray = initMatrix(randperm(size(initMatrix,1)),:);

%get size

noRows = size(shuffledArray,1);
noRowsEachUnit = floor(noRows / 10);
noColumns = size(shuffledArray,2);

% a representative element of the final matrix
element = struct('testData',zeros(noRows,noColumns),'trainData',zeros((noRows- noRowsEachUnit), noColumns));

% initialize final matrix 
Items = repmat(element,1,10); 

for i=1:10
    %get test data
    mask = logical([zeros((i-1)*noRowsEachUnit,1);ones(noRowsEachUnit,1)]);
    Items(i).testData = shuffledArray(mask,:);
    
    %get training data
    remainingRows = noRows - (i*noRowsEachUnit);
    maskZeroes = logical([ones((i-1)*noRowsEachUnit,1);zeros(noRowsEachUnit,1);ones(remainingRows,1)]);
    Items(i).trainData = shuffledArray(maskZeroes,:);
end
a= Items;

     
