function [ differenceinNoofAUs ] = similarity3( case1, case2 )
%SIMILARITY1 Summary of this function goes here
%   Returns the difference in number of action units,
%   The smaller the number is, the more similar the two cases are
    size1 = size(case1.activeActionUnits,2);
    size2 = size(case2.activeActionUnits,2);
    differenceinNoofAUs = abs(size1-size2);

    
end

