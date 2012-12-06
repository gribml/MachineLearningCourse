function [ cm, r, p, F, cr ] = ...
    crossval( X, y, classifier, testFunc, mask )
%cross_val performs stratified KFolds cross validation
%   train : training function
%   predict : prediction function
%   X : data
%   y : target vector (labels)
    
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


    for i = 1:K
        testMask = logical( mask == i );

        pred1 = testFunc( classifier( i, : ), X( testMask, : ) );
        [ cm( :, :, i ), r( i, : ), p( i, : ), F( i, : ), cr_temp ] = ...
            confusion(pred1, y( testMask ) );
        cr( i, : ) = 1 - cr_temp;
    end
end