function [cl] = prelimClassify(answer, depth, ig, example, model)
    if ( length(answer(answer==1))==1 )
        cl = find(answer==1);
    else
        cl = -1;
    end
end