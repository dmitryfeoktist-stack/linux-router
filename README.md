# Linux Router

Automated deployment of three VMs on RockyLinux 9: router, client-a, client-b. The router provides NAT and routing between subnets 192.168.100.0/24 and 192.168.200.0/24.

## Requirements:
- VirtualBox
- Vagrant

## Launching:
```bash
git clone https://github.com/dmitryfeoktist-stack/linux-router
cd linux-router
vagrant up
```

## Troubleshooting:
If automatic download does not work, download the box manually using the link below and add it under the correct name:
```bash
vagrant box add --name rockylinux/9 path/to/file/Rocky-9-Vagrant-VBox.latest.x86_64.box --force
```
## Links:
[vagrant box](https://dl.rockylinux.org/pub/rocky/9/images/x86_64/Rocky-9-Vagrant-VBox.latest.x86_64.box)
