'''
Created on May 5, 2013

@author: paul
'''

from __future__ import division

from math import log
from sys import stdout
import numpy as np
from collections import Counter
from functools import partial


class Node(object):
    ''' ID3 is defined recursively using Node objects
        Nodes have 
        'children' : list of other Node object descendent from self
        'label' : usually a floating value associated with that Node
        'gain' : usually information gain associated with Node
        'parent' : backward reference to a parent Node
    '''
    def __init__(self, parent, value=float('-inf') ):
        self.parent = parent
        self.label = float('-inf')
        self.children = []
        self.gain = -1
        self.is_leaf = False
        self.attr_value = value
        
    def addChild(self, child):
        self.children.append( child )
        self.is_leaf = False
        return self

    def subChild(self, child):
        if child in self.children:
            self.children.remove( child )
            if len(self.children) == 0:
                self.is_leaf = True
            return True
        else:
            return False
        
    def setLabel(self, label, gain=0, verbose=False):
        self.label = label
        self.gain = gain
        
        if verbose:
            print 'set label %s' % str(label)
        return self
    
    def __repr__(self):
        return '%s (ig: %s); %d children' % (self.label, self.gain, len(self.children))


def tree_printer(tree_root, eol=True):
    for i, child in enumerate( tree_root.children ):
        tree_printer(child, i==(len(tree_root.children)-1))
        stdout.write( str(tree_root.label) + ('\n' if eol else ' ') )

def safe_log(x):
    return log(x, 2) if x > 0 else 0

def frequency( array, item ):
    return len( array[array==item] ) / len( array )

log_calc = np.vectorize( safe_log )

def entropy(target):
    ''' uses np.vectorize() for speed (hopefully) '''
    unique_targets = np.unique( target )
    p_with_target = partial( frequency, target )
    p_calc = np.vectorize( p_with_target )
    p = p_calc( unique_targets )
    return np.sum(-1 * p * log_calc( p ))
    
def entropy_old(target):
    unique_targets = np.unique( target )
    p = np.zeros( len(unique_targets), dtype=np.float )
    logs = np.zeros( len(unique_targets), dtype=np.float)
    for idx, t in enumerate(unique_targets):
        p[idx] = len( target[target==t] ) / len(target)
        logs[idx] = safe_log( p[idx] )
    
    return (-1 * p * logs).sum()
    
def entropy_inefficient( target ):
    ''' initial implementation of entropy to play with list comprehension '''
    return sum( [-p*log(p, 2) if p != 0 else 0 for p in 
                 [len(arr)/len(target) for arr in 
                  [target[target==i] for i in 
                   np.unique(target)]]] )

def info_gain(target, data, attr_idx):
    ''' one of the ways used to decide how to split dataset in a tree '''
    return entropy(target) - sum( [ len(sv)/len(target)*entropy(sv) for sv in 
                                   [ target[data[:,attr_idx]==i] for i in 
                                    set(data[:,attr_idx]) ] ] )

def most_common( array ):
    ''' helper function to compute most prevalent value in array '''
    return Counter( array ).most_common(1)[0][0]

def max_ig_attr(target, data):
    all_ig = [info_gain(target, data, i) for i in xrange(data.shape[1])]
    return np.max(all_ig), np.argmax( all_ig )

def id3(target, data, attributes, parent=object(), verbose=True):
    ''' tree algorithm for hierarchical classification of data '''
    
    n = Node(parent)
    
    classes = np.unique( target )
    
    for c in classes:
        if len(target[target==c])==len(target):
            return n.setLabel(c, verbose)

        if data.shape[1]==0:
            return n.setLabel( most_common( target ) )
    
    max_ig, best_attr = max_ig_attr(target, data)
    n.setLabel( best_attr, max_ig )
    for val in np.unique( data[:,best_attr] ):
        mask = data[:,best_attr]==val
        if len(mask) == 0:
            n.addChild( Node(n, value=Counter(target[mask]).most_common(1)) )
        else:
            n.addChild( id3(target[mask], data[mask, :], 
                            attributes[attributes!=best_attr], n) )
    return n

def classify( tree_model, test_data ):    
    ''' inputs are a root of a id3 model and an N x K numpy array representing
        N rows of data with K attributes
    '''
    return np.array( [predict( tree_model, test_data[i, :] ) for i in 
                      xrange(test_data.shape[0])] )

def predict( tree, data_row ):
    ''' helper function to walk the tree along the attribute values of the input data '''
    n = tree
    while not n.is_leaf:
        n = n.children 
    return n.label
    