import sys
import pandas as pd
import numpy as np

expected = pd.read_csv('testset.txt')['y']
results = pd.read_csv(sys.argv[1]).iloc[:,1]

diff = expected.eq(results)
print(np.sum(diff)/diff.size)

