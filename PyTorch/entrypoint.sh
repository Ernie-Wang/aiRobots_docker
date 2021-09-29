#!/bin/bash
set -e
if [ ! -f "~/.bashrc" ] 
then
    cp /etc/skel/.bashrc ~/
fi
exec "$@"