#!/bin/bash

if [ -z "${2}" ]; then
  default_value="no"
  message="${1} (y/N) "
else
  default_value="yes"
  message="${1} (Y/n) "
fi

while : ; do
  echo -n "${message}"
  read answer
  if [ -z "${answer}" ]; then
    answer="${default_value}"
  fi
  if expr "${answer}":"^\s*[yY]([eE][sS])?\s*$" > /dev/null; then
    exit 0
  elif expr "${answer}":"^\s*[nN][oO]?\s*$" > /dev/null ; then
    exit 1
  fi
done
