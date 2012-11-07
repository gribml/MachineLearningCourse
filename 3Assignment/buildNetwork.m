function [ network ] = buildNetwork( HiddenLayer, epochs, dataSplit, x, y )

    [ network ] = feedforwardnet( HiddenLayer, 'trainlm' );
    [ network ] = configure( network, x, y );
    network.trainParam.epochs = epochs;
    network.divideMode = 'sample';
    network.performFcn = 'mse';
    network.divideParam.trainRatio = dataSplit(1);
    network.divideParam.valRatio = dataSplit(2);
    network.divideParam.testRatio = dataSplit(3);    
    [ network ] = train( network, x, y );
    

end

