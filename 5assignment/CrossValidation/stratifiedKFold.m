function [mask] = stratifiedKFold( y, K )
%stratifiedKFold returns a mask indices, each of which represents a testing
%fold; guaranteeds that each fold contains examples from each class
% y = response vector
% K = number of folds

    values = unique( y );
    N = length( values );
    M = length( y );
    mask = 1:N;
    
    if ( K ~= ceil( K ) ) || ( K <= 0 )
        error( 'K must be a positive natural number' );
    end
    
    if ( K > M )
        fprintf( 'length( y ) = %ld\n', length( y ) );
        error('K must be less than the number of elements in y.');
    end
    
    if ( K == 1 )
        mask = ones( 1, M );
        return
    end

    for i = 1:N
%% We retrieve the values with the same label values(i)
        indices = find( y == values( i ) );
        n_elements = length( indices );
%% We shuffle the resulting vector of indices
        indices = indices( randperm( n_elements ) );
        n_elements_by_fold = floor( n_elements / K );
%% We update the global mask for each of the KFold
        for j = 1:( K - 1 )
            mask( ...
                indices( (j - 1) * n_elements_by_fold + ...
                1:j * n_elements_by_fold ) ...
            ) = j;
        end
%% We do the last fold separately so that it contains the remaining 
%  elements
        mask( indices( j * n_elements_by_fold+1:end) ) = j + 1;
    end

end
