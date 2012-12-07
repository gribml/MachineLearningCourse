function results = basicKNNtest(cbr, X)
%basicKNNtest return the prediction

    n_examples = size(X, 1);
    results = zeros(n_examples, 1);
    distance = cbr.distance;
    
    for i = 1:n_examples
        
        % We compute the distances between the current example and the
        % training data
        % This is the euclidian distance, we can change it
        if strcmp(distance, 'euclidian')
            distances = bsxfun(@minus, cbr.X, X(i, :));
            distances = bsxfun(@power, distances, 2);
            distances = sqrt(sum(distances, 2));
        elseif strcmp(distance, 'manhattan')
            distances = bsxfun(@minus, cbr.X, X(i, :));
            distances = sum(abs(distances), 2);
        elseif strcmp(distance, 'n_AU')
            distances = abs(sum(cbr.X, 2) - sum(X(i, :)));
        end
        
        % we take only the K first neighbours
        [ ~, indices ] = sort(distances, 'ascend');
        KNN = indices(1:cbr.K)';
        
        % current class
        class = 1;
        % number of times an example of the same class was in the KNN
        max_class = 0;
        
        % For each of the six classes
        for j = 1:6
            n_class = sum(cbr.y(KNN)==j);
            % If there are more examples of this class in the KNN
            if n_class > max_class
                class = j;
                max_class = n_class;
            end
        end
        
        results(i) = class;
        
        % retain
        cbr.X = [cbr.X; X(i, :)];
        cbr.y = [cbr.y; class];
    end
end