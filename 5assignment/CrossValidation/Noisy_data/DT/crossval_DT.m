function [ cm, r, p, F, cr, classifier ] = crossval_DT( X, y, mask )
    
    K  = length( unique( mask ) );
    M  = length( unique( y ) ); 
    F  = zeros( K, M ); 
    p  = zeros( K, M ); 
    r  = zeros( K, M );
    cr  = zeros( K, M );
    cm = zeros( M, M, K );

    classifier = cell( K, M );
    
    for i=1:K
        trainMask = logical( mask ~= i );
        testMask = logical( mask == i );
       
        cbr = trainer( X( trainMask, : ), 1:45, y( trainMask ), 0.98 );
        pred1 = classify( X( testMask, : ), cbr, @depthClassify );

        classifier( i, : ) = cbr;
        [ cm( :, :, i ), r( i, : ), p( i, : ), F( i, : ), cr_temp ] = ...
            confusion( pred1, y( testMask ) );
        cr( i, : ) = 1 - cr_temp;
    end
end
