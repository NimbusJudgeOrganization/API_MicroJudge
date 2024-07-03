#include <iostream>
#include <queue>

struct process {
    int pid;
    int time;
};

int main()
{
    int p_num;
    std::queue<process> q;
    int time_slice;
    int current_time = 0;

    std::cin >> p_num;
    std::cin >> time_slice;

    for (int i = 0; i < p_num; i++)
    {
        struct process p = {};
        std::cin >> p.pid >> p.time;
        p.time *= 1000;
        q.push(p);
    }

    while (!q.empty())
    {
        struct process p = q.front();
        q.pop();

        //std::cout << p.pid << ": " << p.time << std::endl;
        p.time -= time_slice;
        current_time += time_slice;

        if (p.time > 0)
            q.push(p);
        else
            std::cout << p.pid << " (" << current_time << ")\n";
    }
    return 0;
}

