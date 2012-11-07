load('cleandata_students.mat');
[ x2, y2 ] = ANNdata( x, y );
net = buildNetwork( [ 10 ], 10, [ 0.75, 0.15, 0.15 ], x2, y2 );