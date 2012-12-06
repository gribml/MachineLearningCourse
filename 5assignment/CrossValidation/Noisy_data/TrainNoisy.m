LoadData;

if ~( exist( 'cv10_mask', 'var' ) )
    fprintf( 'Creating stratified cross-validation mask...\n' );
    cv10_mask = stratifiedKFold( clean_db.y, 10 );
    fprintf( '  Saving cv10_mask...\n' );
    save( 'cv10_mask', 'cv10_mask' );
    fprintf( 'Done\n' );
else
    fprintf( 'Stratified cross-validation mask already in memory. Skipping mask creation.\n' );
end

fprintf( 'Performing Decision-Tree Cross-validation...\n' );
[ DT_cm, DT_r, DT_p, DT_F, DT_cr, DT_classifier ] = ...
    crossval_DT( clean_db.x, clean_db.y, cv10_mask );
fprintf( '  Saving DT_Classifier...\n' );
save( 'DT_classifier', 'DT_classifier' );
fprintf( 'Done.\n' );

fprintf( 'Performing Neural-Network Cross-validation...\n' );
[ NN_cm, NN_r, NN_p, NN_F, NN_cr, NN_classifier ] = ...
    crossval_NN( clean_db.x, clean_db.y, cv10_mask );
fprintf( '  Saving NN_Classifier...\n' );
save( 'NN_classifier', 'NN_classifier' );
fprintf( 'Done.\n' );

fprintf( 'Performing Case Based Reasoning Cross-validation...\n' );
[ CBR_cm, CBR_r, CBR_p, CBR_F, CBR_cr, CBR_classifier ] = ...
    crossval_CBR( clean_db.x, clean_db.y, cv10_mask );
fprintf( '  Saving CBR_Classifier...\n' );
save( 'CBR_classifier', 'CBR_classifier' );
fprintf( 'Done.\n' );