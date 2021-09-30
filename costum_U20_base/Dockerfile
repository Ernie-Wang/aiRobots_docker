# Use nvidia/cudagl with Ubuntu 20.04 as base iamge
FROM nvidia/cudagl:11.1.1-devel-ubuntu20.04

ENV NV_CUDNN_VERSION 8.0.5.39

ENV NV_CUDNN_PACKAGE "libcudnn8=$NV_CUDNN_VERSION-1+cuda11.1"
ENV NV_CUDNN_PACKAGE_DEV "libcudnn8-dev=$NV_CUDNN_VERSION-1+cuda11.1"
ENV NV_CUDNN_PACKAGE_NAME "libcudnn8"

ARG USERNAME=aiRobots
ARG PASSWORD=aiRobots
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# setup environment
ENV USERNAME=${USERNAME}
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Update and install necessities
RUN apt-get -y update && apt-get -y install --no-install-recommends \
    apt-utils 2>&1 \
    software-properties-common \ 
    sudo \
    vim \
    g++ \
    gcc \
    gdb \
    make \
    cmake \
    git \
    build-essential \
    dirmngr \
    gpg-agent \
    dbus \
    && dbus-uuidgen >> /etc/machine-id \
    && rm -rf /var/lib/apt/lists/*

# Add user to group
RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd -s /bin/bash -u ${USER_UID} -g ${USER_GID} -m -k /etc/skel ${USERNAME} \
    # && echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL >> /etc/sudoers.d/${USERNAME} \
    && echo ${USERNAME} ALL=ALL >> /etc/sudoers.d/${USERNAME} \
    && echo "${USERNAME}:${PASSWORD}" | chpasswd \
    && chmod 0440 /etc/sudoers.d/${USERNAME}

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F42ED6FBAB17C654

# Install SDL2 for Joy
RUN apt-get -y update && apt-get -y install --no-install-recommends \
    apt-utils 2>&1 \
    libsdl2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install pip
RUN apt-get -y update && apt-get -y install --no-install-recommends \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

#Install tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

# enable read write
RUN usermod -a -G dialout ${USERNAME}

# Setup vim and bash
WORKDIR /
COPY ./.bashrc /
COPY ./.vimrc /
RUN \
  git clone https://github.com/VundleVim/Vundle.vim.git /.vim/bundle/Vundle.vim && \
  ln -sf /.vim /root/ && \
  vim -E -s -u /.vimrc  +PluginInstall +qall

# ROS entry point
# COPY ./entrypoint.sh /
# RUN chmod +x /entrypoint.sh
# ENTRYPOINT ["/usr/bin/tini", "--", "/entrypoint.sh"]
# CMD [ "sleep", "infinity" ]

WORKDIR /home/${USERNAME}