#!/bin/bash
set -e

dnf install iptables-services -y

echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p

iptables -t nat -A POSTROUTING -o $1 -j MASQUERADE
service iptables save
systemctl enable iptables
systemctl start iptables

echo "Router configured: IP forwarding ON, masquerading enabled via iptables"
