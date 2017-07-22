
# $HOMEにクローンされているか確認
# もっと頭のいい方法がありそう

if [ ! -d "$HOME/dotfiles" ]; then
  echo "Please clone $HOME"
  exit 1
fi

cd $HOME/dotfiles/setup

sh ./install.sh

sh ./neovim_build.sh

sh ./nvm_install.sh

sh ./latest_node_install.sh

sh ./tmux_build.sh

sh ./simbliclink.sh

sh ./personal.sh
