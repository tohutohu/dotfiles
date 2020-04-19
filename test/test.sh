# /bin/bash -xe

# check docker command 
which docker >> /dev/null
if [ $? != 0 ]; then
  echo "docker not found"
fi

# ckeck docker image
if [ ! $(docker image ls dotfiles-test -q) ]; then
  echo "start build docker image"
  docker build -t dotfiles-test -f test/Dockerfile .
fi

# start docker image
docker run --rm -it dotfiles-test /bin/bash
