function [ differenceinNoofAUs ] = similarity2( existingCase, newCase )
%SIMILARITY1 Summary of this function goes here
%   Returns the difference in number of action units,
%   The smaller the number is, the more similar the two cases are
    size1 = size(existingCase.activeAU,2);
    size2 = size(newCase.activeAU,2);
    differenceinNoofAUs = abs(size1-size2) ;
end

