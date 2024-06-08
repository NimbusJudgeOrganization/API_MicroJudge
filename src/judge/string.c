#include <stdio.h>

int tamStr(char *str) {
  int tam;
  for( tam = 0; str[tam] != '\0'; tam++ );
  return tam;
}

int main() {
  char string[101];
  int n, max, tam;

  scanf( "%d", &n );

  max = 0;
  for ( int i = 0; i < n; i++ ) {
    scanf( "%s", string );
    tam = tamStr(string);
    if ( tam > max ) max = tam;
  }

  printf( "%d\n", max );

  return 0;
}
