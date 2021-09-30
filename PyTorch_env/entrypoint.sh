#!/bin/bash
set -e
if [ ! -f "/home/aiRobots/.vimrc" ] 
then
    # cp /etc/skel/.bashrc ~/
    cp -f /.bashrc ~/
    cp -f /.vimrc ~/
    cp -rf /.vim/ ~/
fi
exec "$@"