function [ cbr ] = retain( cbr,solvedCase )
%RETAIN CBR step to add solvedCase to base case (must have solution associated with it)

    flag = 0;
    %Check if the case is already known
    %Check if it was encountered before in that cluster
    for j=1:length(cbr{solvedCase.solution}.vector)

         if (isequal(cbr{solvedCase.solution}.vector(j).activeAU, solvedCase.activeAU))
            flag = 1;
            break;
        end
    end

    %Add newly encountered case to the end
    if(flag == 0 )
        cbr{solvedCase.solution}.vector(end+1) = solvedCase;
    end   
    %Add for each encounteered active action unit
    intermediateVector = cbr{solvedCase.solution}.meanVec*cbr{solvedCase.solution}.count;
    cbr{solvedCase.solution}.count = cbr{solvedCase.solution}.count + 1;
    for k=1:length(solvedCase.activeAU)
        ind = solvedCase.activeAU(k);
        cbr{solvedCase.solution}.meanVec(ind) = intermediateVector(ind) + 1;              
    end
    % Get the mean of them all
    intermediateVector = intermediateVector/cbr{solvedCase.solution}.count;
       cbr{solvedCase.solution}.meanVec = intermediateVector;
end

