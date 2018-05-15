#!/bin/bash
if [ ! -d "$HOME/.tmux/plugins" ];then
  mkdir -p $HOME/.tmux/plugins
fi

git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
