Valid;
% ValidTrain

%% Parameters
alpha = 0.05 / 3;
clear_all = false;

fprintf( '\nttest: alpha = %f\n\n', alpha );
for i=1:6
    fprintf( '\nemotion %ld\n', i );
    [ h1, p1, c1 ] = ttest( NN_cr( :, i ), DT_cr( :, i ), alpha );
    fprintf( '  ttest NN_cr, DT_cr: p=%f, c=[%f %f]\n', p1, c1( 1 ), c1( 2 ) );
    if ~h1
        fprintf( '    Null Hypothesis cannot be rejected, NN and DT have the same performance on emotion %ld\n', i );
    else
        if mean( NN_F( :, i ) ) > mean( DT_F( :, i ) )
            fprintf( '    Null Hypothesis rejected, NN is more performant than DT on emotion %ld\n', i );
        else
            fprintf( '    Null Hypothesis rejected, DT is more performant than NN on emotion %ld\n', i );
        end
    end
    
    [ h2, p2, c2 ] = ttest( DT_cr( :, i ), CBR_cr( :, i ), alpha );
    fprintf( '  ttest DT_cr, CBR_cr: p=%f, c=[%f %f]\n', p2, c2( 1 ), c2( 2 ) );
    if ~h2
        fprintf( '    Null Hypothesis cannot be rejected, DT and CBR have the same performance on emotion %ld\n', i );
    else
        if mean( DT_F( :, i ) ) > mean( CBR_F( :, i ) )
            fprintf( '    Null Hypothesis rejected, DT is more performant than CBR on emotion %ld\n', i );
        else
            fprintf( '    Null Hypothesis rejected, CBR is more performant than DT on emotion %ld\n', i );
        end
    end

    [ h3, p3, c3 ] = ttest( CBR_cr( :, i ), NN_cr( :, i ), alpha );
    fprintf( '  ttest CBR_cr, NN_cr: p=%f, c=[%f %f]\n', p3, c3( 1 ), c3( 2 ) );
    if ~h3
        fprintf( '    Null Hypothesis cannot be rejected, CBR and NN have the same performance on emotion %ld\n', i );
    else
        if mean( CBR_F( :, i ) ) > mean( NN_F( :, i ) )
            fprintf( '    Null Hypothesis rejected, CBR is more performant than NN on emotion %ld\n', i );
        else
            fprintf( '    Null Hypothesis rejected, NN is more performant than CBR on emotion %ld\n', i );
        end
    end
end

clear i;
if clear_all
    clear all;
end
clear clear_all;