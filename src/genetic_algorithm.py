'''
Created on May 12, 2013

@author: paul
'''
import numpy as np

class GA(object):
    
    def __init__(self, population, fitness, p_next, max_n_iter=100, fitness_threshold=0.9):
        self.n_iter = 0
        self.p_next = p_next
        self.population = population
        self.fitness = fitness
        self.max_n_iter = max_n_iter
        self.fitness_threshold = fitness_threshold
    
    def update(self, population, p_co, fitness):
        """ fitness is a numpy vectorized function """
        fit = fitness( population )
        next_pop = np.random.choice( population, int(len(population)*self.p_next), 
                                     replace=False, p=fit / sum(fit))
        if np.max( fit ) < self.fitness_threshold and self.n_iter < self.max_n_iter:
            fit_population = fit[ np.random.randint(0, len(fit), int(2*len(fit)*self.p_next)/2) ]
        else:
            return np.max( fit ) 
    
    def crossover(self, population):
        pass
    
    def mutation(self, population):
        pass