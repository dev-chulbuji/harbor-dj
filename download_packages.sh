#!/bin/bash

set -e

VENDOR_DIR="./vendor"

DOCKER_COMPOSE_VERSION="1.25.5"
NODE_EXPORTER_VERSION="0.18.1"
CADVISOR_VERSION="0.35.0"

if [ -d $VENDOR_DIR ] 
then
	rm -rf $VENDOR_DIR
fi

mkdir -p $VENDOR_DIR

curl -kL https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-Linux-x86_64 -o $VENDOR_DIR/docker-compose-$DOCKER_COMPOSE_VERSION
curl -kL https://github.com/prometheus/node_exporter/releases/download/v$NODE_EXPORTER_VESION/node_exporter-$NODE_EXPORTER_VERSION.linux-amd64.tar.gz -o $VENDOR_DIR/node_exporter-$NODE_EXPORTER_VERSION.linux-amd64.tar.gz
curl -kL https://github.com/google/cadvisor/releases/download/v$CADVISOR_VERSION.cadvisor -o $VENDOR_DIR/cadvisor-$CADVISOR_VERSION

curl -kL https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm -o $VENDOR_DIR/containerd.io-1.2.6-3.3.el7.x86_64.rpm
curl -kL https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-19.03.9-3.el7.x86_64.rpm -o $VENDOR_DIR/docker-ce-19.03.9-3.el7.x86_64.rpm
curl -kL https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-cli-19.03.9-3.el7.x86_64.rpm -o $VENDOR_DIR/docker-ce-cli-19.03.9-3.el7.x86_64.rpm
curl -L https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-selinux-17.03.3.ce-1.el7.noarch.rpm -o $VENDOR_DIR/container-selinux-17.03.0.ce-1.el7.noarch.rpm

touch $VENDOR_DIR/done

