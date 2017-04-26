ln -si $HOME/dotfiles/.bashrc $HOME/
ln -si $HOME/dotfiles/.vimrc $HOME/
ln -si $HOME/dotfiles/.tmux.conf $HOME/

if [ ! -d "$HOME/.config/nvim" ];then
  mkdir -p $HOME/.config/nvim
fi

ln -si $HOME/dotfiles/.vimrc $HOME/.config/nvim/init.vim
