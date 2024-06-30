#include <stdio.h>
#include <math.h>

int main(void)
{
  unsigned long ta,gm,i;
  scanf("%ld %ld",&ta,&gm);
  for(i=0;i<gm;i++)
  {
    unsigned long qp=(unsigned long)sqrt(ta);

    unsigned long prox;
    if(ta%2==0)
      prox=1+(qp/2-1)*2;
    else
      prox=1+(qp-1)*2;
    prox=prox*prox;
    printf("%ld\n",prox);
    ta=prox;
  }
  return 0;
}
