function classes = classify(examples, binary_trees, decisionFunction, model)
% goes down the trees and makes the following assertion:
%   1) if tree j says yes, while all others say no, then return j
%   2) if >1 trees say yes or no: highest information gain sum wins; if 2 
%    are same ig, pick first one in lineup

	classes = zeros(length(examples), 1);
    for i = 1:length(examples)
        ig = ones(length(binary_trees), 1);
        depth = zeros(length(binary_trees), 1);
        answer = zeros(length(binary_trees), 1);
        for j=1:length(binary_trees)
            t = binary_trees{j};
            while ( ~t.isleaf )
                depth(j) = depth(j) + 1;
                ig(j) = ig(j) + t.infoGain;
                if ( examples(i, t.indop) == 0 )
                    t = t.getkid(1);
                else
                    t = t.getkid(2);
                end
            end
            answer(j) = t.class;
        end
        % decision about which tree to use comes here
        classes(i) = decisionFunction(answer, depth);
    end
end
