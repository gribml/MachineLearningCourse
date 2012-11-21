function cases = getCases(x, y)
    N = length(y);
    cases = cell(N);
    for i=1:N
        cases{i}.x = find(x(i,:));
        cases{i}.y = y(i);
    end
end