# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "rockylinux/9"
  config.vm.synced_folder ".", "/vagrant", disabled: true   # не синхронизируем папку
  config.vm.define "router" do |router|
    router.vm.hostname = "router"
    router.vm.provider "virtualbox" do |vb|
      vb.memory = 512
      vb.cpus = 1
    end
    router.vm.network "public_network", use_dhcp_assigned_default_route: true
    router.vm.network "private_network", ip: "192.168.100.1", virtualbox__intnet: "intnet-a"
    router.vm.network "private_network", ip: "192.168.200.1", virtualbox__intnet: "intnet-b"
    router.vm.provision "shell", path: "provision/router.sh"
  end

  config.vm.define "client-a" do |client|
    client.vm.hostname = "client-a"
    client.vm.provider "virtualbox" do |vb|
      vb.memory = 256
      vb.cpus = 1
    end
    client.vm.network "private_network", ip: "192.168.100.10", virtualbox__intnet: "intnet-a"
    client.vm.provision "shell", path: "provision/client.sh", args: "eth1 192.168.100.10 192.168.100.1"
  end

  config.vm.define "client-b" do |client|
    client.vm.hostname = "client-b"
    client.vm.provider "virtualbox" do |vb|
      vb.memory = 256
      vb.cpus = 1
    end
    client.vm.network "private_network", ip: "192.168.200.10", virtualbox__intnet: "intnet-b"
    client.vm.provision "shell", path: "provision/client.sh", args: "eth1 192.168.200.10 192.168.200.1"
  end
end
