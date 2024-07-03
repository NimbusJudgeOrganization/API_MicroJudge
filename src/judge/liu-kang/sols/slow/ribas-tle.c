#include <stdio.h>
#include <math.h>

int main(void)
{
  unsigned long ta,gm,i;
  scanf("%ld %ld",&ta,&gm);
  for(i=0;i<gm;i++)
  {
    unsigned long prox=1,tmp=1;
    unsigned long raiz=(unsigned long)sqrt(ta);
    unsigned long fim=raiz;
    if(ta%2==0)
      fim=raiz/2;

    while(tmp<fim)
    {
      prox+=2;
      tmp++;
    }
    prox=prox*prox;
    printf("%ld\n",prox);
    ta=prox;
  }
  return 0;
}
