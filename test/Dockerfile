FROM ubuntu:latest

MAINTAINER to-hutohu

ENV USER to-hutohu
ENV HOME /home/to-hutohu
ENV SHELL /bin/bash

RUN useradd -m ${USER}
RUN gpasswd -a ${USER} sudo
RUN echo "${USER}:test" | chpasswd
RUN sed -i.bak "s#${HOME}:#${HOME}:${SHELL}#" /etc/passwd

WORKDIR ${HOME}
USER ${USER}

COPY / ./dotfiles/

