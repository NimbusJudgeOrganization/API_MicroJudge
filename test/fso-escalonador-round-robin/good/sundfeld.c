#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct process {
    int pid;
    int time;
};

int main()
{
    int p_num;
    struct process *q;
    int time_slice;
    int current_time = 0;

    scanf("%d %d", &p_num, &time_slice);
    int p_ativos = p_num;
    q = malloc (sizeof(struct process) * p_num);

    for (int i = 0; i < p_num; i++)
    {
        scanf("%d %d", &q[i].pid, &q[i].time);
        q[i].time *= 1000;
    }

    while (p_ativos > 0)
    {
        for (int i = 0; i < p_ativos; )
        {
            //std::cout << it->pid << ": " << it->time << std::endl;
            if (q[i].time > time_slice)
            {
                current_time += time_slice;
                q[i].time -= time_slice;
                ++i;
            }
            else if (q[i].time > 0)
            {
                current_time += q[i].time;
                p_ativos--;
                printf("%d (%d)\n", q[i].pid, current_time);
                memmove(&q[i], &q[i+1], (p_ativos - i) * sizeof(struct process));
            }
        }
    }
    free(q);
    return 0;
}

