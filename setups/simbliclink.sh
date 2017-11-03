ln -si $HOME/dotfiles/config/.bashrc $HOME/
ln -si $HOME/dotfiles/config/.vimrc $HOME/
ln -si $HOME/dotfiles/config/.tmux.conf $HOME/

if [ ! -d "$HOME/.config/nvim" ];then
  mkdir -p $HOME/.config/nvim
fi

ln -si $HOME/dotfiles/config/.vimrc $HOME/.config/nvim/init.vim
ln -si $HOME/dotfiles/config/dein.toml $HOME/.config/nvim/dein.toml
ln -si $HOME/dotfiles/config/dein_lazy.toml $HOME/.config/nvim/dein_lazy.toml

if [ ! -d "$HOME/.config/ranger" ];then
  mkdir -p $HOME/.config/ranger
fi
ln -si $HOME/dotfiles/config/rc.conf $HOME/.config/ranger/rc.conf
ln -si $HOME/dotfiles/config/rifle.conf $HOME/.config/ranger/rifle.conf
ln -si $HOME/dotfiles/config/scope.sh $HOME/.config/ranger/scope.sh
