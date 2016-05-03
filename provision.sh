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

su - vagrant

# git
git config --global user.name au9ustine
git config --global user.email duke.augustine@gmail.com
git config --global core.editor "emacs -nw"

# emacs
if [ -d ~/projects/dotfiles ]; then
    cd ~/projects/dotfiles
    git pull origin master
    cd ~
else
    git clone https://au9ustine@github.com/org_au9ustine/dotfiles /home/vagrant/projects/dotfiles
fi
rsync -acvzP ~/projects/dotfiles/dotemacs ~/.emacs

# docker
DOCKER_VERSION=1.8.3-0~trusty
curl -sSL https://get.docker.com/gpg | sudo apt-key add -
curl -sSL https://get.docker.com/ | sed "s/apt-get install -y -q docker-engine/apt-get install -y -q --force-yes docker-engine=$DOCKER_VERSION/" | sh
sudo usermod -aG docker vagrant

# docker-compose
sudo pip install docker-compose==1.4.1
