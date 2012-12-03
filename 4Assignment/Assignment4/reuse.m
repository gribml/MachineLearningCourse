function [ solvedCase ] = reuse(existingCase, newCase )
%REUSE CBR stage
    solvedCase = newCase;
    solvedCase.solution = existingCase.solution;
    solvedCase.timesRetrieved = 0;
end

