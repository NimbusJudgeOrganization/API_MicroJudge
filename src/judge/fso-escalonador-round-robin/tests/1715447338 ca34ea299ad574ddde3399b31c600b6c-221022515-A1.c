#include <stdlib.h>
#include <stdio.h>
typedef struct {
	int id;
	long long unsigned int ExecTime;
} processo;
void mover_para_ultima_posicao_struct(processo *vetor, int tamanho_vetor, int i) {
  if (i < 0 || i >= tamanho_vetor) {
    printf("Índice inválido: %d.\n", i);
    return;
  }
  processo elemento_mover = vetor[i];
  for (int j = i; j < tamanho_vetor - 1; j++) {
    vetor[j] = vetor[j + 1];
  }
  vetor[tamanho_vetor - 1] = elemento_mover;
}
int main() {
	int N;
	int time;
	long long unsigned int timeTotal = 0;
	long long unsigned int ExecTime = 0;	
	scanf("%d", &N);
	scanf("%d", &time);
	
	processo *process = malloc(N * sizeof(processo));
	for(int i=0;i < N;i++) {
		scanf("%d %llu", &process[i].id, &process[i].ExecTime);
		process[i].ExecTime *= 1000;
		timeTotal += process[i].ExecTime;
	}
	int qnt = N;
	int verificador = 0;
	while(ExecTime <  timeTotal) {
		int i = 0;
		while (i < qnt) {
			verificador = 0;
			//printf("Tempo restante: %d <-> ID: %d\n", process[i].ExecTime, process[i].id);
			if(process[i].ExecTime > 0) {
				process[i].ExecTime -= time;
				ExecTime += time;
			}
			//printf("TEMPO DE EXECUCAO TOTAL: %d\n", ExecTime);
			if (process[i].ExecTime == 0) {
				printf("%d (%llu)\n", process[i].id, ExecTime);
				mover_para_ultima_posicao_struct(process, qnt, i);
				/*for (int a = 0; a < qnt; a++) {
					printf("id: %d\n", process[a].id);	
			
				}*/
				qnt--;
				verificador = 1;
                        }
			if(verificador == 0) {	
			i++;
			}
		}
	}
	free(process);
	return 0;
}
