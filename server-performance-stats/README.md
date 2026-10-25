# Server Performance Stats

A lightweight Bash script for monitoring basic Linux server performance metrics from the command line.

The script collects CPU usage, memory usage, disk usage, and the top processes consuming CPU and memory.

## Features

- Total CPU usage
- Total memory:
  - Used memory
  - Available memory
  - Memory usage percentage
- Root filesystem (`/`) disk usage:
  - Total disk space
  - Used disk space
  - Available disk space
  - Disk usage percentage
- Top 5 processes by CPU usage
- Top 5 processes by memory usage

## Project Structure

```text
server-performance-stats/
├── server-stats.sh
└── README.md
```

## Requirements

This script is intended for **Linux systems**.

The script uses standard Linux utilities and interfaces including:

- Bash
- `awk`
- `bc`
- `free`
- `df`
- `ps`
- `sort`
- `head`
- `tail`
- `/proc/stat`

Some of these commands and interfaces are Linux-specific and may not be available or behave identically on macOS or other operating systems.

## Usage

Clone the repository and navigate to the project directory:

```bash
git clone <repository-url>
cd devops-mini-proj/server-performance-stats
```

Make the script executable:

```bash
chmod +x server-stats.sh
```

Run the script:

```bash
./server-stats.sh
```

Alternatively:

```bash
bash server-stats.sh
```

## Example Output

```text
========================
Server Performance Stats
========================

CPU Usage
Total CPU Usage %: 23.47%

------------------------

Memory Usage
------------------------
Total:     15.6Gi
Used:      7.8Gi
Available: 7.5Gi
Usage %: 50.21%

------------------------

Disk Usage
------------------------
Total Disk Space: 228G
Used: 80G
Available: 137G
Usage %: 37%

------------------------

Top 5 Processes by CPU Usage
------------------------
PID CPU% MEM% COMMAND
1234 12.4 2.1 python
5678 8.7 1.5 nginx
...

------------------------

Top 5 Processes by Memory Usage
------------------------
PID CPU% MEM% COMMAND
5678 8.7 5.2 java
1234 12.4 2.1 python
...
```

> The exact values and processes will vary depending on the system on which the script is executed.

## How It Works

### CPU Usage

CPU usage is calculated using two snapshots of the aggregate CPU counters from `/proc/stat`, taken one second apart.

The script calculates the change in total CPU time and idle CPU time between the two snapshots.

```text
CPU Usage = 100 - (Idle Time Difference / Total Time Difference × 100)
```

### Memory Usage

Memory information is obtained using the `free` command.

The script reports:

- Total memory
- Used memory
- Available memory
- Memory usage percentage

```text
Memory Usage = Used Memory / Total Memory × 100
```

### Disk Usage

Disk information is obtained using `df`.

The script monitors the filesystem mounted at `/` and reports its total, used, available, and percentage utilization.

### Process Usage

The `ps aux` command provides information about currently running processes.

The output is sorted numerically by:

- `%CPU` for CPU-intensive processes
- `%MEM` for memory-intensive processes

The five highest-consuming processes are then displayed.

## Limitations

This project is intended as a learning project and basic command-line monitoring utility rather than a production monitoring solution.

Current limitations include:

- Monitors only the root (`/`) filesystem for disk usage.
- CPU usage is calculated over a one-second sampling interval.
- Process information is captured at a single point in time.
- The script depends on Linux-specific commands and `/proc` interfaces.
- No continuous monitoring or historical data collection is implemented.
- No alerts or threshold-based notifications are implemented.

## Learning Objectives

This project was built to practice fundamental Linux and Bash scripting concepts, including:

- Bash scripting
- Linux system information
- `/proc` filesystem
- Command substitution
- Bash arithmetic
- Pipes and command chaining
- `awk`
- `sort`
- `head` and `tail