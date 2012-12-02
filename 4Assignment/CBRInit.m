function [ CBR ] = CBRInit( x, y )
%CBRINIT creates a case base with initial values for examples and target values

    
    CBR.numBases = length(unique(y));
    CBR.base = cell(CBR.numBases, 1);
    %initialize each class
    for i=1:CBR.numBases
        CBR.base{i}.vector = CaseStr.empty;
        CBR.base{i}.count = 0;
        CBR.base{i}.meanVec = zeros(1,45);
    end
    CBR.similarityMeasure = @(a,b)(manhattan(a,b,45,0));
    CBR.similarityMeasure = @(a,b)(minkowski(a,b,2,10,1));
    CBR.similarityMeasure = @clark;
    CBR.similarityMeasure = @similarity1;
    
    
    %get the cases from given input
    cases = getCases(x,y);
    %Store the cases within the storage
    
    %Insert cases to appropriate storage 
    for i=1:length(cases)
        c = cases{i}.solution;
        encounteredFlag = 0;
        
        %Check if it was encountered before in that cluster
        for j=1:length(CBR.base{c}.vector)
             if (isequal(CBR.base{c}.vector(j).activeAU, cases{i}.activeAU))
                encounteredFlag = 1;
                break;
             end
        end
        
        %Add newly encountered case to the end
        if(encounteredFlag == 0 )
            cases{i}.isEmpty();
            CBR.base{c}.vector(end+1) = cases{i};
            CBR.base{c}.vector(end).cbrIndex = CBR.base{c}.count + 1;
            CBR.base{c}.count = CBR.base{c}.count +1;
            %Add for each encounteered active action unit
	        ind = cases{i}.activeAU;
            CBR.base{c}.meanVec(ind) = CBR.base{c}.meanVec(ind) + 1;
        end
    end
    
    % Get the mean of them all
    for i=1:CBR.numBases
        CBR.base{i}.meanVec = CBR.base{i}.meanVec/CBR.base{i}.count;
    end
    
    for i=1:6
        c = CBR.base{i};
        for j=1:c.count
        if (isempty(c.vector(j).activeAU))
            sprintf('error: class %d, case %d) not initialized', i, j)
        end
	end
    
end

