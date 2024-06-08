//#include <stdio.h>

int fatorial(int n){
    int fat = 1;
    int i;

    for(i = 2; i <= n; i++){
        fat = fat * i;
    }

    return fat;
}

/*int main(){
  int n;

  scanf("%d", &n);
  printf("%d\n", fatorial(n));

  return 0;
}*/
