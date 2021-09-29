# Use PyTorch as base iamge
FROM airobots_docker:PyTorch



# enable read write
RUN usermod -a -G dialout ${USERNAME}

# # Copy .bashrc
# COPY ./.bashrc /
# # Copy .vimrc
# COPY ./.vimrc /
# RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# RUN vim +PluginInstall +qall

# entry point
COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/usr/bin/tini", "--", "/entrypoint.sh"]

CMD [ "sleep", "infinity" ]

WORKDIR /home/${USERNAME}