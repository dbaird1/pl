#! /usr/bin/env python

import sys

def ack(m,n):
    print(n)
    if(m == 0):
        return n+1;
    if(n == 0 and m > 0):
        return ack(m-1, 1);
    if(n>0 and m > 0):
        return ack(m-1,ack(m, n-1));
    return 1;



if len(sys.argv) != 2:
  print("%s usage: [NUMBER]" % sys.argv[0])
  exit()

ack(3,int(sys.argv[1]))
