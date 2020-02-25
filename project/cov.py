import sys
import pandas as pd
import numpy as np

f = open(sys.argv[1], 'r')

for l in f:
    ll=l.split('\t')
    n = int(ll[2])
    m = int(ll[3])
    x = str(round(m/n), 2)
    ll[-1] = ll[-1].strip()
    ll.append(x)
    s = "\t".join(ll)
    print(s + " " + x)
