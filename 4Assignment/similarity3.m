function [ result ] = similarity3( case1, case2 )
%SIMILARITY3 Summary of this function goes here
%   Case 1 is the case alteady in CBR, case 2 is the new case
%result is a structure which has 3 properties. Same is the AUs that are
%common to both, this is the most important property, the larger it is the
%more similar they are.. timesRetrieved is the times case1 has been
%retrieved
        same = intersect(case1.activeActionUnits, case2.activeActionUnits);
        noOfSimilarAUs = size(same,2);
        size1 = size(case1.activeActionUnits,2);
        size2 = size(case2.activeActionUnits,2);
        differenceinNoofAUs = size1 - size2;
        result.diff =  differenceinNoofAUs;
        result.same = noOfSimilarAUs;
        result.timesRetrieved = case1.timesRetrieved; 
end

