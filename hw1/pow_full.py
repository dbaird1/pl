#! /usr/bin/env python

import sys

def pow(n, p):
  if p == 0:
    return 1
  else:
    return n * pow(n, p-1) 

if len(sys.argv) != 3:
  print("%s usage: [NUMBER] [power]" % sys.argv[0])
  exit()

print(pow(int(sys.argv[1]), int(sys.argv[2])))
