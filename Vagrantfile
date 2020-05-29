# -*- mode: ruby -*-
# vi: set ft=ruby :

class String
  def green
    "\e[32m#{self}\e[0m"
  end

  def brown
    "\e[33m#{self}\e[0m"
  end
end

cmd = ARGV[0]

VAGRANTFILE_API_VERSION = "2"
VAGRANT_BOX_CENTOS_DOCKER = "centos/7"

N1_HOST_NAME = "n1"

N1_IP = "172.20.20.10"

unless Dir.exist?("./vendor") and File.exist?("./vendor/done")
  puts "You need to execute ./download_packages.sh before vagrant up. Execute the following line.".brown
  puts "./download_packages.sh".brown
  exit 1
end

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

      n1.vm.provision "file", source: "./src/packages", destination: "/tmp/harbor"
      n1.vm.provision "file", source: "./vendor", destination: "/tmp/vendor"
      n1.vm.provision "shell", path: "./src/bootstrap.sh"

      n1.vm.network "forwarded_port", guest: 80, host:8080
  end
end
