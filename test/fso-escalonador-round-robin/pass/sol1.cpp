#include <iostream>
#include <deque>
#include <vector>
using namespace std;
typedef pair<int, int> Process;
vector<Process> roundRobinScheduling(int T, vector<Process>& processes) {
    deque<Process> queue;
    for (auto& process : processes) {
        queue.push_back(process);
    }
    int current_time = 0;
    vector<Process> completed_processes;
    while (!queue.empty()) {
        auto process = queue.front();
        queue.pop_front();
        int pid = process.first;
        int execution_time = process.second;
        if (execution_time <= T) {
            current_time += execution_time;
            completed_processes.push_back({pid, current_time});
        } else {
            current_time += T;
            queue.push_back({pid, execution_time - T});
        }
    }
    return completed_processes;
}
int main() {
    int N, T;
    cin >> N >> T;
    vector<Process> processes;
    for (int i = 0; i < N; i++) {
        int pid, execution_time;
        cin >> pid >> execution_time;
        processes.push_back({pid, execution_time * 1000});  // Convertendo para milissegundos
    }
    vector<Process> result = roundRobinScheduling(T, processes);
    for (auto& process : result) {
        int pid = process.first;
        int turnaround_time = process.second;
        cout << pid << " (" << turnaround_time << ")" << endl;
    }
    return 0;
}
