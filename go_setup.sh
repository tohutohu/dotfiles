#!/bin/bash

if [ "$USER" != "root" ]; then
  echo "Please run as root!"
#exit 1
fi


go get -u github.com/nsf/gocode
go get -u github.com/golang/lint/golint
