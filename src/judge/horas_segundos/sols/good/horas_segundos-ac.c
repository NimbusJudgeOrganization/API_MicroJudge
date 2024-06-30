#include <stdio.h>

int main(){

	long long int horas;
	long long int minutos, segundos;

	scanf("%llu", &horas);

	minutos = horas * 60;
	segundos = horas * 3600;

	printf("%llu\n%llu\n", minutos, segundos);

	return 0;
}