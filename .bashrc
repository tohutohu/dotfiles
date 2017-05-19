if [ "$SHLVL" == 1 ];then
  bash ~/dotfiles/confirm.sh "    tmux?" yes
  if [ $? == 0 ]; then
    tmux
  fi
fi

if [ ! -z "$TMUX" -a -z "$NVIM_TUI_ENABLE_TRUE_COLOR" ];then
  echo "   ________  __       __  __    __  __    __ "
  echo "  /        |/  \     /  |/  |  /  |/  |  /  |"
  echo "  \$\$\$\$\$\$\$\$/ \$\$  \   /\$\$ |\$\$ |  \$\$ |\$\$ |  \$\$ |"
  echo "     \$\$ |   \$\$\$  \ /\$\$\$ |\$\$ |  \$\$ |\$\$  \/\$\$/ "
  echo "     \$\$ |   \$\$\$\$  /\$\$\$\$ |\$\$ |  \$\$ | \$\$  \$\$<  "
  echo "     \$\$ |   \$\$ \$\$ \$\$/\$\$ |\$\$ |  \$\$ |  \$\$\$\$  \ "
  echo "     \$\$ |   \$\$ |\$\$\$/ \$\$ |\$\$ \__\$\$ | \$\$ /\$\$  |"
  echo "     \$\$ |   \$\$ | \$/  \$\$ |\$\$    \$\$/ \$\$ |  \$\$ |"
  echo "     \$\$/    \$\$/      \$\$/  \$\$\$\$\$\$/  \$\$/   \$\$/ "
fi

alias la="ls -a"
alias ll="ls -l"

alias vim="nvim"
alias im="nvim"
alias vi="nvim"
alias v="nvim -S ~/.vim/session"

alias pip="pip3"
alias python="python3"

alias showcase="ssh -p 22 showcase@showcase.trap.show"
alias raspi="ssh -i ~/.ssh/raspi_rsa pi@192.168.2.112 -p 29931"

tsubame(){
  echo "Input Student ID:"
  read id
  ssh -i ~/.ssh/id_rsa ${id}@login-t2.g.gsic.titech.ac.jp
}

declare -A shortDirs
shortDirs=(\
  ["desktop"]="/mnt/c/Users/ok/Desktop"\
  ["gacha"]="/mnt/c/Users/ok/Documents/SourceTree/Server"\
  ["work"]="/mnt/c/Users/ok/Documents/SourceTree"\
  ["cpp"]="/mnt/c/Users/ok/Documents/Kyopro"\
  ["euler"]="/mnt/c/Users/ok/Documents/SourceTree/euler"\
  ["kadai"]="/mnt/c/Users/ok/Documents/Kadai"\
  ["~"]="~"\
)
goto(){
  for key in ${!shortDirs[*]}; do
    if [ "$key" = "$1" ]; then
      cd ${shortDirs[$key]}
      return 0
    fi
  done
  cd ~
}
gotoParams=""
for key in ${!shortDirs[*]}; do
  gotoParams="$gotoParams $key"
done
complete -W "$gotoParams" goto

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# 仮の nvm コマンド
nvm() {
	# まず仮の nvm コマンドを unset
	unset -f nvm

	# nvm.sh をロード
	# ここで本物の nvm コマンドが定義される
	source "${NVM_DIR:-$HOME/.nvm}/nvm.sh"

	# 仮の nvm コマンドに渡された引数を本物に受け渡す
	nvm "$@"
}

sl(){
  node ~/dotfiles/poop/sl_sarashi.js&

  /usr/games/sl
}

# あらかじめ `nvm default vX.Y.Z` してエイリアス "default" を作っておく

PATH=${NVM_DIR:-$HOME/.nvm}/versions/node/v7.9.0/bin:$PATH
MANPATH=${NVM_DIR:-$HOME/.nvm}/versions/node/v7.9.0/share/man:$MANPATH
export NODE_PATH=${NVM_DIR:-$HOME/.nvm}/versions/node/v7.9.0/lib/node_modules

PS1="\n\[\033[1;32m\]\$(date +%Y/%m/%d_%H:%M:%S)\[\033[0m\] \[\033[33m\]\H:\w\n\[\033[0m\][\u@ \W]\[\033[36m\]\$(__git_ps1)\[\033[00m\]\$ "

source ~/dotfiles/git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=false
GIT_PS1_SHOWUPSTREAM=auto

export EDITOR=nvim

if [ ! -z "$NVIM_TUI_ENABLE_TRUE_COLOR" ];then
  source ~/dotfiles/nvim_bash
fi
