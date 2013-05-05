'''
Created on May 5, 2013

@author: paul
'''

import math, sys
import numpy as np
from collections import Counter

def entropy(target):
    return sum( [-p*math.log(p, 2) if p != 0 else 0 for p in 
                 [float(len(arr))/len(target) for arr in 
                  [target[target==i] for i in 
                   xrange(len(set(target)))]]] )

def ig(target, data, attr_idx):
    return entropy(target) - sum( [ float(len(sv))/len(target)*entropy(sv) for sv in 
                                   [ target[data[:,attr_idx]==i] for i in 
                                    set(data[:,attr_idx]) ] ] )

def max_ig_attr(target, data):
    all_ig = [ig(target, data, i) for i in xrange(data.shape[1])]
    return np.max(all_ig), np.argmax( all_ig )

def id3(target, data, attributes, parent=object()):
    n = Node(parent)
    if len(target[target==1])==len(target):
        return n.setLabel(1)
    if len(target[target==0])==len(target):
        return n.setLabel(0)
    if data.shape[1]==0:
        return n.setLabel( Counter(target).most_common(1) )
    
    max_ig, best_attr = max_ig_attr(target, data)
    n.setLabel( best_attr, max_ig )
    for val in set(data[:,best_attr]):
        mask = data[:,best_attr]==val
        if len(mask) == 0:
            Node(n, Counter(target[mask]).most_common(1))
        else:
            n.addChild( id3(target[mask], data[mask, :], 
                               attributes[attributes!=best_attr], n) )
    return n
        
class Node(object):
    def __init__(self, parent, label=float('-inf')):
        self.parent = parent
        self.label = label
        self.children = []
        self.gain = -1
        
    def addChild(self, child):
        self.children.append( child )
        return self
        
    def setLabel(self, label, gain=0):
        self.label = label
        self.gain = gain
        return self

def tree_printer(tree_root, eol=True):
    for i, child in enumerate( tree_root.children ):
        tree_printer(child, i==(len(tree_root.children)-1))
    sys.stdout.write( str(tree_root.label) + ('\n' if eol else ' ') )

def test_id3():
    d =np.array([[1 ,1 ,1 ,-1],
                 [1 ,1 ,1 ,1 ],
                 [0 ,1 ,1 ,-1],
                 [-1,0 ,1 ,-1],
                 [-1,-1,0 ,-1],
                 [-1,-1,0 ,1 ],
                 [0 ,-1,0 ,1 ],
                 [1 ,0 ,1 ,-1],
                 [1 ,-1,0 ,-1],
                 [-1,0 ,0 ,-1],
                 [1 ,0 ,0 ,1 ],
                 [0 ,0 ,1 ,1 ],
                 [0 ,1 ,0 ,-1],
                 [-1,0 ,1 ,1 ]])
    t = np.array([0,0,1,1,1,0,1,0,1,1,1,1,1,0])
    
    tree = id3(t, d, np.arange(4))
    tree_printer(tree)
    
if __name__=='__main__':
    test_id3()