#!/bin/bash

echo "========================"
echo "Server Performance Stats"
echo "========================"

# CPU usage


echo "CPU Usage"

idle1=$(awk '$1 == "cpu" {print $5}' /proc/stat)
total1=$(awk '$1 == "cpu" {print $2 + $3 + $4 + $5 + $6 + $7 + $8 + $9}' /proc/stat)

sleep 1

idle2=$(awk '$1 == "cpu" {print $5}' /proc/stat)
total2=$(awk '$1 == "cpu" {print $2 + $3 + $4 + $5 + $6 + $7 + $8 + $9}' /proc/stat)

idle_diff=$((idle2 - idle1))
total_diff=$((total2 - total1))

cpu_usage=$(echo "scale=2; 100 - ($idle_diff/$total_diff)*100" | bc)


echo "Total CPU Usage %: $cpu_usage%"

echo "------------------------"



# Memory Usage


echo "Memory Usage"

echo "------------------------"

# Raw values for calculation
total=$(free | awk '$1 == "Mem:" {print $2}')
used=$(free | awk '$1 == "Mem:" {print $3}')
available=$(free | awk '$1 == "Mem:" {print $7}')

# Human-readable values for display
total_h=$(free -h | awk '$1 == "Mem:" {print $2}')
used_h=$(free -h | awk '$1 == "Mem:" {print $3}')
available_h=$(free -h | awk '$1 == "Mem:" {print $7}')

echo "Total:     $total_h"
echo "Used:      $used_h"
echo "Available: $available_h"

mem_usage=$(echo "scale=2; $used / $total * 100" | bc)

echo "Usage %: $mem_usage%"

echo "------------------------"


# Disk Usage

echo "Disk Usage"

echo "------------------------"

total_disk=$(df -h | awk '$6 == "/" {print $2}')
used_disk=$(df -h | awk '$6 == "/" {print $3}')
available_disk=$(df -h | awk '$6 == "/" {print $4}')
usage_percent=$(df -h | awk '$6 == "/" {print $5}')

echo "Total Disk Space: $total_disk"
echo "Used: $used_disk"
echo "Available: $available_disk"
echo "Usage %: $usage_percent"

echo "------------------------"

# Top 5 processes by CPU Usage

echo "Top 5 Processes by CPU Usage"

echo "------------------------"

ps aux | tail -n +2 | sort -k 3 -n -r | head -n 5 | awk '
BEGIN {
        print "PID", "CPU%", "MEM%", "COMMAND"
}
{
        print $2, $3, $4, $11
}
'

echo "------------------------"

# Top 5 processes by Mem Usage

echo "Top 5 Processes by Memory Usage"

echo "------------------------"

ps aux | tail -n +2 | sort -k 4 -n -r | head -n 5 | awk '
BEGIN {
        print "PID", "CPU%", "MEM%", "COMMAND"
}
{
        print $2, $3, $4, $11
}
'

echo "------------------------"




