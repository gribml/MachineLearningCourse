function [ cbr ] = retain( cbr, solvedCase, bestCase )
%RETAIN CBR step to add solvedCase to base case (must have solution associated with it)

%     flag = 0;
    %Check if the case is already known
    %Check if it was encountered before in that cluster
%     for j=1:length(cbr.base{solvedCase.solution}.vector)
% 
%          if (isequal(cbr.base{solvedCase.solution}.vector(j).activeAU, solvedCase.activeAU))
%             flag = 1;
%             break;
%         end
%     end

    %Add newly encountered case to the end
%     if(flag == 0 )
        s = solvedCase.solution;
        solvedCase.cbrIndex = cbr.base{s}.count + 1;
        cbr.base{s}.vector(end+1) = solvedCase;
%     end   
    %Add for each encounteered active action unit
    intermediateVector = cbr.base{s}.meanVec * cbr.base{s}.count;
    cbr.base{s}.count = cbr.base{s}.count + 1;
    for k=1:length(solvedCase.activeAU)
        ind = solvedCase.activeAU(k);
        cbr.base{s}.meanVec(ind) = intermediateVector(ind) + 1;              
    end
    % Get the mean of them all
	intermediateVector = intermediateVector/cbr.base{s}.count;
	cbr.base{s}.meanVec = intermediateVector;
end

