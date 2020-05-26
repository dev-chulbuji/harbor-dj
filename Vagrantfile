# -*- mode: ruby -*-
# vi: set ft=ruby :
#
VAGRANTFILE_API_VERSION = "2"
VAGRANT_BOX_CENTOS_DOCKER = "centos/7"

N1_HOST_NAME = "n1"

N1_IP = "172.20.20.10"

Vagrant.configure(VAGRANTFILE_API_VERSION)do |config|
  config.vm.box = VAGRANT_BOX_CENTOS_DOCKER
  config.vm.box_download_insecure = true
  config.vm.box_check_update = false

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.cpus = 2
    vb.memory = "2048"
  end

  config.vm.define "n1" do |n1|
      n1.vm.hostname = N1_HOST_NAME
      n1.vm.network "private_network", ip: N1_IP

      n1.vm.provision "file", source: "./src/packages", destination: "./tmp/src/packages"
#      n1.vm.provision "shell", "./src/bootstrap.sh"

      n1.vm.network "forwarded_port", guest: 80, host:8080
  end
end
