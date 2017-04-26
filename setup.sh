
# $HOMEにクローンされているか確認
# もっと頭のいい方法がありそう

if [ ! -d "$HOME/dotfile" ]; then
  echo "Please clone $HOME"
  exit 1
fi

cd $HOME/dotfiles

sh ./install.sh

sh ./nvm_install.sh

sh ./tmux_build.sh

sh ./simbliclink.sh

sh ./personal.sh
