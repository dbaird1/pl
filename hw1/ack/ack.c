#include <stdio.h>
#include <limits.h>

int ack(int m,int n);

int main()
{
  ack(3,1000);
}

int ack(int m, int n)
{
  if(m == 0)
    return n+1;
  if(n == 0 && m > 0)
    return ack(m-1, 1);
  if(n>0 && m > 0)
    return ack(m-1,ack(m, n-1));
 return 1;
}
