function [mask] = stratifiedKFold( y, K )
%stratifiedKFold returns a mask indices, each of which represents a testing
%fold
% y = target vector (vector of labels)
% K = number of folds

    values = unique(y);
    mask = 1:length(y);

    for i = 1:length(values)
        % We retrieve the values with the same label values(i)
        indices = find( y == values(i));
        n_elements = length(indices);
        % We shuffle the resulting vector of indices
        indices = indices(randperm(n_elements));
        n_elements_by_fold = floor(n_elements/K);
        % We update the global mask for each of the KFold
        for j = 1:(K-1)
            mask( indices((j-1)*n_elements_by_fold+1:j*n_elements_by_fold) ) = j;
        end
        % We do the last fold separately so that it contains the remaining
        % elements
        mask( indices(j*n_elements_by_fold+1:end) ) = j+1;
    end

end