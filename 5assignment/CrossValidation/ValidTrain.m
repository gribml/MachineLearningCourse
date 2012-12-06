LoadData;

%% Parameters:
db = noisy_db;
clear_all = false;
save_classifier = false;

if ~( exist( 'cv10_mask', 'var' ) )
    fprintf( 'Creating stratified cross-validation mask...\n' );
    cv10_mask = stratifiedKFold( db.y, 10 );
    if save_classifier
        fprintf( '  Saving cv10_mask...\n' );
        save( 'cv10_mask', 'cv10_mask' );
    end
    fprintf( 'Done.\n' );
else
    fprintf( 'Stratified cross-validation mask already in memory. Skipping mask creation.\n' );
end

fprintf( 'Performing Decision-Tree Cross-validation...\n' );
[ DT_cm, DT_r, DT_p, DT_F, DT_cr, DT_classifier ] = ...
    crossval_DT( db.x, db.y, cv10_mask );
if save_classifier
    fprintf( '  Saving DT_Classifier...\n' );
    save( 'DT_classifier', 'DT_classifier' );
end
fprintf( 'Done.\n' );

fprintf( 'Performing Neural-Network Cross-validation...\n' );
[ NN_cm, NN_r, NN_p, NN_F, NN_cr, NN_classifier ] = ...
    crossval_NN( db.x, db.y, cv10_mask );
if save_classifier
    fprintf( '  Saving NN_Classifier...\n' );
    save( 'NN_classifier', 'NN_classifier' );
end
fprintf( 'Done.\n' );

fprintf( 'Performing Case Based Reasoning Cross-validation...\n' );
[ CBR_cm, CBR_r, CBR_p, CBR_F, CBR_cr, CBR_classifier ] = ...
    crossval_CBR( db.x, db.y, cv10_mask );
if save_classifier
    fprintf( '  Saving CBR_Classifier...\n' );
    save( 'CBR_classifier', 'CBR_classifier' );
end
fprintf( 'Done.\n' );

clear db;
clear save_classifier;
if clear_all
    clear all;
end
clear clear_all;