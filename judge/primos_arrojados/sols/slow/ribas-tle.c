#include <stdio.h>
#include <math.h>

int eh_primo(int n)
{
  if(n==1)
    return 0;
  if(n==2)
    return 1;

  for(int i=3,f=n;i<f;i+=2)
    if(n%i==0)
      return 0;
  return 1;
}

int main(void)
{
  int c;
  int n,t;
  scanf("%d",&c);
  for(int i=0;i<c;i++)
  {
    scanf("%d",&n);
    t=n;
    while(t>0 && eh_primo(t))
    {
      //printf("-- %d\n",t);
      t/=10;
    }
    //printf("--: %d\n",t);
    if(t==0)
      printf("S\n");
    else
      printf("N\n");
  }

  return 0;

}
