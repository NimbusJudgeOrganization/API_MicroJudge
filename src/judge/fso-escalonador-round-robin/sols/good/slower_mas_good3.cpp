#include <iostream>
#include <queue>
using namespace std;
struct Process {
    int pid;         // Identificador do processo
    int executionTime;   // Tempo de execução do processo em segundos
    int remainingTime;   // Tempo restante para execução do processo em milissegundos
};
void roundRobinScheduling(int numProcesses, int timeSlice) {
    queue<Process> readyQueue;
    
    // Leitura dos processos
    for (int i = 0; i < numProcesses; i++) {
        Process process;
        cin >> process.pid;
        cin >> process.executionTime;
        process.remainingTime = process.executionTime * 1000;  // Converte o tempo para milissegundos
        readyQueue.push(process);
    }
    
    // Execução do escalonador
    int currentTime = 0;
    while (!readyQueue.empty()) {
        Process currentProcess = readyQueue.front();
        readyQueue.pop();
        
        int executionTime = min(timeSlice, currentProcess.remainingTime);
        currentProcess.remainingTime -= executionTime;
        currentTime += executionTime;
        
        if (currentProcess.remainingTime > 0) {
            readyQueue.push(currentProcess);
        } else {
            cout << currentProcess.pid << " (" << currentTime << ")\n";
        }
    }
}
int main() {
    int numProcesses;
    cin >> numProcesses;
    
    int timeSlice;
    cin >> timeSlice;
    
    roundRobinScheduling(numProcesses, timeSlice);
    
    return 0;
}
