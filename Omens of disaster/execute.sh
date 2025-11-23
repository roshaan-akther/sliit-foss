#!/bin/bash

# Omens of Disaster: Real-Time System Monitoring with Alerts

# Configuration
MONITOR_INTERVAL=2  # seconds
CPU_THRESHOLD=80    # percentage - system typically reaches 80% during intensive tasks
MEM_THRESHOLD=85    # percentage
DISK_THRESHOLD=90   # percentage

# Colors for status indicators
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Calculate CPU usage percentage
get_cpu_usage() {
    # Extract CPU usage from top command output
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    echo "$cpu_usage"
}

# Calculate memory usage percentage
get_memory_usage() {
    # Compute memory usage from free command output
    mem_total=$(free | grep Mem | awk '{print $2}')
    mem_used=$(free | grep Mem | awk '{print $3}')
    if [ "$mem_total" -gt 0 ]; then
        mem_usage=$(echo "scale=2; $mem_used * 100 / $mem_total" | bc)
        echo "$mem_usage"
    else
        echo "0.00"
    fi
}

# Calculate disk usage percentage
get_disk_usage() {
    # Extract root filesystem usage from df command
    disk_usage=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
    echo "$disk_usage"
}

# Retrieve system load average
get_load_average() {
    # Extract 1-minute load average from uptime command
    load_avg=$(uptime | awk -F'load average:' '{ print $2 }' | cut -d, -f1 | sed 's/ //g')
    echo "$load_avg"
}

# Check status of critical system services
check_services() {
    services=("sshd" "systemd" "dbus")
    down_services=()

    for service in "${services[@]}"; do
        if ! systemctl is-active --quiet "$service" 2>/dev/null; then
            down_services+=("$service")
        fi
    done

    echo "${down_services[@]}"
}

# Display real-time system monitoring dashboard
display_dashboard() {
    local cpu=$1
    local mem=$2
    local disk=$3
    local load=$4
    local down_services=$5

    clear
    echo "System Monitoring Dashboard"
    echo "=========================="
    echo

    # CPU Usage
    if (( $(echo "$cpu > $CPU_THRESHOLD" | bc -l) )); then
        echo -e "[CRITICAL] CPU Usage:     ${RED}$cpu%${NC} (THRESHOLD: $CPU_THRESHOLD%)"
    elif (( $(echo "$cpu > 60" | bc -l) )); then
        echo -e "[WARNING] CPU Usage:     ${YELLOW}$cpu%${NC} (THRESHOLD: $CPU_THRESHOLD%)"
    else
        echo -e "[OK] CPU Usage:     ${GREEN}$cpu%${NC} (THRESHOLD: $CPU_THRESHOLD%)"
    fi

    # Memory Usage
    if (( $(echo "$mem > $MEM_THRESHOLD" | bc -l) )); then
        echo -e "[CRITICAL] Memory Usage:  ${RED}$mem%${NC} (THRESHOLD: $MEM_THRESHOLD%)"
    elif (( $(echo "$mem > 70" | bc -l) )); then
        echo -e "[WARNING] Memory Usage:  ${YELLOW}$mem%${NC} (THRESHOLD: $MEM_THRESHOLD%)"
    else
        echo -e "[OK] Memory Usage:  ${GREEN}$mem%${NC} (THRESHOLD: $MEM_THRESHOLD%)"
    fi

    # Disk Usage
    if (( disk > DISK_THRESHOLD )); then
        echo -e "[CRITICAL] Disk Usage:    ${RED}$disk%${NC} (THRESHOLD: $DISK_THRESHOLD%)"
    elif (( disk > 75 )); then
        echo -e "[WARNING] Disk Usage:    ${YELLOW}$disk%${NC} (THRESHOLD: $DISK_THRESHOLD%)"
    else
        echo -e "[OK] Disk Usage:    ${GREEN}$disk%${NC} (THRESHOLD: $DISK_THRESHOLD%)"
    fi

    # Load Average
    echo -e "Load Average: $load"

    # Services Status
    if [ ${#down_services[@]} -gt 0 ]; then
        echo -e "[DOWN] Critical Services: ${RED}${down_services[*]}${NC}"
    else
        echo -e "[OK] Critical Services: ${GREEN}ALL RUNNING${NC}"
    fi

    echo
    echo "Last updated: $(date)"
    echo "Press Ctrl+C to exit monitoring"
}

# Function to check for alerts
check_alerts() {
    local cpu=$1
    local mem=$2
    local disk=$3
    local down_services=$4

    alerts=()

    if (( $(echo "$cpu > $CPU_THRESHOLD" | bc -l) )); then
        alerts+=("CRITICAL: CPU usage at ${cpu}% (threshold: $CPU_THRESHOLD%)")
    fi

    if (( $(echo "$mem > $MEM_THRESHOLD" | bc -l) )); then
        alerts+=("CRITICAL: Memory usage at ${mem}% (threshold: $MEM_THRESHOLD%)")
    fi

    if (( disk > DISK_THRESHOLD )); then
        alerts+=("CRITICAL: Disk usage at ${disk}% (threshold: $DISK_THRESHOLD%)")
    fi

    if [ ${#down_services[@]} -gt 0 ]; then
        alerts+=("CRITICAL: Services down: ${down_services[*]}")
    fi

    # Print alerts
    if [ ${#alerts[@]} -gt 0 ]; then
        echo "ALERTS DETECTED:"
        for alert in "${alerts[@]}"; do
            echo "   $alert"
        done
        echo
    fi
}

# Main monitoring loop
echo "Starting system monitoring... (Press Ctrl+C to stop)"
echo

while true; do
    # Collect metrics
    cpu=$(get_cpu_usage)
    mem=$(get_memory_usage)
    disk=$(get_disk_usage)
    load=$(get_load_average)
    down_services=($(check_services))

    # Check for alerts
    check_alerts "$cpu" "$mem" "$disk" "${down_services[@]}"

    # Display dashboard
    display_dashboard "$cpu" "$mem" "$disk" "$load" "${down_services[@]}"

    # Wait before next update
    sleep $MONITOR_INTERVAL
done
