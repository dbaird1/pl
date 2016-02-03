#! /usr/bin/env python

import sys

def powF(n, p):
  if p == 0:
    return 1
  else:
    return n * pow(n, p-1) 

def powI(n,p):
  if p == 0:
    return 1;
  s = 1
  while p > 0:
    p-=1
    s= s*n
  return s
if len(sys.argv) != 3:
  print("%s usage: [NUMBER] [power]" % sys.argv[0])
  exit()

print(powF(int(sys.argv[1]), int(sys.argv[2])))
print(powI(int(sys.argv[1]), int(sys.argv[2])))
