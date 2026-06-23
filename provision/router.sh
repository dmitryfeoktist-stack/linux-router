#!/bin/bash
set -ex
exec > /tmp/router-provision.log 2>&1

if [ -f /etc/centos-release ] && grep -q "CentOS Linux release 7" /etc/centos-release; then
    echo "CentOS 7 detected, fixing repos to vault.centos.org..."
    rm -f /etc/yum.repos.d/CentOS-*.repo

    cat > /etc/yum.repos.d/CentOS-Base.repo <<EOF
[base]
name=CentOS-7 - Base
baseurl=http://vault.centos.org/7.9.2009/os/x86_64/
gpgcheck=1
gpgkey=http://vault.centos.org/7.9.2009/os/x86_64/RPM-GPG-KEY-CentOS-7
enabled=1

[updates]
name=CentOS-7 - Updates
baseurl=http://vault.centos.org/7.9.2009/updates/x86_64/
gpgcheck=1
gpgkey=http://vault.centos.org/7.9.2009/os/x86_64/RPM-GPG-KEY-CentOS-7
enabled=1

[extras]
name=CentOS-7 - Extras
baseurl=http://vault.centos.org/7.9.2009/extras/x86_64/
gpgcheck=1
gpgkey=http://vault.centos.org/7.9.2009/os/x86_64/RPM-GPG-KEY-CentOS-7
enabled=1
EOF

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
