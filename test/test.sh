#!/bin/bash
set -e

run_on()
{
    vagrant ssh "$1" -c "$2"
}

echo "1. Client-A ping router (192.168.100.1)"
run_on client-a "ping -c 2 192.168.100.1"

echo "2. Client-B ping router (192.168.200.1)"
run_on client-b "ping -c 2 192.168.200.1"

echo "3. Client-A ping Client-B via router"
run_on client-a "ping -c 2 192.168.200.10"

echo "4. Client-B ping Client-A"
run_on client-b "ping -c 2 192.168.100.10"

echo "5. Client-A has internet access (ping 8.8.8.8)"
run_on client-a "ping -c 2 8.8.8.8"

echo "6. Client-B has internet access"
run_on client-b "ping -c 2 8.8.8.8"

echo "All tests passed successfully"
