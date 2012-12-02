function dist = clark( existingCase, newCase )
    if ( isa(existingCase, 'CaseStr') )
        existingCase = existingCase.AURepresentation + 1;
    end
    if ( isa(newCase, 'CaseStr') )
        newCase = newCase.AURepresentation + 1;
    end

    dist = sqrt(sum( abs(existingCase - newCase)./(existingCase + newCase).^2));
end