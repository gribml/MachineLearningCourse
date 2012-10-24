function prune_example(x,y)
    
% x: noSamples x 45 (as returned by loaddata)
% y: noSamples x 1 (as returned by loaddata)

tree = treefit(x,y,'method','classification','catidx',1:100,'splitmin',1);

[cost,s,nodes,bestLevel] = treetest(tree,'cross',x,y);
[cost2,s2,nodes2,bestLevel2] = treetest(tree,'resubstitution');

prunedTree = treeprune(tree,'level',bestLevel);
prunedTree2 = treeprune(tree,'level',bestLevel2);

[mincost,minloc] = min(cost);
[mincost2,minloc2] = min(cost2);


plot(nodes,cost,'b-x','MarkerSize',8)
hold on
plot(nodes(bestLevel+1),cost(bestLevel+1),'ks');
xlabel('Tree size (number of terminal nodes)')
ylabel('Cost')
grid on

plot(nodes2,cost2,'r-x','MarkerSize',8)
plot(nodes2(bestLevel2+1),cost2(bestLevel2+1),'ks');

