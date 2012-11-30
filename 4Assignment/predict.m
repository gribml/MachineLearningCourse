function [ y ] = predict( cbr, X )
%predict returns a prediction vector associated to data matrix X

    n = size(X, 1);
    y = zeros(n, 1);
    % For every example (ie every row of X)
    % Retrive the nearest neighbour
    % Reuse it
    % Retain the row
    for i = 1:n
        c = createCase(X(i, :));
        bestCase = retrieve(cbr, c);
        y = reuse(bestCase, c);
        % cbr = retain(cbr, X(i, :));
    end
end

