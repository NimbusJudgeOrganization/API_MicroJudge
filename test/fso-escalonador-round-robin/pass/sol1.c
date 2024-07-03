#include <stdio.h>
#include <stdlib.h>
typedef struct Process {
    int pid;
    int remaining_time;
    struct Process* next;
} Process;
void robin(int* pid, int* time, int quantum, int n) {
    Process* head = NULL;
    Process* tail = NULL;
    // Create a circular linked list of processes
    for (int i = 0; i < n; i++) {
        Process* new_process = (Process*)malloc(sizeof(Process));
        new_process->pid = pid[i];
        new_process->remaining_time = time[i];
        new_process->next = NULL;
        if (head == NULL) {
            head = new_process;
            tail = new_process;
            tail->next = head;
        } else {
            tail->next = new_process;
            tail = new_process;
            tail->next = head;
        }
    }
    int total_time = 0;
    Process* current = head;
    while (head != NULL) {
        if (current->remaining_time <= quantum) {
            total_time += current->remaining_time;
            printf("%d (%d)\n", current->pid, total_time);
            Process* temp = current;
            if (current == head && current == tail) {
                head = NULL;
                tail = NULL;
            } else {
                Process* prev = head;
                while (prev->next != current)
                    prev = prev->next;
                if (current == head)
                    head = head->next;
                prev->next = current->next;
                if (current == tail)
                    tail = prev;
            }
            current = current->next;
            free(temp);
        } else {
            total_time += quantum;
            current->remaining_time -= quantum;
            current = current->next;
        }
    }
}
int main() {
    int n, quantum = 0;
    int* pid, * time;
    scanf("%d", &n);
    pid = malloc(sizeof(int) * n);
    time = malloc(sizeof(int) * n);
    scanf("%d", &quantum);
    for (int i = 0; i < n; i++) {
        scanf("%d", &pid[i]);
        scanf("%d", &time[i]);
        time[i] = time[i] * 1000;
    }
    robin(pid, time, quantum, n);
    free(pid);
    free(time);
    return 0;
}
