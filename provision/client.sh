#!/bin/bash

IFACE=$1
IP=$2
GATEWAY=$3

nmcli con add con-name static-lab ifname $IFACE type ethernet \
    ipv4.addresses $IP/24 \
    ipv4.gateway $GATEWAY \
    ipv4.dns 8.8.8.8 \
    ipv4.method manual

nmcli con up static-lab

nmcli con mod "Wired connection 1" ipv4.method disabled || true
nmcli con down "Wired connection 1" 2>/dev/null || true

ip route del default via 10.0.2.2 dev eth0 2>/dev/null || true

echo "Client configured: IP=$IP, Gateway=$GATEWAY"
