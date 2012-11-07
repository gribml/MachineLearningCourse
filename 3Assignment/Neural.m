load('cleandata_students.mat');
[ x2, y2 ] = ANNdata( x, y );
net = builtNetwork( [ 10 ], 10, x2, y2, );