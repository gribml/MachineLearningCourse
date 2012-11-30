function [bestCase ] = retrieve( cbr,newCase )
%RETRIEVE CBR step of extracting the case most similar to newCase

    
    noOfBestAUs = 5;
    noOfClasses = size(cbr.base,2);
    arrays = cell(1, noOfClasses);
    %listClasses = zeros(1,noOfClasses);
    listClasses= [];
    %checking each cluster in the CBR
    for i=1:size(cbr.base,2)
        nextFlag = 1;
        %[sortedValues,sortIndex] = sort(cbr.base{i}.meanVec,'descend'); 
        %arrays{i} = sortIndex(1,1:noOfBestAUs);
        % looking through all active AUs to determine which cases should be considered
        % we do this so we don't have to consider all cases in the case base
        for j=1:size(newCase.activeAU)
            if(cbr.base{j}.meanVec(newCase.activeAU) == 0)
                nextFlag = 0;
                break;
            end
        end
        if nextFlag
            listClasses(i) = length(intersect(arrays{i},newCase.activeAU));
        end
        
        %Get how many of them are active in the new example
        %
    end
    
    %find the maximum common AUs to check that index
    if(isempty(listClasses))
        maxInd = [1:noOfClasses];
    else
        maxInd = listClasses;
    end
    %maxInd = find(listClasses == max(listClasses));
    
    maxSim.diff = 0;
    maxSim.same = -1;
    maxSim.timesRetrieved = 0;
    bestCase = CaseStr;
    indexBestCase = -1;
    for i=1:size(maxInd,2)
        %Look inside each class
        for j=1:length(cbr.base{maxInd(i)}.vector)
           
            sim = similarity3(cbr.base{maxInd(i)}.vector(j),newCase);
            
             %Initialize if first time
            if(maxSim.same == -1 )
                maxSim = sim;
                 bestCase = cbr.base{maxInd(i)}.vector(j);
                 indexBestCase = j;
            end
            
            if(maxSim.same > sim.same)
                maxSim = sim;
                bestCase = cbr.base{maxInd(i)}.vector(j);
                indexBestCase = j;
            elseif (maxSim.same == sim.same)
                if(maxSim.diff > sim.diff)
                     maxSim = sim;
                     bestCase = cbr.base{maxInd(i)}.vector(j);
                     indexBestCase = j;
                elseif(maxSim.diff == sim.diff)
                     if(maxSim.timesRetrieved < sim.timesRetrieved)
                        maxSim = sim;
                        bestCase = cbr.base{maxInd(i)}.vector(j);
                        indexBestCase = j;
                     end
                end
            end
        end
    end
    cbr.base{bestCase.solution}.vector(indexBestCase).timesRetrieved = ...
           cbr.base{bestCase.solution}.vector(indexBestCase).timesRetrieved+1;
end

