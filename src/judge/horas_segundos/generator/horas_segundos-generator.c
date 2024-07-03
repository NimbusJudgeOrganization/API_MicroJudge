#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>

long int randBigNumber(){
	int random =  rand() & 255;
	random = random<<8 | (rand() & 255);
	random = random<<8 | (rand() & 255);
	random = random<<7 | (rand() & 127);

	return random;
}

int main(){
	FILE *fp;
  	char filename[5];

	unsigned long long int horas;
	unsigned long long int minutos, segundos;

	srand((unsigned)time(NULL));

  	for(int i = 0; i < 50; i++ ) {

  		//GERANDO VALORES ALEATÓRIOS
  		horas = 0;

  		snprintf( filename, 50, "in%d", i+1 );
  		fp = fopen( filename, "wb" );
		horas = randBigNumber();
		fprintf( fp, "%llu\n", horas);
  		fclose( fp );

  		//LENDO VALORES SALVO NOS ARQUIVOS
		horas = 0;

  		snprintf( filename, 50, "in%d", i+1 );
	    fp = fopen( filename, "r" );

		fscanf( fp, "%d", &horas);
  		fclose( fp );

		

		//SALVANDO VALORES DE SAIDA
		snprintf( filename, 50, "out%d", i+1 );
    	fp = fopen( filename, "wb" );

		minutos = horas * 60;
		segundos = horas * 3600;

		fprintf(fp, "%llu\n%llu\n", minutos, segundos);

		fclose( fp );
	}

	return 0;
}