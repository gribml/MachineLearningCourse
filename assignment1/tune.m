function beta = tune( example_data, attribute_data, target_data, decisionFunction, N, delta )

    tempArray = 1:-delta:0.75;
    beta = 1;
    maxVal = 0;
    h = waitbar(0,'tuning parameter beta, please wait...');
    counter = 0;
    for i=tempArray
        [~, F,~,~, ~, ~ ] = ID3Driver(example_data, attribute_data, target_data, decisionFunction, N, i);
        if ( mean(F) > maxVal )
            maxVal = mean(F);
            beta = i;
        end
        counter = counter +1;
        waitbar(counter*delta / 0.25,h )
    end
end