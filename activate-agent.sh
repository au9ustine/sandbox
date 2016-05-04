#!/bin/bash

if [ `ps aux | grep ssh-agent | grep -v grep | wc -l` -lt 1 ]; then
    eval $(ssh-agent)
    ssh-add -k ~/.ssh/id_rsa
fi
