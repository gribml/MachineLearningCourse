function d = manhattan(existingCase, newCase)
    d = sum(abs(existingCase.AURepresentation - newCase.AURepresentation));
end