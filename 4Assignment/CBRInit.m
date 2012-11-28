function [ CBR ] = CBRInit( x,y )
%CBRINIT Summary of this function goes here
%   Detailed explanation goes here
    CBR.base = cell(1,6);
    
    %initialize each class
    for i=1:length(CBR.base)
        
        CBR.base{i}.vector = CaseStr.empty;
        CBR.base{i}.count = 0;
        CBR.base{i}.meanVec = zeros(1,45);
        
    end
    %get the cases from given input
    cases = getCases(x,y);
    %Store the cases within the storage
    
    %Insert cases to appropriate storage 
    for i=1:length(cases)
        c = cases{i}.solution;
        flag = 0;
        
        %Check if it was encountered before in that cluster
        for j=1:length(CBR.base{c}.vector)
            
             if (isequal(CBR.base{c}.vector(j).activeActionUnits, cases{i}.activeActionUnits))                 
                flag = 1;
                break;
            end
        end
        
        %Add newly encountered case to the end
        if(flag == 0 )
            CBR.base{c}.vector(end+1) = cases{i};
            CBR.base{c}.count = CBR.base{c}.count +1;
            %Add for each encounteered active action unit
            for k=1:length(cases{i}.activeActionUnits)
                ind = cases{i}.activeActionUnits(k);
                CBR.base{c}.meanVec(ind) = CBR.base{c}.meanVec(ind) + 1;
            end
        end
    end
    
    % Get the mean of them all
    for i=1:length(CBR.base)
            CBR.base{i}.meanVec = CBR.base{i}.meanVec/CBR.base{i}.count;
    end
    
end

