#!/bin/bash
set -e
if [ ! -f "/home/aiRobots/.bashrc" ] 
then
    cp /etc/skel/.bashrc ~/
    echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc
fi
# setup ros environment
source /opt/ros/${ROS_DISTRO}/setup.bash
exec "$@"