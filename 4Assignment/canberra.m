function dist = canberra( existingCase, newCase )
    existing = existingCase.AURepresentation+1;
    new = newCase.AURepresentation+1;
    dist = 0;
    for i=1:length(existing)
        dist = dist + abs(existing(i) - new(i)) ...
            /(abs(existing(i) + new(i)));
    end
end