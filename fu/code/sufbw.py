import io
import sys
import os
import argparse
from functools import partial
import numpy as np
import time
from tqdm import tqdm
import math


class Suffix:
    def __init__(self, i=0, r=-1, inv=-1):
        self.index = i
        self.rank = r
        self.inv = inv


class SuffixArray:
    def __init__(self, text):
        self.text = text
        n = len(text)
        self.sa = sorted(range(len(text)), key=lambda i: text[i:])
        self.invsa = list(range(len(self.sa)))
        for j in range(n):
            self.invsa[self.sa[j]] = j
        self.sufs = [Suffix(i, self.invsa[i], self.sa[i]) for i in range(n)]
        self._getHeight()
    def getSuffix(self, i):
        s = ""
        while i < len(self.text):
            s += self.text[i]
            i += 1
        return s
    def _getHeight(self):
        """This function creates the height array, assuming the suffix array
        has already been created."""
        n = len(self.sa)
        invsa = self.invsa
        sa = self.sa
        height = [-1 for i in range(n)]
        h = 0 #initial position to compare
        for i in range(n):
            # If current suffix is $ (position 0) leave height undefined.
            if invsa[i] == 0:
                continue
            # get the preceding suffix in the SA
            k = sa[invsa[i] - 1]
            # now compare text[i:] and text[k:] from position h+1 onward
            # because the first h are known to be equal
            while self.text[i + h] == self.text[k + h]:
                # if the last char is not unique ($) then this
                # condition leads to an out of bound error!
                h += 1
            height[invsa[i]] = h
            # For the next pair, we know the will agree on 
            # at least the first h-1 first chars.
            if h > 0:
                h -= 1
        self.height = height
    def lcp(self, i, j):
        """returns the lcp of sa[i] and sa[j].
        This is a toy implementation. An efficient implementation
        would return the entire search tree."""
        n = len(self.sa)
        if i > j:
            return self.lcp(j, i)
        if j >= n:
            return -1  # error
        if i == j:
            return n - self.sa[i]
        if j - i == 1:
            return self.height[j]
        else:
            k = (i + j) // 2
            return min(self.lcp(i, k), self.lcp(k, j))
    def lcpinv(self, i, j):
        """Returns the lcp of the i'th and j'th suffixes of the text.
        remember that i'th position in the SA is invsa[i]."""
        ii = self.invsa[i]
        jj = self.invsa[j]
        return self.lcp(ii,jj)
    def printSA(self):
        """Prints nicely the suffix array (the entire suffixes)"""
        for j in range(len(self.sa)):
            print(str(j).zfill(2), str(self.sa[j]).zfill(2),
                    self.text[self.sa[j] : ],
                    str(self.height[j]).zfill(2))
    def _buildBW(self):
        n = len(self.sa)
        LF = np.zeros_like(self.sa)
        F = [self.text[self.sa[i]] for i in range(n)] 
        bwtext = list(n*"$")
        for i in range(n):
            bwtext[i] = self.text[(self.sa[i] -1) % n]
            #LF[i] = (self.sa[i] - 1) % n
            LF[i] = self.invsa[(self.sa[i] - 1) % n]
        self.F = ''.join(F)
        self.LF = LF
        self.bwtext = ''.join(bwtext)
        self.L = self.bwtext
    def _revBW(self):
        Sigma = np.unique(list(self.F))
        self.Sigma = list(Sigma)
        vals = np.arange(len(Sigma))
        mydict = dict(
                zip(Sigma, vals))
        self.mydict = mydict
        C = np.zeros_like(vals).astype('uint64')
        m = len(vals)
        n = len(self.F)
        Occ = np.zeros((m,n)).astype('uint64')
        k = 0
        for c in self.L:
            C[mydict[c]] += 1
            Occ[mydict[c],k] += 1
            k += 1
        for i in range(m):
            Occ[i] = np.cumsum(Occ[i])
        C = C.cumsum() - C
        self.C = C
        self.Occ = Occ
        LF2 = np.zeros_like(self.LF)
        for i in range(n):
            x = mydict[self.L[i]]
            LF2[i] = C[x] + Occ[x, i] - 1
        self.LF2 = LF2










ttt = np.ones((3,10)).astype('uint64')
ttt
ttt[1,3]


s = "bannanna$"
# remember that if i<k<j, thenlcp(i,j)=min(lcp(i,k),lcp(k,j))

suft = SuffixArray(s)
# suft.sufs[suft.sufs[j].rank].inv == j == suft.sufs[j].index

suft._buildBW()

s = "mississippi$"
suft = SuffixArray(s)
suft._buildBW()
suft.printSA()
suft.bwtext
suft.LF
suft._revBW()
suft.Sigma
suft.mydict
suft.C
suft.Occ
suft.LF
suft.LF2


for i in range(len(s)):
    print(s[suft.F[i]], s[suft.L[i]])

for j in range(9):
    print(j, s[suft.sa[j]:])

print(suft.height)

suft.lcp(5,8)
suft.lcp(5,5)
suft.lcp(2,3)
suft.lcp(1,3)

suft.sufs[4].index
suft.sufs[4].rank
suft.sufs[8].index
suft.sufs[8].rank

suft.getSuffix(0)
suft.getSuffix(4)

print("suffixes  ", [suft.sufs[j].index for j in range(len(s))])

print("suffixes ranks  ", [suft.sufs[j].rank for j in range(len(s))])

print("suffixes inverse  ", [suft.sufs[j].inv for j in range(len(s))])

print(suft.sa)

print(suft.invsa)

# you don't really need the .sufs array, because the class stores the suffix
# array and the inverse suffix array as normal lists of integers.


##### Problem 6
sorted(list("a$#@"))
## '#' < '$' < '@' < 'a'
# we want to find the longest common subseqeunce of 3 different strings X,Y,Z so
# we can solve this as follows: concatenate them: T = X#Y$Z@ and construct
# suffix , inverse suffix and height arrays (in principle can be done in O(n)
# time). 
# we actually won't need invsa
# scan the resulting sa with start,end as proposed by the solution,
# this is done linearly and we then need to calculate lcp on each range so
# O(n log n) in total

X = "abababca"
Y = "aababc"
Z = "aaababca"
T = X + "#" + Y + "$" + Z + "@"
print(T)

suft = SuffixArray(T)

# location of X,Y,Z in sa:
ix = suft.invsa[0]
iy = suft.invsa[len(X)+1]
iz = suft.invsa[len(X)+len(Y)+2]

i = np.min([ix,iy,iz])
j = np.max([ix,iy,iz])

suft.lcp(i,j)

for j in range(len(T)):
    print(j, T[suft.sa[j]:])

indicator = np.zeros(3).astype(int)
mylcp = 0
ix = 0
iy = len(X) + 1
iz = len(X) + len(Y) + 2

# moving on, this one is too tedious ...


###### Problem 7

def longestOddPalindrome(text):
    # concatenate with the reverse
    s = text + "$" + text[-1::-1] + "#"
    maxindex = 0
    maxlen = 0
    n = len(text)
    suft = SuffixArray(s)
    for i in range(n):
        x = suft.lcp(suft.invsa[i], suft.invsa[2*n - i])
        if x > maxlen:
            maxlen = x
            maxindex = i
    center = maxindex
    start = center - maxlen + 1
    end = center + maxlen - 1
    print(s[start: end+1])
    #return (maxindex, maxlen)
    return (start, end, center, 2*maxlen - 1)

longestOddPalindrome("gaabaax")
longestOddPalindrome("aax")

def longestEvenPalindrome(text):
    # concatenate with the reverse
    # we need to check lcp of x_3x_4x_5 with
    # x_2x_1x_0 etc, so we shift +1 vs. the odd palindrome.
    s = text + "$" + text[-1::-1] + "#"
    maxindex = 0
    maxlen = 0
    n = len(text)
    suft = SuffixArray(s)
    for i in range(1,n):
        x = suft.lcp(suft.invsa[i], suft.invsa[2*n - i + 1])
        if x > maxlen:
            maxlen = x
            maxindex = i
    start = maxindex -  maxlen
    end = maxindex + maxlen - 1
    print(s[start: end+1])
    #return (maxindex, maxlen)
    return (start, end, maxindex, 2*maxlen)

longestEvenPalindrome("xxABBA")



#### Problem 10

s = "mississippi$"

s = "aabaabaabaab$"

suft = SuffixArray(s)
suft.printSA()

# let pk = text[0:k] (the k'th prefix, p0 is the empty prefix)
# then pk is a repeat if pk is a prefix of sk text[k:]
# if pk repeats itself we keep checking whether pk is also
# a prefix of text[2k : ] and so forth.
# so for each k we need to check at most n/k times, if we do that for all
# k=0..n-1 we need O(n log n) checks in total (harmonic series).
# checking if pk is a prefix of sk is equivalent to checking whether
# lcp(s0,sk)>=k. So we will need to calculate lcp(s0, sj) for all j=0..n-1 and
# store it. That takes O(n) if we do it cleverly by starting from the position
# of s0 in the sa and stretching from there outward.
# each check requires getting lcp(s0, sj) for some j which we do in O(1) using
# the stored values. In total we need O(nlogn) time.

# step 1: create the lh array, so that lh[i] = lcp(s0,i).
n = len(suft.sa)
k = suft.invsa[0] # location of s0 in the sa

lh = np.zeros(n)

for i in range(n):
    j = suft.invsa[i]
    lh[i] = suft.height[j]

lh

for i in range(k+2, n, 1):
    j = suft.sa[i]
    l = suft.sa[i-1]
    print(i)
    print(suft.text[j:])
    print(suft.text[l:])
    lh[j] = min(lh[j], lh[l])

for i in range(k-1,0,-1):
    print(i)
    j = suft.sa[i]
    l = suft.sa[i+1]
    print(suft.text[j:])
    print(suft.text[l:])
    lh[j] = min(suft.height[i+1], lh[l])
# now lh[j] = lcp(s0, sj)
lh

# so now we will go over each prefix and check how many times it repeats and we
# will store it in an array repeats, so repeat[i] = number of times prefix si
# repeats itself consequetively.

repeats = np.zeros(n)

repeats = np.ones(n).astype(int)
for k in range(1,n,1):
    j = 1
    while j*k < n:
        # check if repeats
        # is text[:k] a prefix of text[j*k:]?
        if lh[j*k] >= k:
            j+=1
        else:
            break
    repeats[k] = j

# now we can fill in the periods of each prefix
# again taking O(n log n)
# we go in order of the repetitiveness, meaning
# the prefix that repeats the most times will be visited last
periods = np.zeros(n).astype(int)

for j in np.argsort(repeats):
    i = repeats[j]
    print(j)
    # s[:j] <> period[j]
    while( i > 0):
        periods[i*j] = i
        i -=1
for i in range(n):
    print(s[:i], periods[i])

