#!/bin/bash
set -ex

dnf install iptables-services -y

echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p

iptables -t nat -A POSTROUTING -o $1 -j MASQUERADE
iptables-save > /etc/sysconfig/iptables
systemctl enable iptables
systemctl start iptables

echo "Router configured: IP forwarding ON, masquerading enabled via iptables"
