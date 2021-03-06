#!/bin/bash

if [ "$USER" != "root" ]; then
  echo "Please run as root!"
  exit 1
fi

# 各種必要なソフトのインストール
apt update
apt upgrade -y
apt autoremove -y
apt install python python3 python-dev git sl automake wireless-tools wget -y
apt install software-properties-common python3-dev python3-pip -y
apt install libtool libtool-bin autoconf cmake g++ pkg-config unzip speedtest-cli -y
apt install zlib1g-dev ranger -y
apt install w3m lynx highlight atool mediainfo xpdf caca-utils -y

add-apt-repository ppa:neovim-ppa/unstable -y
add-apt-repository ppa:ubuntu-lxc/lxd-stable

apt update -y
# apt install neovim golang -y
yes | pip3 install neovim thefuck neovim-remote

