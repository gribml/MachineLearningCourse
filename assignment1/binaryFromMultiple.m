function [binary_targets] = binaryFromMultiple(targetData, searchValue)
    binary_targets = (targetData == searchValue);
end