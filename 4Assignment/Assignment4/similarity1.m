function [ noOfCommonAUs ] = similarity1( existingCase, newCase )
%SIMILARITY1 Summary of this function goes here
%   Returns the number of actions units that are the same for both input
%   cases (the higher the returned number is, the more similar they are)
    
    if ( isa( existingCase, 'CaseStr' ) )
        existingCase = existingCase.AURepresentation;
    end
    
    if ( isa(newCase, 'CaseStr') )
        newCase = newCase.AURepresentation;
    end
    same = intersect(find(existingCase>0.5), find(newCase>0.5));
    noOfCommonAUs = 1 - ( size(same,2) / size(find(newCase>0.5), 2) );

end

