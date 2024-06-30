#include <stdlib.h>
#include <stdio.h>
typedef struct {
	int id;
	int ExecTime;
} processo;
int main() {
	int N;
	int time;
	int timeTotal = 0;
	int ExecTime = 0;
	
	scanf("%d", &N);
	scanf("%d", &time);
	
	processo *process = malloc(N * sizeof(processo));	
	for(int i=0;i < N;i++) {
		scanf("%d %d", &process[i].id, &process[i].ExecTime);
		process[i].ExecTime *= 1000;
		timeTotal += process[i].ExecTime;
	}
	
	//printf("TEMPO DE EXECUCAO TOTAL: %d\n", timeTotal);
	while(ExecTime <  timeTotal) {
		//printf("TEMP DE EXECUCAO VARIADO: %d\n", ExecTime);
		//printf("Exectime: %d\n timeTotal: %d\n", ExecTime, timeTotal);
		int i = 0;
		while (i < N) {
			if(process[i].ExecTime > 0 && process[i].ExecTime != -1) {
				process[i].ExecTime -= time;
				ExecTime += time;
			}
			if (process[i].ExecTime == 0) {
				//printf("TempoProc: %d", process[i].ExecTime );
				printf("%d (%d)\n", process[i].id, ExecTime);
				process[i].ExecTime = -1;
			}
			i++;
			//printf("PROCESSO %d: %d\n\n",i ,process[i].ExecTime);
			//ExecTime += time;
		}
		
		//printf("\n");
	}
	/*for (int i = 0; i<N;i++) {
		printf("id: %d - tempo de tarefa: %d\n", process[i].id, process[i].ExecTime);
	}*/
	return 0;
}
