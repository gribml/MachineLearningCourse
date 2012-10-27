function [ confusionMtx] = confusionMatrix( predictedResults, actualResults )
%CONFUSÝONMATRÝX Summary of this function goes here
%   Detailed explanation goes here
    confusionMtx = zeros(6);
    for i =1:size(predictedResults)
        if(predictedResults(i) == actualResults(i)) 
               confusionMtx(predictedResults(i), predictedResults(i)) = confusionMtx( predictedResults(i), predictedResults(i)) + 1;
        else
               confusionMtx( actualResults(i), predictedResults(i)) =  confusionMtx( actualResults(i), predictedResults(i)) + 1;
        end
    end
            
            



end

