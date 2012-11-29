function [ cbr ] = retain( cbr,solvedCase )
%RETAIN Summary of this function goes here
%   Detailed explanation goes here


    flag = 0;
    %Check if the case is already known
    %Check if it was encountered before in that cluster
        for j=1:length(cbr.base{solvedCase.solution}.vector)
            
             if (isequal(cbr.base{solvedCase.solution}.vector(j).activeAU, solvedCase.activeAU))                 
                flag = 1;
                break;
            end
        end
        
        %Add newly encountered case to the end
        if(flag == 0 )
            cbr.base{solvedCase.solution}.vector(end+1) = solvedCase;
        end   
        %Add for each encounteered active action unit
        intermediateVector = cbr.base{solvedCase.solution}.meanVec*cbr.base{solvedCase.solution}.count;
        cbr.base{solvedCase.solution}.count = cbr.base{solvedCase.solution}.count + 1;
        for k=1:length(solvedCase.activeAU)
            ind = solvedCase.activeAU(k);
            cbr.base{solvedCase.solution}.meanVec(ind) = intermediateVector(ind) + 1;              
        end
        % Get the mean of them all
        intermediateVector = intermediateVector/cbr.base{solvedCase.solution}.count;
           cbr.base{solvedCase.solution}.meanVec = intermediateVector;
     
    
end

