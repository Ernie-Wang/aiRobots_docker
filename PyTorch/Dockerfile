# Use ROS melodic as base iamge
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

#Install cudnn
RUN apt-get update && apt-get install -y --no-install-recommends \
    ${NV_CUDNN_PACKAGE} \
    ${NV_CUDNN_PACKAGE_DEV} \
    && apt-mark hold ${NV_CUDNN_PACKAGE_NAME} && \
    rm -rf /var/lib/apt/lists/*

# Install SDL2 for Joy
RUN apt-get -y update && apt-get -y install --no-install-recommends \
    apt-utils 2>&1 \
    libsdl2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install pip
RUN apt-get -y update && apt-get -y install --no-install-recommends \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install PyTorch 1.9.1
RUN python3 -m pip install torch==1.9.1+cu111 \
    torchvision==0.10.1+cu111 \
    torchaudio==0.9.1 -f https://download.pytorch.org/whl/torch_stable.html

# enable read write
RUN usermod -a -G dialout ${USERNAME}

# ROS entry point
COPY ./ros_entrypoint.sh /
RUN chmod +x /ros_entrypoint.sh
ENTRYPOINT ["/usr/bin/tini", "--", "/ros_entrypoint.sh"]

CMD [ "sleep", "infinity" ]

WORKDIR /home/${USERNAME}