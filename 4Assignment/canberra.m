function dist = canberra( existingCase, newCase )
	if ( isa(existingCase, 'CaseStr') )
		existingCase = existingCase.AURepresentation;
	end

	if ( isa(newCase, 'CaseStr') )
		newCase = newCase.AURepresentation;
	end

    existingCase = existingCase + 1;
    newCase = newCase + 1;
    
    dist = 0;
    for i=1:length(existingCase)
        dist = dist + abs(existingCase(i) - newCase(i)) ...
            /(abs(existingCase(i) + newCase(i)));
    end
end