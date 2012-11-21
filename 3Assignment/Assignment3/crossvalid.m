function [ F1single, F1multi, crSingle, crMulti ] = crossvalid( ...
    trainIn, trainOut, Nfolds, nepochs, perfFun, lr, binTrans, binTrain, singTrans, singTrain, binHidden, Hidden ...
)
    
    shuffle_mask = randperm( length( trainIn ) );
    trainIn = trainIn( shuffle_mask, : );
    trainOut = trainOut( shuffle_mask );
    [x2,y2]=ANNdata(trainIn,trainOut);
    split = [0.75, 0.25, 0];
    d = length( trainIn );
    fold_size = floor( d / Nfolds );
    F1single = zeros(Nfolds,1); F1multi = zeros(Nfolds,1);
    crSingle = 0; crMulti = 0;
    for i=1:Nfolds
        trainMask = [ ...
            true( ( i - 1 ) * fold_size, 1 ); ...
            false( fold_size, 1 ); ...
            true( d - i * fold_size, 1 ) ...
        ];
        testMask = [ ...
            false( ( i - 1 ) * fold_size, 1 ); ...
            true( fold_size, 1 ); ...
            false( d - i * fold_size, 1 ) ...
        ];
        
        for k=1:6
            binNet{k} = buildNetwork(binHidden, nepochs, split, x2(:,trainMask), y2(k,trainMask), perfFun, lr, binTrans, binTrain);
        end
        pred1 = testANN(binNet, x2(:,testMask));
        [~, ~, ~, ~, cr1] = confusion(pred1, trainOut(testMask));
        crMulti = crMulti + cr1;
        F1multi(i) = cr1;
        
        net = buildNetwork(Hidden, nepochs, split, x2(:,trainMask), y2(:,trainMask), perfFun, lr, singTrans, singTrain);
        pred2 = testANN(net, x2(:,testMask));
        [~, ~, ~, ~, cr2] = confusion(pred2, trainOut(testMask));
        crSingle = crSingle + cr2;
        F1single(i) = cr2;
    end
    crSingle = crSingle / Nfolds;
    crMulti = crMulti / Nfolds;
%     plot(1:10, crArrSingle, '-b', 'LineWidth', 2);
%     xlabel('fold'); ylabel('F1 performance measure');
%     title('Performance of Single 6-Way Classifier Over 10 Folds');
%     
%     plot(1:10, crArrMulti, '-r', 'LineWidth', 2);
%     xlabel('fold'); ylabel('F1 performance measure');
%     title('Performance of Combined 6 Binary Classifiers Over 10 Folds');
    
    
%    classRateMulti = mean(crArrMulti);
%    classRateSingle = mean(crArrSingle);
end

