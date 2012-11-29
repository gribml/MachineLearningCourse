function [ result ] = similarity3( existingCase, newCase )
%SIMILARITY3 Summary of this function goes here
%   Case 1 is the case alteady in CBR, case 2 is the new case
%result is a structure which has 3 properties. Same is the AUs that are
%common to both, this is the most important property, the larger it is the
%more similar they are.. timesRetrieved is the times case1 has been
%retrieved
        noOfCommonAUs = similarity1( existingCase, newCase ); 
        difference = similarity2(existingCase, newCase);
        result.diff =  difference ;
        result.same = noOfCommonAUs;
        result.timesRetrieved = existingCase.timesRetrieved; 
end

