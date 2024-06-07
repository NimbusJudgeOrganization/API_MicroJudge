/*
 * Solucao simplificada para que o TL seja adequado a solucao forca
 * bruta.
 * 
 * Autor: John L. Gardenghi
 *
 */

#include <math.h>
#include <stdio.h>

int main() {
  int casos, i, j, numero, primo_arrojado;

  scanf( "%d", &casos );

  for ( i = 0; i < casos; i++ ) {
    scanf( "%d", &numero );

    primo_arrojado = 1;
    while ( primo_arrojado && numero > 0 ) {
      if ( numero == 1 ) {
	primo_arrojado = 0;
      } else {
	for ( j = 2; primo_arrojado && j <= numero / 2; j++ ) {
	  if ( numero % j == 0 ) primo_arrojado = 0;
	}
      }
      numero /= 10;
    }

    if ( primo_arrojado )
      printf( "S\n" );
    else
      printf( "N\n" );
  }

  return 0;
}
