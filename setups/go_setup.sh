#!/bin/bash

if [ "$USER" != "root" ]; then
  echo "Please run as root!"
#exit 1
fi
sudo apt-get install curl git mercurial make binutils bison gcc build-essential
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer))
gvm install go1.4 -B
gvm use go1.4
export GOROOT_BOOTSTRAP=$GOROOT
gvm install latest

go get -u github.com/nsf/gocode
go get -u github.com/golang/lint/golint
