# Use ROS melodic as base iamge
FROM airobots_docker:ros_noetic

# Install realsense2
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE \
    && add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u \
    && apt-get -y update && apt-get -y install --no-install-recommends \
    udev \
    librealsense2-dkms \
    librealsense2-utils \
    librealsense2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install realsense-ros
RUN apt-get -y update && apt-get -y install --no-install-recommends \
    ros-${ROS_DISTRO}-realsense2-camera \
    && rm -rf /var/lib/apt/lists/*
ADD https://raw.githubusercontent.com/IntelRealSense/librealsense/master/config/99-realsense-libusb.rules /etc/udev/rules.d

# Install SDL2 for Joy
RUN apt-get -y update && apt-get -y install --no-install-recommends \
    apt-utils 2>&1 \
    libsdl2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install pip
RUN apt-get -y update && apt-get -y install --no-install-recommends \
    python3-pip \
    tmux \
    && rm -rf /var/lib/apt/lists/*

# Install tensorflow 2.4.0
RUN python3 -m pip install --upgrade pip --no-cache-dir \ 
    jupyter \
    tensorflow==2.4.1

# enable read write
RUN usermod -a -G dialout ${USERNAME}


# Setup vim and bash
USER ${USERNAME}
COPY ./.bashrc /home/${USERNAME}
COPY ./.vimrc /home/${USERNAME}
COPY ./.tmux.conf /home/${USERNAME}/
RUN \
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && \
  vim -E -s -u ~/.vimrc  +PluginInstall +qall

USER root
EXPOSE 8888

# ROS entry point
COPY ./ros_entrypoint.sh /
RUN chmod +x /ros_entrypoint.sh
ENTRYPOINT ["/usr/bin/tini", "--", "/ros_entrypoint.sh"]

CMD ["roscore"]

WORKDIR /home/${USERNAME}