#!/bin/bash -xeu

if [ "$USER" != "root" ]; then
  echo "Please run as root!"
  exit 1
fi

apt install libtool libtool-bin autoconf cmake g++ pkg-config unzip -y

cd /usr/src

if [ ! -d neovim ]; then
  git clone https://github.com/neovim/neovim.git
fi

cd neovim

# checkout latest tag
git fetch
git reset --hard HEAD
git checkout $(git tag | sort -V | tail -n 1)

sudo make 
