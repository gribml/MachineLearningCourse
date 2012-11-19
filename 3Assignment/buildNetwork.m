function [ network ] = buildNetwork( HiddenLayer, epochs, dataSplit, x, y, perf,  lr, tf, trainFn)
%% this function builds the neural net according to inputs
%    HiddenLayer (Lx1 array) - sizes of each hidden layer
%    epchos (int) - max number of epochs to train with
%    dataSplit (3x1 array) - represents [training, validation, testing] ratio
%    x (nxm array) - n examples with m attributes
%    y (nx1) - n target values
%    perf (string) - representing performance measure used to calculate error
%    lr (string) - learning rate for stochastic gradient descent
%    transFn (string) - transfer function, a.k.a activation function for all layers
%    trainFn (string) - training function 

    [ network ] = feedforwardnet( HiddenLayer, trainFn );
    [ network ] = configure( network, x, y );

    network.trainParam.epochs = epochs;
    network.trainParam.lr = lr;
    network.divideMode = 'sample';
    network.performFcn = perf;
    network.divideParam.trainRatio = dataSplit(1);
    network.divideParam.valRatio = dataSplit(2);
    network.divideParam.testRatio = dataSplit(3);
    
    for i=1:length(HiddenLayer)
        network.layers{i}.transferFcn = transFn;
    end

    [ network ] = train( network, x, y);

end

