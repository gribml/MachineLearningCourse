function [ cm, r, p, F, cr, classifier ] = ...
    crossval_NN( X, y, mask )

    [ x2, y2 ]=ANNdata( X, y );
    split = [ 0.75, 0.25, 0 ];

    K  = length( unique( mask ) );
    M  = length( unique( y ) ); 
    F  = zeros( K, M ); 
    p  = zeros( K, M ); 
    r  = zeros( K, M );
    cr  = zeros( K, M );
    cm = zeros( M, M, K );
    
    
%% Don't know how to pre-allocate memory for this two structures.
%    (That's this kind of stuff that makes me hate matlab....)
%
%    classifier = zeros( 1, 6 );
%    binNet = cell( 1, 6 );
   

    for i=1:K
        trainMask = logical( mask ~= i );
        testMask = logical( mask == i );
        
        % Optimal parameters
        for k=1:6
            binNet{k} = buildNetwork( ...
                [ 9, 9 ], 20, split, ...
                x2( :, trainMask ), y2( k, trainMask ), ...
                'mse', 0.2, 'tansig', 'trainbr' ...
            );
        end
        pred1 = testANN( binNet, x2( :,testMask ) );
        classifier( i ) = binNet;
        [ cm( :, :, i ), r( i, : ), p( i, : ), F( i, : ), cr_temp ] = ...
            confusion( pred1, y( testMask ) );
        cr( i, : ) = 1 - cr_temp;
    end
end

