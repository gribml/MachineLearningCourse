function cases = getCases(x,y)
%% CBR function to return  a cell array of CaseStr objects containing examples from matrix x and target array y
    N = length(y);
    cases = cell(1,N);
    for i=1:N
        cases{i} = CaseStr;
        cases{i}.activeAU = find(x(i,:));
        cases{i}.solution = y(i);
 
    end
end