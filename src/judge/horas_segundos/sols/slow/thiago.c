#include <stdio.h>
int main()
{
    long int hora;
    scanf("%ld", &hora);
    long long int minuto = 0, segundo = 0;
    
    for(int i = 0; i < hora; i++){
        minuto = minuto + 60;
        segundo = segundo + 3600;
    }
    printf("%lld\n", minuto);
    printf("%lld\n", segundo);
    return 0;
}
