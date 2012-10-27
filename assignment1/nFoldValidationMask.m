% function [masks] = NFoldValidationMask(count, N)
%     testSize = floor(count/N)
%     r = randperm(1:count);
%     masks = repmat( struct('test', zeros(count), 'train', zeros(count - testSize)), 1, N);
% 
%     for i=1:N
%         masks(i).test = r([zeros((i-1) * testSize, 1); ones(testSize, 1)]);
%         masks(i).train = r(logical([ones((i-1) * testSize, 1); zeros(testSize, 1), ones(count-(i*testSize), 1)]));
%     end
% end





function [Items] = nFoldValidationMask(count, N)

r = 1:count;
shuffledArray = r(randperm(count));

%get size

noRowsEachUnit = floor(count / N);

% a representative element of the final matrix
element = struct('test',zeros(count,1),'train',zeros((count- noRowsEachUnit), 1));

% initialize final matrix 
Items = repmat(element, 1, N); 

for i=1:N
    %get test data
    testMask = logical( [zeros( (i-1)*noRowsEachUnit, 1); ones(noRowsEachUnit, 1)] );
    Items(i).test = shuffledArray(testMask);
    
    %get training data
    remainingRows = count - (i * noRowsEachUnit);
    trainingMask = logical( [ones((i-1)*noRowsEachUnit, 1); zeros(noRowsEachUnit, 1); ones(remainingRows, 1)] );
    Items(i).train = shuffledArray(trainingMask);
end


     
