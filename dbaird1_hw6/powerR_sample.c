#include <stdio.h>

int  powerR(int pow, int base) {
  if (0==pow) {
    return 1;
  } else {
    return base * powerR(pow-1, base);
  }
}

int main()
{
  printf("%d\n",powerR(3,4));
  return 0;
}
