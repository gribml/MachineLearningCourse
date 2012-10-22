function ID3Driver(attribute_data, target_data)
    for i=1:size(attribute_data, 2)
        binary_targets = binaryFromMultiple(targetValue, i);
        % create a tree for each thing we're classifying
        t(i) = ID3(attribute_data, binary_targets);
        