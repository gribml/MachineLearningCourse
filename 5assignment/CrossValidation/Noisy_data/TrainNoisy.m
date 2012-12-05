LoadData;

if ~( exist( 'noisy_10cv_mask', 'var' ) )
    noisy_10cv_mask = stratifiedKFold( noisy_db.y, 10 );
else
    fprintf( 'Stratified cross-validation mask already in memory. Skipping mask creation.\n' );
end

fprintf( 'Performing Decision-Tree Cross-validation...\n' );
%% TO DO
%[ DT_cm, DT_r, DT_p, DT_F, DT_cr, DT_classifier ] = ...
%    crossval_DT( noisy_db.x, noisy_db.y, noisy_10cv_mask )
%%
fprintf( 'Done.\n' );

fprintf( 'Performing Neural-Network Cross-validation...\n' );
[ NN_cm, NN_r, NN_p, NN_F, NN_cr, NN_classifier ] = ...
    crossval_NN( noisy_db.x, noisy_db.y, noisy_10cv_mask );
fprintf( 'Done.\n' );

fprintf( 'Performing Case Based Reasoning Cross-validation...\n' );
[ CBR_cm, CBR_r, CBR_p, CBR_F, CBR_cr, CBR_classifier ] = ...
    crossval_CBR( noisy_db.x, noisy_db.y, noisy_10cv_mask );
fprintf( 'Done.\n' );