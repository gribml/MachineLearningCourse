function partIV(x, y)
    [x2, y2] = ANNdata(x, y);
    
    % step 1: create a six-output NN
    totalNet = feedforwardnet;
    totalNet = configure(totalNet, x2, y2);
    totalNet.trainParam.epochs = 50;
    totalNet.divideFcn = 'dividerand';
    totalNet.divideMode = 'sample';
    totalNet.divideParam.trainRatio = 70/100;
    totalNet.divideParam.valRatio = 15/100;
    totalNet.divideParam.testRatio = 15/100;
    totalNet.performFcn = 'mse';
    [totalNet, tr] = train(totalNet, x2, y2);
    
    % step 2: create 6 one-output NN
    for i=1:size(y2,1)
        n = feedforwardnet;
        n = configure(n, x2, y2(i,:));
        n.trainParam.epochs = 25;
        n.divideFcn = 'dividerand';
        n.divideMode = 'sample';
        n.divideParam.trainRatio = 70/100;
        n.divideParam.valRatio = 15/100;
        n.divideParam.testRatio = 15/100;
        n.performFcn = 'mse';
        [n, tr] = train(totalNet, x2, y2(i,:));
        binaryNets{i} = n;
        
        