#!/bin/bash
set -ex

if [ -f /etc/centos-release ] && grep -q "CentOS Linux release 7" /etc/centos-release; then
    echo "CentOS 7 detected, switching to vault repos..."
    sed -i 's/mirror.centos.org/vault.centos.org/g' /etc/yum.repos.d/*.repo
    sed -i 's/^#.*baseurl=/baseurl=/g' /etc/yum.repos.d/*.repo
    sed -i 's/^mirrorlist=/#mirrorlist=/g' /etc/yum.repos.d/*.repo
    yum clean all
    yum makecache
fi


if command -v dnf &> /dev/null; then
    PKG_MGR="dnf"
elif command -v yum &> /dev/null; then
    PKG_MGR="yum"
else
    echo "ERROR: No package manager found"
    exit 1
fi

$PKG_MGR install iptables-services -y

echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p

iptables -t nat -A POSTROUTING -o $1 -j MASQUERADE
iptables-save > /etc/sysconfig/iptables
systemctl enable iptables
systemctl start iptables

echo "Router configured: IP forwarding ON, masquerading enabled via iptables"
