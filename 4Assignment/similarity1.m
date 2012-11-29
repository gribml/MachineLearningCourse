function [ noOfCommonAUs ] = similarity1( existingCase, newCase )
%SIMILARITY1 Summary of this function goes here
%   Returns the number of actions units that are the same for both input
%   cases (the higher the returned number is, the more similar they are)
    same = intersect(existingCase.activeAU, newCase.activeAU);
    noOfCommonAUs = 1 - ( size(same,2) / size(newCase.activeAU,2));

end

