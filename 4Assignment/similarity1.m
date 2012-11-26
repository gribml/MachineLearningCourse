function [ noOfSimilarAUs ] = similarity1( case1, case2 )
%SIMILARITY1 Summary of this function goes here
%   Returns the number of actions units that are the same for both input
%   cases (the higher the returned number is, the more similar they are)
    same = intersect(case1.activeActionUnits, case2.activeActionUnits);
    noOfSimilarAUs = size(same,2);

end

