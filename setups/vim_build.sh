#!/bin/bash -xeu

if [ "$USER" != "root" ]; then
  echo "Please run as root!"
  exit 1
fi

apt build-dep vim

cd /usr/src

if [ ! -d vim ]; then
  git clone https://github.com/vim/vim.git
fi

cd vim

# checkout latest tag
git fetch
git reset --hard HEAD
git checkout master
git pull

./configure --with-features=huge --enable-gui=gtk2  --enable-perlinterp --enable-pythoninterp --enable-python3interp --enable-rubyinterp      --enable-luainterp --with-luajit --enable-fail-if-missing

make reconfig
make install
