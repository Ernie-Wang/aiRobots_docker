#!/bin/bash
set -e
if [ ! -f "~/.vimrc" ] 
then
    # cp /etc/skel/.bashrc ~/
    cp -f /.bashrc ~/
    cp -f /.vimrc ~/
    cp -rf /.vim/ ~/
    echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc
fi
# setup ros environment
source /opt/ros/${ROS_DISTRO}/setup.bash
exec "$@"