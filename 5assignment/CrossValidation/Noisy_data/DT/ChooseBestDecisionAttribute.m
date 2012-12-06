function [best_attribute, maxGain] = ChooseBestDecisionAttribute(examples, attributes, binary_targets)
% This function returns the best attribute, ie the one with the highest
% information gain
% maxGain is the information gain of the selected best_attribute

    % definition of the entropy
    function [entropy] = I(p, n)
        if or( p == 0, n == 0 )
            entropy = 0;
        else
            frac = p/(n+p);
            entropy = -frac*log2(frac) - (1-frac)*log2(1-frac);
        end
    end

    values = unique(binary_targets);
    
    % These cases should not arise
    if length(values)==1 % All the examples are the same
        error('If all the examples are the same, should be a leaf');
    else if length(values)>2 % more than two classes (targets)
        error('The target must be binary');
        end
    end
    
    % it is binary classification
    % we accept every values, being vNo and vYes
    vNo = values(1);  % 0
    vYes = values(2);  % 1
    p = sum(binary_targets==vNo); % count of zeros in binary targets
    n = sum(binary_targets==vYes); % count of ones in binary targets
    global_entropy = I(p, n);
    best_attribute = attributes(1);
    maxGain = -1; % as gain is > 0, will be overwritten at first iteration
    
    % We compute the information gain for every attribute 
    % and select the best one
    for i=1:length(attributes)
        n0 = sum(binary_targets(examples(:, i)==0)==vNo);
        p0 = sum(binary_targets(examples(:, i)==0)==vYes);
        n1 = sum(binary_targets(examples(:, i)==1)==vNo);
        p1 = sum(binary_targets(examples(:, i)==1)==vYes);
        s = p + n;
        remainder = (n0 + p0)*I(p0, n0)/s + (p1 + n1)*I(p1, n1)/s;
        gain = global_entropy - remainder;
        
        % the information gain of the current attribute is the highest one
        % for now:
        % We keep it
        if gain > maxGain
            best_attribute = attributes(i);
            maxGain = gain;
        end
    end
end