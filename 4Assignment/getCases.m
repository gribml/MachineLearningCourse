function cases = getCases(x,y)
    N = length(y);
    cases = cell(1,N);
    for i=1:N
        cases{i} = CaseStr;
        cases{i}.activeAU = find(x(i,:));
        cases{i}.solution = y(i);
 
    end
end