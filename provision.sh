#!/usr/bin/env bash

cp /etc/apt/sources.list /etc/apt/sources.list.origin

echo "deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted
deb-src http://mirrors.aliyun.com/ubuntu/ trusty main restricted
deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted
deb http://mirrors.aliyun.com/ubuntu/ trusty universe
deb-src http://mirrors.aliyun.com/ubuntu/ trusty universe
deb http://mirrors.aliyun.com/ubuntu/ trusty-updates universe
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates universe
deb http://mirrors.aliyun.com/ubuntu/ trusty multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-updates multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted
deb http://mirrors.aliyun.com/ubuntu/ trusty-security universe
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security universe
deb http://mirrors.aliyun.com/ubuntu/ trusty-security multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security multiverse" > /etc/apt/sources.list

apt-get update

# install prerequisites
apt-get install -y python-pip python-dev libyaml-dev libssl-dev gnupg
apt-get install -y git
sudo apt-get install -y emacs24-nox

# emacs
if [ -d /home/vagrant/projects/dotfiles ]; then
    cd /home/vagrant/projects/dotfiles
    git pull origin master
    cd 
else
    git clone https://au9ustine@github.com/org_au9ustine/dotfiles /home/vagrant/projects/dotfiles
fi
rsync -acvzP /home/vagrant/projects/dotfiles/dotgitconfig /home/vagrant/.gitconfig
chown vagrant:vagrant /home/vagrant/.gitconfig
rsync -acvzP /home/vagrant/projects/dotfiles/dotemacs /home/vagrant/.emacs
chown vagrant:vagrant /home/vagrant/.emacs
rsync -acvzP /home/vagrant/projects/dotfiles/Makefile.dist /home/vagrant/Makefile
chown vagrant:vagrant /home/vagrant/Makefile


# docker
DOCKER_VERSION=1.8.3-0~trusty
curl -sSL https://get.docker.com/gpg | sudo apt-key add -
curl -sSL https://get.docker.com/ | sed "s/apt-get install -y -q docker-engine/apt-get install -y -q --force-yes docker-engine=$DOCKER_VERSION/" | sh
sudo usermod -aG docker vagrant

# docker-compose
sudo pip install docker-compose==1.4.1
