%% Load clean and noisy datasets
% the variable load_data provide useless data loading if they already
% reside in memory.

if  ~exist( 'clean_db', 'var' )
    fprintf( 'Loading cleandata_students.mat...\n' );
    clean_db = load('Dataset/cleandata_students.mat');
    fprintf( 'Done.\n' );
else
    fprintf( 'Dataset cleandata_students.mat already loaded. Loading step skipped.\n' );
end

if ~exist( 'noisy_db', 'var' )
    fprintf( 'Loading noisydata_students.mat...\n' );
    noisy_db = load('Dataset/noisydata_students.mat');
    fprintf( 'Done.\n' );
else
    fprintf( 'Dataset noisydata_students.mat already loaded. Loading step skipped.\n' );
end