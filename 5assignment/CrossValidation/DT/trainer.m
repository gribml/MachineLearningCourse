function [trees] = trainer(examples, attributes, target_data, beta)
    trees = tnode.empty(length(unique(target_data)), 0);
    for i=1:length(unique(target_data))
        binary_targets = binaryFromMultiple(target_data, i);
        %% create a tree for each thing we're classifying
        trees{i} = ID3(examples, attributes, binary_targets, beta);
    end
end