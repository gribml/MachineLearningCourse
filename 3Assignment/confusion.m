function [ confMtrx recall precision F] = confusion( predictedResults, actualResults )
%%  CONFUSIONMATRIX Summary of this function goes here
%   Detailed explanation goes here
alpha = 1;
    C = length(unique(actualResults));
    confMtrx = zeros(C);
    for i =1:size(predictedResults)
        if(predictedResults(i) == actualResults(i)) 
               confMtrx(predictedResults(i), predictedResults(i)) = confMtrx( predictedResults(i), predictedResults(i)) + 1;
        else
               confMtrx( actualResults(i), predictedResults(i)) =  confMtrx( actualResults(i), predictedResults(i)) + 1;
        end
    end
    
    recall = zeros(C, 1); precision = zeros(C, 1); F = zeros(C, 1);
    for i=1:C
        recall(i) = (confMtrx(i,i) / sum(confMtrx(i, :) )) * 100;
        precision(i) = ( confMtrx(i,i) / sum(confMtrx(:, i) ) ) * 100;
        F(i) = (1 + alpha) * precision(i) * recall(i) / (alpha * precision(i) + recall(i));
    end
end


