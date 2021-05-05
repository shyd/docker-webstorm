FROM registry.jetbrains.team/p/prj/containers/projector-webstorm

USER root

RUN apt-get update && \
    apt-get -y install vim zsh wget curl git tree rsync openssh-client zip default-mysql-client dnsutils \
        nodejs npm yarn \
        imagemagick graphicsmagick \
        libssl-dev libreadline-dev zlib1g-dev \
        autoconf bison build-essential libyaml-dev \
        libreadline-dev libncurses5-dev libffi-dev libgdbm-dev \
        sudo

RUN rm -rf /var/lib/apt/lists/*

RUN usermod -aG sudo $PROJECTOR_USER_NAME
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN wget -qO /root/.zshrc https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc
RUN chsh -s $(which zsh) $PROJECTOR_USER_NAME

RUN npm install -g gulp-cli bower gh-pages
# remove orphants
RUN rm -rf $HOME/.npm
RUN rm $HOME/.wget-hsts

USER $PROJECTOR_USER_NAME

RUN wget -qO ~/.zshrc https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc
RUN wget -qO ~/.zshrc.local https://raw.githubusercontent.com/shyd/docker-zsh/master/zshrc.local

SHELL ["/bin/bash", "-c"]
RUN curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash

RUN export PATH="$HOME/.rbenv/bin:$PATH"
RUN eval "$($HOME/.rbenv/bin/rbenv init -)"

RUN $HOME/.rbenv/bin/rbenv install 2.6.0
RUN $HOME/.rbenv/bin/rbenv global 2.6.0

RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
#RUN source ~/.bashrc

RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
RUN echo 'eval "$(rbenv init -)"' >> ~/.zshrc
#RUN source ~/.zshrc

#CMD ["zsh", "-c", "/run.sh"]
