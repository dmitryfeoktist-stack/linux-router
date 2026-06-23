# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = ENV['CI'] ? "centos/7" : "rockylinux/9"
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.boot_timeout = 600
  config.vm.provider "virtualbox" do |vb|
    vb.memory=512
    vb.cpus=1
    vb.gui=false
    #vb.customize ["modifyvm", :id, "--firmware", "efi"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
    vb.customize ["modifyvm", :id, "--pae", "on"]
    vb.customize ["modifyvm", :id, "--hwvirtex", "on"]
    vb.customize ["modifyvm", :id, "--nestedpaging", "on"]
    vb.customize ["modifyvm", :id, "--largepages", "on"]
    vb.customize ["modifyvm", :id, "--vtxvpid", "on"]
    vb.customize ["modifyvm", :id, "--audio", "none"]
    vb.customize ["modifyvm", :id, "--usb", "off"]
    vb.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
    vb.customize ["modifyvm", :id, "--vram", "16"]
  end
  config.vm.define "router" do |router|
    router.vm.hostname = "router"
    router.vm.provider "virtualbox" do |vb|
      vb.memory = 512
      vb.cpus = 1
      vb.gui = false
    end
    router.vm.network "private_network", ip: "192.168.100.1", virtualbox__intnet: "intnet-a"
    router.vm.network "private_network", ip: "192.168.200.1", virtualbox__intnet: "intnet-b"
    #router.vm.provision "shell", path: "provision/router.sh", args: "eth0"
  end

  config.vm.define "client-a" do |client|
    client.vm.hostname = "client-a"
    client.vm.provider "virtualbox" do |vb|
      vb.memory = 256
      vb.cpus = 1
      vb.gui = false
    end
    client.vm.network "private_network", ip: "192.168.100.10", virtualbox__intnet: "intnet-a"
    #client.vm.provision "shell", path: "provision/client.sh", args: "eth1 192.168.100.10 192.168.100.1"
  end

  config.vm.define "client-b" do |client|
    client.vm.hostname = "client-b"
    client.vm.provider "virtualbox" do |vb|
      vb.memory = 256
      vb.cpus = 1
      vb.gui = false
    end
    client.vm.network "private_network", ip: "192.168.200.10", virtualbox__intnet: "intnet-b"
    #client.vm.provision "shell", path: "provision/client.sh", args: "eth1 192.168.200.10 192.168.200.1"
  end
end
