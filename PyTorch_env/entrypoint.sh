#!/bin/bash
set -e
if [ !-f "/home/aiRobots/.bashrc" ] 
then
    echo "/home/phpini/testfile is a file"
    cp /etc/skel/.bashrc ~/
fi
vim +PluginInstall +qall
exec "$@"