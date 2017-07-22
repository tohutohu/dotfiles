#!/bin/bash -xeu

if [ "$USER" != "root" ]; then
  echo "Please run as root!"
  exit 1
fi

apt install libevent-dev automake ncurses-dev -y

cd /usr/src

if [ ! -d tmux ]; then
  git clone https://github.com/tmux/tmux.git
fi

cd tmux

# checkout latest tag
git fetch
git reset --hard HEAD
git checkout $(git tag | sort -V | tail -n 1)

sh autogen.sh

./configure

make -j4

sudo make install
