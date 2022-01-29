# Use ROS melodic as base iamge
FROM airobots_docker:ros_galactic

ENV NV_CUDNN_VERSION 8.0.5.39

ENV NV_CUDNN_PACKAGE "libcudnn8=$NV_CUDNN_VERSION-1+cuda11.1"
ENV NV_CUDNN_PACKAGE_DEV "libcudnn8-dev=$NV_CUDNN_VERSION-1+cuda11.1"
ENV NV_CUDNN_PACKAGE_NAME "libcudnn8"

# Install SDL2 for Joy
RUN apt-get -y update && apt-get -y install --no-install-recommends \
    apt-utils 2>&1 \
    libsdl2-dev \
    tmux \
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
USER ${USERNAME}
COPY ./.bashrc /home/${USERNAME}/
COPY ./.vimrc /home/${USERNAME}/
COPY ./.tmux.conf /home/${USERNAME}/
RUN \
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && \
  vim -E -s -u ~/.vimrc  +PluginInstall +qall

USER root
# ROS entry point
COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/usr/bin/tini", "--", "/entrypoint.sh"]
CMD [ "sleep", "infinity" ]

WORKDIR /home/${USERNAME}