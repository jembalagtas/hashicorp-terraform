#!/bin/bash
yum update -y && yum install -y wget git
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -ivh epel-release-latest-7.noarch.rpm
printf '[dockerrepo] \nname=Docker Repository \nbaseurl=https://yum.dockerproject.org/repo/main/centos/7 \nenabled=1 \ngpgcheck=1 \ngpgkey=https://yum.dockerproject.org/gpg' > /etc/yum.repos.d/docker.repo
until [[ $(rpm -qa docker-engine | wc -l) -gt 0 ]]; do yum -y install docker-engine; echo \"Waiting until docker is installed..\"; sleep 5; done
service docker start
chkconfig docker on
curl -L https://github.com/docker/compose/releases/download/1.24.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose && ln -sv /usr/local/bin/docker-compose /usr/bin/docker-compose
docker run --name nginx -p 8080:80 -d nginx
#echo `terraform output public_dns` | awk -F '"' '{print $2}' > aws-platform-pubDNS
#echo `terraform output public_ip` > gcp-platform-pubIP