#!/bin/bash -xeu

if [ "$USER" != "root" ]; then
  echo "Please run as root!"
  exit 1
fi

apt install libtool 
apt install libtool-bin -y
apt install autoconf -y 
apt install cmake -y
apt install g++ -y 
apt install pkg-config -y
apt install unzip -y
apt install python-dev python-pip python3-dev python3-pip -y
pip3 install neovim

cd /usr/src

if [ ! -d neovim ]; then
  git clone https://github.com/neovim/neovim.git
fi

cd neovim

# checkout latest tag
git fetch
git reset --hard HEAD
git checkout master
git reset --hard HEAD

rm -r build/
sudo make 
sudo make install
