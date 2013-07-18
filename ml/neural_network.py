'''
Created on May 2, 2013

@author: paul
'''

import math, cmath
import numpy as np
import matplotlib.pyplot as plt

def sigmoid(x):
    return 1/(1 + math.exp(-x))

def softmax(xs, i):
    return math.exp(xs[i]) / sum([math.exp(x) for x in xs])

class NeuralNetwork(object):
    def __init__(self):
        self.activation = None
        self.hidden = None
        self.weights = None
        
    def setLayerStructure(self, hiddenLayers):
        """ hiddenLayers should look like: [2,3,...] """
        self.hidden = hiddenLayers
        if not self.activation:
            self.activation = [] * len(hiddenLayers)
        elif len(self.hidden) > len(self.activation):
            self.activation += [0] * (len(self.hidden) - len(self.activation))
        elif len(self.hidden) < len(self.activation):
            self.activation = self.activation[0:len(self.hidden)]
            
    def setActivation(self, function, forLayer=0):
        try:
            self.activation[forLayer] = np.vectorize(function)
        except IndexError:
            print 'activation not set; index ' + str(forLayer) + ' exceeds current number of layers: ' + \
                  str(len(self.activation)) + '.  Call setLayerStructure(anIntList) to change this.'
                  
    def learnBP(self, learningData, learningOutputs):
        pass
    
    def learnGD(self, learningData, learningOutputs):
        pass
    
    def learnSGD(self, learningData, learningOutputs):
        pass
    
    def predict(self, testingInputs):
        if not (self.hidden and self.activation and self.weights):
            raise NetworkNotReadyError(self.hidden, self.activation, self.weights)
        elif testingInputs.shape[::-1] == self.weights.shape:
            testingInputs = testingInputs.T
        else:
            pred = np.zeros( (testingInputs.shape[0], self.weights.shape[2]), dtype=float )
            for idx, obs in enumerate(np.nditer(testingInputs)): 
                a = obs
                for hiddenLayer in self.hidden:
                    a = self.activation[hiddenLayer](self.weights[hiddenLayer,:,:] * a)
                pred[idx,:] = self.weights[-1,:,:] * a

class NetworkNotReadyError(Exception):
    def __init__(self, hidden, activation, weights):
        super( NetworkNotReadyError, self).__init__()
        self.hidden = hidden
        self.activation = activation
        self.weights = weights
        self.failed = [hidden is None, activation is None, weights is None]  
    def __str__(self):
        return repr(self.failed)