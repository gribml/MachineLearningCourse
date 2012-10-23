function ID3Driver(attribute_data, target_data)
    
    for i=unique(target_data)
        binary_targets = binaryFromMultiple(targetValue, i);
        % create a tree for each thing we're classifying
        troot{i} = tnode;
        troot{i} = ID3(attribute_data, binary_targets);
    end

    % combine results from each binary tree to give output
    % algorithm 1: sum information gain down the tree
    
    
    
    % N-fold validation to measure error rate
    