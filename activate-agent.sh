#!/bin/bash

if [ `ps aux | grep ssh-agent | grep -v grep | wc -l` -lt 1 ]; then
    eval $(ssh-agent)
fi

if [ `ssh-add -l | grep '<pub_key_fingerprint>' | wc -l` -lt 1 ]; then
    ssh-add -k <priv_key_path>
fi
