function[cr] = trainOneNetwork(x,y)

[x2, y2] = ANNdata(x, y);

count = size(x2,2);

%Fix the test set
shuffledIndex = randperm(count);
shuffledArray = x2(:,shuffledIndex);
shuffledArrayResults = y2(:,shuffledIndex);
shuffledActualResults = y(shuffledIndex);

testSetNo = 300;
trainDataNo = 500;
crOld = 0;
crCurrent = 0;
count = 0;
while count < 3
    %get training data
    trainData = shuffledArray(:,1:trainDataNo);
    trainDataResults = shuffledArrayResults(:,1:trainDataNo);

    %get test data(200 records)
    %shuffle the remainders of the shuffled array to get test data

    testShuffledIndex = 0;

    remainder = count-trainDataNo;
    if(remainder > testSetNo)
        rem = shuffledArray(:,remainder:testSetNo);
        testShuffledIndex = randperm(size(rem,2));
        newShuffledArray = rem(:,testShuffledIndex);
        testData =newShuffledArray(:,1:testSetNo); 
        testDataResultsTemp =  shuffledActualResults(:,testShuffledIndex);
        testDataResults =  testDataResultsTemp(:,1:testSetNo);
    end

    testDataResults =  shuffledActualResults((count-testSetNo):count);

    net = buildNetwork(15, 15, [0.667, 0.33, 0], trainData, trainDataResults, 'mse', 0.3, 'softmax', 'trainbr');
    pred = testANN(net, testData); 
    [~, ~, ~, ~, cr] = confusion(pred, testDataResults);
    crCurrent = cr;
    if crOld == 0
        crOld = cr;
    end
    if(crOld = )
end