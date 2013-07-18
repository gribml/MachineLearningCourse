'''
Created on Jul 16, 2013

@author: paul
'''

from __future__ import division

import unittest
from decision_tree import *
# import numpy as np
# from functools import partial 
# from math import log

class UtilsTest(unittest.TestCase):

    def test_len_ratio(self):
        arr = np.array([0,0,0,0,1])
        self.assertEqual( frequency( arr, 1), 0.2 )
        self.assertEqual( frequency( arr, 0), 0.8 )
    
    def test_my_log(self):
        self.assertEqual( safe_log(2), log(2, 2) )
        self.assertEqual( safe_log(15.423), log(15.423, 2) )
        self.assertEqual( safe_log(0), 0 )
        self.assertEqual( safe_log(-1.25), 0 )
        
    def test_log_calc(self):
        N = 100
        arr = np.random.rand(N) - 1.0
        v = []
        for i in xrange(N):
            v.append( safe_log( arr[i] ) )
        self.assertTrue( np.all( log_calc( arr ) == np.array(v) ) )
    
    def test_p_calc(self):
        N = 100
        M = 10
        arr = np.random.randint(0, M, N)
        v = []
        for i in xrange( M ):
            v.append( frequency( arr, i ) )
    
        p_with_arr = partial( frequency, arr )
        p_calc = np.vectorize( p_with_arr )
        self.assertTrue( np.all( p_calc( range(M) ) == v ) )
        
    def test_entropy(self):
        N = 100
        target = np.zeros( N )
        self.assertAlmostEqual(entropy( target ), 0, 10)
        
        target = np.random.randint(0, 2, N)
        p0 = len( target[target==0] ) / N
        p1 = len( target[target==1] ) / N
        
        self.assertAlmostEqual( p0, 1.0 - p1 )
        e = -p0 * np.log2(p0) - p1 * np.log2(p1)
        self.assertAlmostEqual( entropy(target), e )
        
    def test_most_common(self):
        a1 = np.array([1,1,1,2,2,3])
        self.assertEqual(most_common(a1), 1)
        
        a2 = np.array(['a', 'b', 'c', 'd', 'b'])
        self.assertEqual(most_common(a2), 'b')
        
        a3 = [-1, 0, 1, 2, 3, 15, 'd']
        self.assertEqual(most_common(a3), 0)        
        
    def test_entropies(self):
        for n in range(3, 8):
            rand_arr = np.random.randint(0, 2, 10**n)
            self.assertEqual( entropy(rand_arr), entropy_old( rand_arr ) )
            self.assertEqual( entropy_old(rand_arr), entropy_inefficient( rand_arr ) )    
    
    def test_id3(self):
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
#         tree_printer(tree)
        
        d2 = np.array([[1,1,0,1,1,0],
                       [1,1,1,1,1,0],
                       [0,0,1,1,1,1],
                       [1,1,1,1,0,1],
                       [1,1,0,0,1,0]])
        t2 = np.array([1,1,0,1,0])
#         print entropy(t2)
#         for i in range(6):
#             print info_gain(t2, d2, i)
    
if __name__=='__main__':
    
    unittest.main()
