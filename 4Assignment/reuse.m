function [ solvedCase ] = reuse(existingCase, newCase )
%REUSE Summary of this function goes here
    solvedCase = newCase;
    solvedCase.solution = existingCase.solution;
    solvedCase.timesRetrieved = 0;
end

