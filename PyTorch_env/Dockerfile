# Use PyTorch as base iamge
FROM airobots_docker:costum_U20_base

#Install cudnn
RUN apt-get update && apt-get install -y --no-install-recommends \
    ${NV_CUDNN_PACKAGE} \
    ${NV_CUDNN_PACKAGE_DEV} \
    && apt-mark hold ${NV_CUDNN_PACKAGE_NAME} && \
    rm -rf /var/lib/apt/lists/*

# Install PyTorch 1.9.1
RUN python3 -m pip install torch==1.9.1+cu111 \
    torchvision==0.10.1+cu111 \
    torchaudio==0.9.1 -f https://download.pytorch.org/whl/torch_stable.html

# enable read write
RUN usermod -a -G dialout ${USERNAME}

# entry point
COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/usr/bin/tini", "--", "/entrypoint.sh"]

CMD [ "sleep", "infinity" ]

WORKDIR /home/${USERNAME}