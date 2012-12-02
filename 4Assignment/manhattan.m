function d = manhattan(existingCase, newCase, dim, toSort)
    if ( isa(existingCase, 'CaseStr') )
        existingCase = existingCase.AURepresentation;
    end
    
    if ( isa(newCase, 'CaseStr') )
        newCase = newCase.AURepresentation;
    end
    
	if toSort
        [~,index] = sort(existingCase, 'descend');
        existingCase = existingCase(index);
        newCase = newCase(index);
    end
    d = sum( abs( existingCase(1:dim) - newCase(1:dim) ) );
end