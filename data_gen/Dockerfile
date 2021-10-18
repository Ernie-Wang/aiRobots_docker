# Use PyTorch as base iamge
FROM node:16.11

ARG USERNAME=aiRobots
ARG PASSWORD=aiRobots
# 1000 is being used in node
ARG USER_UID=1002
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
    xserver-xorg-dev \
    libxi-dev \
    libxext-dev \
    && dbus-uuidgen >> /etc/machine-id \
    && rm -rf /var/lib/apt/lists/*

# Add user to group
RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd -s /bin/bash -u ${USER_UID} -g ${USER_GID} -m -k /etc/skel ${USERNAME} \
    # && echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL >> /etc/sudoers.d/${USERNAME} \
    && echo ${USERNAME} ALL=ALL >> /etc/sudoers.d/${USERNAME} \
    && echo "${USERNAME}:${PASSWORD}" | chpasswd \
    && chmod 0440 /etc/sudoers.d/${USERNAME}

# Install pip
RUN apt-get -y update && apt-get -y install --no-install-recommends \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install x11 server
RUN apt-get -y update && apt-get -y install --no-install-recommends \
    x-window-system \
    mesa-utils \
    xserver-xorg-dev \
    libxi-dev \
    libxext-dev  \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

#Install tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

# enable read write
RUN usermod -a -G dialout ${USERNAME}

WORKDIR /home/${USERNAME}/
# Install nodejs packages
RUN npm install -g --save-dev \
    typescript \
    @types/node \
    nodemon \
    ts-node \
    three \
    && npm install \
    three \
    gl\
    mocha \
    multer \
    express \
    vblob

# Setup vim and bash
USER ${USERNAME}

COPY ./.bashrc /home/${USERNAME}/
COPY ./.vimrc /home/${USERNAME}/
COPY ./.tmux.conf /home/${USERNAME}/
RUN \
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && \
  vim -E -s -u ~/.vimrc  +PluginInstall +qall

USER root

# replace this with your application's default port
EXPOSE 8888
EXPOSE 5501

# entry point
COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/usr/bin/tini", "--", "/entrypoint.sh"]
# ENTRYPOINT ["/usr/bin/tini", "--", "xvfb-run", "-s", "-ac -screen 0 1280x1024x24"]

CMD [ "sleep", "infinity" ]

WORKDIR /home/${USERNAME}