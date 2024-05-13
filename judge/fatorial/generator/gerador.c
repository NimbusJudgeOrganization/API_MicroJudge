#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>
#include <limits.h>

int fatorial(int n){
    int fat = 1;
    int i;

    for(i = 2; i <= n; i++){
        fat = fat * i;
    }

    return fat;
}

int main()
{
  FILE *fp, *fp2;
  char filename[50];

  int n;

  srand((unsigned)time(NULL));

  for (int i = 0; i <= 15; i++)
  {

    //GERANDO VALORES ALEATÓRIOS
    n = 0;

    snprintf(filename, 50, "input/test-%03d", i + 1);
    fp = fopen(filename, "wb");

    n = i;
    fprintf(fp, "%d\n", n);

    fclose(fp);

    //LENDO VALORES SALVO NOS ARQUIVOS
    n = 0;

    snprintf(filename, 50, "input/test-%03d", i + 1);
    fp = fopen(filename, "r");
    snprintf(filename, 50, "output/test-%03d", i + 1);
    fp2 = fopen(filename, "wb");

    fscanf(fp, "%d", &n);

    fclose(fp);

    fprintf(fp2, "%d\n", fatorial(n));
    
    fclose(fp2);
  }

  return 0;
}