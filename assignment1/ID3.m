function [tree] = ID3(examples, attr, binary_targets)
% function DECISION-TREE-LEARNING(examples,attributes,binary_targets) 
% returns a decision tree for a given target label
%   if all examples have the same value of binary_targets then return a leaf node with this value
%   else if attributes is empty
%   then return a leaf node with value = MAJORITY-VALUE(binary_targets) 
%   else
%       best_attribute <-- CHOOSE-BEST-DECISION-ATTRIBUTE(examples,attributes, binary_targets) 
%       tree <-- a new decision tree with root as best_attribute
%       for each possible value u_i of best_attribute do (note that there are 2 values: 0 and 1)
%           add a branch to tree corresponding to best_attibute = u_i
%           {examplesi , binary_targets i} <-- {elements of examples with best_attribute = ?i and the
%       if examples_i is empty
%       else subtree <-- DECISION-TREE-LEARNING(examplesi ,attributes-{best_attribute}, binary_targetsi)
% return tree

root = tnode();
nYes = sum(binary_targets) / length(binary_targets)
if ( nYes == 0 && nYes == 1)
    root.data = nYes;
elseif ( length(attr) == 0 )
    root.data = (nYes > 0.5;
felse
    best_attr = chooseBestDecisionAttribute(examples, attr, binary_targets);
    t = tree(best_attr);
    for i=1:2
        t.addBranch(i);
    end
% not finished        

% testing 1 2 