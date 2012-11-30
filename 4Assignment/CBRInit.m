function [ CBR ] = CBRInit( x, y )
%CBRINIT creates a case base with initial values for examples and target values

    CBR = cell(1,6);
    %initialize each class
    for i=1:length(CBR)
        CBR{i}.vector = CaseStr.empty;
        CBR{i}.count = 0;
        CBR{i}.meanVec = zeros(1,45);
    end
    
    %get the cases from given input
    cases = getCases(x,y);
    %Store the cases within the storage
    
    %Insert cases to appropriate storage 
    for i=1:length(cases)
        c = cases{i}.solution;
        flag = 0;
        
        %Check if it was encountered before in that cluster
        for j=1:length(CBR{c}.vector)
             if (isequal(CBR{c}.vector(j).activeAU, cases{i}.activeAU))                 
                flag = 1;
                break;
             end
        end
        
        %Add newly encountered case to the end
        if(flag == 0 )
            CBR{c}.vector(end+1) = cases{i};
            CBR{c}.count = CBR{c}.count +1;
            %Add for each encounteered active action unit
	        ind = cases{i}.activeAU;
            CBR{c}.meanVec(ind) = CBR{c}.meanVec(ind) + 1;
        end
    end
    
    % Get the mean of them all
    for i=1:length(CBR)
        CBR{i}.meanVec = CBR{i}.meanVec/CBR{i}.count;
    end
    
end

