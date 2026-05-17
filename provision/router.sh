#!/bin/bash
set -e

echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p

systemctl start firewalld
systemctl enable firewalld
firewall-cmd --permanent --add-masquerade
firewall-cmd --reload

echo "Router configured: IP forwarding ON, masquerading enabled via firewalld"
