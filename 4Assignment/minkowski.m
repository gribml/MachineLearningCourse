function [ dist ] = minkowski( existingCase, newCase, r )
    existing = existingCase.AURepresentation;
    new = newCase.AURepresentation;
    dist = power(sum( (existing - new).^r ), 1/r );
end