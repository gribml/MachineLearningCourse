# -*- coding: utf-8 -*-

from sklearn import neighbors
from sklearn.cross_validation import StratifiedKFold, KFold
from scipy.io import loadmat
import numpy as np

data = loadmat('./cleandata_students.mat')
X = data['x']
y = data['y']
y = y.transpose()[0]

knn = neighbors.KNeighborsClassifier(n_neighbors=3, warn_on_equidistant=False, algorithm='auto')

for i in [10, 20, 30, 40, 100]:
    kf = StratifiedKFold(y, k=i)
    score = []
    error = []
    for train, test in kf:
        knn.fit(X[train], y[train])
        error.append(np.mean(knn.predict(X[test]) != y[test]))
        score.append(knn.score(X[test], y[test]))
    
    score = np.mean(score)
    error = np.mean(error)

    print("** %d folds, score = %f %%, error = %f %%" % (i, score, error))

