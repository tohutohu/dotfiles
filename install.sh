#!/bin/bash

if [ "$USER" != "root" ]; then
  echo "Please run as root!"
  exit 1
fi

# 各種必要なソフトのインストール
apt update
apt upgrade -y
apt autoremove -y
apt install python python3 git sl automake wireless-tools -y
apt install software-properties-common python3-dev python3-pip -y
apt install libtool libtool-bin autoconf cmake g++ pkg-config unzip speedtest-cli -y

add-apt-repository ppa:neovim-ppa/unstable -y
add-apt-repository ppa:ubuntu-lxc/lxd-stable

apt update -y
apt install neovim golang -y
yes | pip3 install neovim 

sh nvm_install.sh
