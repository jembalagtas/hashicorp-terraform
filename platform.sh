#!/bin/bash
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf list docker-ce
dnf install docker-ce --nobest -y
systemctl start docker
systemctl enable docker
chkconfig docker on
docker run --name nginx --restart always -p 8080:80 -d nginx
#echo `terraform output public_dns` | awk -F '"' '{print $2}' > aws-platform-pubDNS
#echo `terraform output public_ip` > gcp-platform-pubIP