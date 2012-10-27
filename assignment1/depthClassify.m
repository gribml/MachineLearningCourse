function cl = depthClassify(answer, depth, ig)
% this function determines tree tree to use based on sum of information gain
% down the branches of each tree given the attributes of the example
% answer - result array from walking down each tree
% depth - depth traversed for each tree
    if ( length(answer(answer==1))==1 )
        cl = find(answer==1);
    elseif ( length(answer(answer==1)) > 1 )
        cl1 = find(depth == min(depth(answer==1)));
        cl = cl1(1);
    else
        cl1 = find(depth==max(depth));
        cl = cl1(1);
    end
end