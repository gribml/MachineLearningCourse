function pruning_example(x,y)
    
% x: noSamples x 45 (as returned by loaddata)
% y: noSamples x 1 (as returned by loaddata)

% http://www.mathworks.co.uk/help/stats/treefit.html
tree = treefit(x,y,'method','classification','catidx',1:100,'splitmin',1);

%% The two following lines compute two kinds of errors :
%  cross - cross validation error : the default number of folds is 10, 
%          so we can compare with our code.
[cost,~,nodes,bestLevel] = treetest(tree,'cross',x,y);
%  resubstitution - The error( cost ) of the tree is the sum over all 
%                   terminal nodes of the estimated probability of that 
%                   node times the node's cost. The cost of a node is the 
%                   sum of the misclassification costs of the observations 
%                   in that node
[cost2,~,nodes2,bestLevel2] = treetest(tree,'resubstitution');

%% Now thre tree is pruned according to the best level, determined by the
%  above error functions (but I don't understand why this function are
%  called as their result is not used in the plot
prunedTree = treeprune(tree,'level',bestLevel);
prunedTree2 = treeprune(tree,'level',bestLevel2);

%% Find the minimum cost (ie the best cut in the tree)
[mincost,minloc] = min(cost);
[mincost2,minloc2] = min(cost2);


%% Plot the curve of cross error (blue)
plot(nodes,cost,'b-x','MarkerSize',8)
hold on
% plot a box on the best cut
plot(nodes(bestLevel+1),cost(bestLevel+1),'ks');

xlabel('Tree size (number of terminal nodes)')
ylabel('Cost')
grid on

%% Plot the curve of resubstitution error (blue)
plot(nodes2,cost2,'r-x','MarkerSize',8)
% plot a box on the best cut
plot(nodes2(bestLevel2+1),cost2(bestLevel2+1),'ks');


%% Conclusion : with resubstitution error, there is no way to know if the 
% algorithm is overfitting since the curve keeps decreasing when the number
% of nodes increase. On the other hand, we can see that the cross
% validation error stop decreasing after a point. This means that we no
% longer mean to add nodes as we cannot minimize the error any Longer.
%% Conclusion of the conclusion : when both curve are decreasing, we are 
% minimizing the error and we should keep adding nodes.
% If cross curve is in stagnation or increasing and resubstitution curve is
% decreasing, the algorithm is overfitting, as he is good to fit the
% training data but cannot generalise.
% It is unlikely that the red curve increase.

