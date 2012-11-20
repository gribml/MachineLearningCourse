function[cr] = trainOneNetwork(x,y)

[x2, y2] = ANNdata(x, y);

count = size(x2,2);

%Fix the test set
shuffledIndex = randperm(count);
shuffledArray = x2(:,shuffledIndex);
shuffledArrayResults = y2(:,shuffledIndex);
shuffledActualResults = y(shuffledIndex);

testSetNo = 200;
trainDataNo = 300;

crPrevious2 = 0;
crPrevious = 0;
crCurrent = 0;
iteration = 0;

while (iteration < 3 || crCurrent >= crPrevious || crPrevious >=crPrevious2)
    %get training data
    trainData = shuffledArray(:,1:trainDataNo);
    trainDataResults = shuffledArrayResults(:,1:trainDataNo);
    
    %shuffle the remainders of the shuffled array to get test data
    testShuffledIndex = 0;

    remainder = count-trainDataNo;
    if(remainder > testSetNo)
        rem = shuffledArray(:,trainDataNo+1:count);
        testShuffledIndex = randperm(size(rem,2));
        newShuffledArray = rem(:,testShuffledIndex);
        testData=newShuffledArray(:,1:testSetNo);
        testDataResultsTemp =  shuffledActualResults(trainDataNo+1  :count);
        testDataResultsTempShuffle = testDataResultsTemp(testShuffledIndex);
        testDataResults =  testDataResultsTempShuffle(1:testSetNo);
    else
        break;
    end

    net = buildNetwork(6, 15, [0.75, 0.25, 0], trainData, trainDataResults, 'mse', 0.3, 'logsig', 'trainbr');
    pred = testANN(net, testData); 
    [~, ~, ~, ~, cr] = confusion(pred, testDataResults);
    
    if(iteration > 1)
        crPrevious2 = crPrevious;
        netPrev2 = netPrev; 
    end
    
    if(iteration > 0)
        crPrevious = crCurrent;
        netPrev = netCurrent;
    end
 
    netCurrent =net; 
    
    crCurrent = cr;
    trainDataNo = trainDataNo + 50
    iteration = iteration + 1;
end

if(crCurrent > crPrevious && crCurrent > crPrevious2)
    cr = crCurrent;
    trainDataNoFinal = trainDataNo-50;
    net = netCurrent;
   
elseif(crPrevious>crCurrent && crPrevious>crPrevious2)
    cr = crPrevious;
    trainDataNoFinal = trainDataNo - 100;
    net = netPrev;
else
    cr = crPrevious2;
      net = netPrev2;
    trainDataNoFinal = trainDataNo - 150;
end

 save('trainOneFunc.mat', 'net','trainDataNoFinal');
