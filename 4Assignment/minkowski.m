function [ dist ] = minkowski( existingCase, newCase, r, nDims, toSort )
    if ( isa( existingCase, 'CaseStr' ) )
        existingCase = existingCase.AURepresentation;
    end
    
    if ( isa( newCase, 'CaseStr' ) )
        newCase = newCase.AURepresentation;
    end
    
    if toSort
        [~,sortIdx] = sort(existingCase, 'descend');
        existingCase = existingCase(sortIdx);
        newCase = newCase(sortIdx);
    end
    dist = power(sum( (existingCase(1:nDims) - newCase(1:nDims)).^r ), 1/r );
end