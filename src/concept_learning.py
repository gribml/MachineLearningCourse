'''
Created on May 2, 2013

@author: paul
'''
import numpy as np

neg_inf = float('-inf')
inf = float('inf')

def satisfied(data, hypothesis):
    return (hypothesis <= data).all()

def nextMostGeneral(value, otherVal):
    if value == neg_inf:
        return otherVal
    elif value < inf and value != otherVal:
        return inf
    else:
        return value
        

def find_s(data, target):
    """ assumes target only has 0s and 1s """
    hyp = np.array([inf] * data.shape[1])
    
    posData = data[target>0,:]
    for idx, j in enumerate(posData):
        if j > hyp[idx]:
            hyp[idx] = nextMostGeneral(hyp[idx], j) 
    return hyp

def tests():
    data = np.array([[1,0,1,0,0,1],[0,0,1,]])