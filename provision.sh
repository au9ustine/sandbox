#!/usr/bin/env bash

sudo apt-get update

# install prerequisites
sudo apt-get install -y python-pip python-dev gnupg

# git
sudo apt-get install -y git
git config --global user.name au9ustine
git config --global user.email duke.augustine@gmail.com

# emacs
sudo apt-get install -y emacs24-nox
git clone https://au9ustine@github.com/org_au9ustine/dotfiles /home/vagrant/projects/dotfiles
rsync -acvzuP /home/vagrant/projects/dotfiles/dotemacs ~/.emacs

# docker
DOCKER_VERSION=1.8.3-0~trusty
curl -sSL https://get.docker.com/gpg | sudo apt-key add -
curl -sSL https://get.docker.com/ | sed "s/apt-get install -y -q docker-engine/apt-get install -y -q --force-yes docker-engine=$DOCKER_VERSION/" | sh
sudo usermod -aG docker vagrant

# docker-compose
pip install docker-compose==1.4.1
