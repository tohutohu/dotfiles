#!/bin/bash

if [ "$USER" != "root" ]; then
  echo "Please run as root!"
  exit 1
fi

# 各種必要なソフトのインストール
apt update
apt upgrade -y
apt install python python3 tmux git sl automake -y
apt install software-properties-common python3-dev python3-pip -y
add-apt-repository ppa:neovim-ppa/unstable -y
apt update -y
apt install neovim -y
yes | pip3 install neovim 

sh nvm_install.sh
