function [best_attribute] = ChooseBestDecisionAttribute(examples, attributes, binary_targets)
    % definition of the entropy
    function [entropy] = I(p, n)
        frac = p/(n+p);
        entropy = -frac*log2(frac) - (1-frac)*log2(1-frac);
    end

    values = unique(binary_targets);
    
    % These cases should not arise
    if length(values)==1 % All the examples are the same
        error('If all the examples are the same, should be a leaf');
    else if length(values)>2 % more than two classes (targets)
        error('The target must be binary');
        end
    end
    
    vp = values(1);
    vn = values(2);
    p = length(binary_targets(binary_targets==vp));
    n = length(binary_targets(binary_targets==vn));
    global_entropy = I(p, n);
    
    max = -1; % as gain is > 0, will be overwritten at first iteration
    for i=attributes
        p0 = length(binary_target(binary_target(examples(:, i)==0)==vp));
        n0 = length(binary_target(binary_target(examples(:, i)==0)==vn));
        p1 = length(binary_target(binary_target(examples(:, i)==1)==vp));
        n1 = length(binary_target(binary_target(examples(:, i)==1)==vn));
        s = p + n;
        remainder = (p0 + n0)/s*I(p0, n0) + (p1 + n1)/s*I(p1, n1);
        gain = global_entropy - remainder;
        if gain > max
            best_attribute = i;
        end
    end
end