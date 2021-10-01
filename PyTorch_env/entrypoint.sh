#!/bin/bash
set -e
if [ ! -f "/home/aiRobots/.bashrc" ] 
then
    cp /etc/skel/.bashrc ~/
fi
exec "$@"