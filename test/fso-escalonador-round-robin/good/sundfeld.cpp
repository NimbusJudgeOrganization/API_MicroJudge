#include <iostream>
#include <queue>

struct process {
    int pid;
    int time;
};

int main()
{
    int p_num;
    std::vector<process> q;
    int time_slice;
    int current_time = 0;

    std::cin >> p_num;
    std::cin >> time_slice;
    int p_ativos = p_num;
    q.reserve(p_num); 

    for (int i = 0; i < p_num; i++)
    {
        struct process p = {};
        std::cin >> p.pid >> p.time;
        p.time *= 1000;
        q.push_back(p);
    }

    while (p_ativos > 0)
    {
        for (std::vector<process>::iterator it = q.begin(); it!=q.end(); )
        {
            //std::cout << it->pid << ": " << it->time << std::endl;
            if (it->time > time_slice)
            {
                current_time += time_slice;
                it->time -= time_slice;
                ++it;
            }
            else if (it->time > 0)
            {
                current_time += it->time;
                p_ativos--;
                std::cout << it->pid << " (" << current_time << ")\n";
                it = q.erase(it);
            }
        }
    }
    return 0;
}

