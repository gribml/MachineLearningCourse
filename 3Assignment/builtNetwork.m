function [ network ] = builtNetwork( HiddenLayer, epochs, x, y, trainFcn )

    [ network ] = feedforwardnet( HiddenLayer, trainFcn );
    network.trainParam.epochs = epochs;
    [ network ] = configure( network, x, y );
    [ network ] = train( network, x, y );

end

