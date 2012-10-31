function [cl] = modelClassify(answer, ~, ~,example, model)
    if ( length(answer(answer==1))==1 )
        cl = find(answer==1);
    else
        cl1 = zeros(length(answer), 1);
        for i=1:length(answer)
            s = sort(model(i,:),'descend');
            idx = zeros(5,1);
            for j=1:5
                equals = find(s(j)==model(i,:));
                idx(j) = equals(1);
            end
            cl1(i) = sum( abs(example(idx) - model(i,idx)) );
        end
        cl = find(min(cl1)==cl1);
    end
end