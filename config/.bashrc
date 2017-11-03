if [ -z "$NVIM_TERM" -a -z "$TMUX" ];then
  if [ -z "$SSH_CLIENT" ];then
    bash ~/dotfiles/utils/confirm.sh "    tmux?" yes
    if [ $? == 0 ]; then
      tmux
    fi
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
alias svim="sudo -E nvim"
alias im="nvim"
alias vi="nvim"
alias v="nvim -S ~/.cache/session"

alias pip="pip3"
alias python="python3"

alias showcase="ssh -p 22 showcase@showcase.trap.show"
alias raspi="ssh -i ~/.ssh/id_rsa pi@192.168.2.112 -p 29931"
alias raspilan="ssh -i ~/.ssh/id_rsa pi@192.168.2.110 -p 29931"
alias conoha="ssh -i ~/.ssh/id_rsa conoha@150.95.157.72 -p 29931"
alias s1="ssh -i ~/.ssh/id_rsa to-hutohu@s1.trapti.tech"
alias s2="ssh -i ~/.ssh/id_rsa to-hutohu@s2.trapti.tech"
alias aws="ssh -i ~/.ssh/to-hutohu.pem ubuntu@ec2-54-178-167-120.ap-northeast-1.compute.amazonaws.com"
alias home="ssh -i ~/.ssh/id_rsa to-hutohu@180.31.148.158 -p 29932"
alias note="ssh -i ~/.ssh/id_rsa to-hutohu@192.168.2.107 -p 29932"
alias raspiwan="ssh -i ~/.ssh/id_rsa to-hutohu@180.31.148.158 -p 29931"


tsubame(){
  echo "Input Student ID:"
  read id
  ssh -i ~/.ssh/id_rsa ${id}@login-t2.g.gsic.titech.ac.jp
}

declare -A shortDirs
shortDirs=(\
  ["desktop"]="/mnt/c/Users/ok/Desktop"\
  ["work"]="/mnt/c/Users/ok/Documents/workspace"\
  ["cpp"]="/mnt/c/Users/ok/Documents/Kyopro"\
  ["kadai"]="/mnt/c/Users/ok/Documents/Kadai"\
  ["sandbox"]="/mnt/c/Users/ok/Documents/workspace/sandbox"\
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

gvm() {
	# まず仮の nvm コマンドを unset
	unset -f gvm

	# nvm.sh をロード
	# ここで本物の nvm コマンドが定義される
	source $HOME/.gvm/scripts/gvm

	# 仮の nvm コマンドに渡された引数を本物に受け渡す
	gvm "$@"
}

sl(){
  node ~/dotfiles/poop/sl_sarashi.js&

  /usr/games/sl
}

pdf() {
  if [ $1 = "-h" ];then 
    echo "--toc:目次 -N:セクションに数字"
    return
  fi
  pandoc $1 -o out.pdf -V documentclass=ltjarticle --latex-engine=lualatex -V geometry:margin=1in $2
}

# あらかじめ `nvm default vX.Y.Z` してエイリアス "default" を作っておく

GOPATH=$HOME/.go
GOBIN=$GOPATH/bin
PATH=$PATH:$GOPATH/bin

def=`cat ~/.nvm/alias/default`

PATH=${NVM_DIR:-$HOME/.nvm}/versions/node/${def}/bin:$PATH
MANPATH=${NVM_DIR:-$HOME/.nvm}/versions/node/${def}/share/man:$MANPATH
export NODE_PATH=${NVM_DIR:-$HOME/.nvm}/versions/node/${def}/lib/node_modules

PS1="\n\[\033[1;32m\]\$(date +%Y/%m/%d_%H:%M:%S)\[\033[0m\] \[\033[33m\]\H:\w\n\[\033[0m\][\u@ \W]\[\033[36m\]\$(__git_ps1)\[\033[00m\]\$ "

[ -n "$RANGER_LEVEL" ] && PS1="$PS1"'(in ranger) '

source ~/dotfiles/git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=false
GIT_PS1_SHOWUPSTREAM=auto

export EDITOR=nvim

if [ ! -z "$NVIM_TUI_ENABLE_TRUE_COLOR" ];then
  source ~/dotfiles/vim/nvim_bash
fi

eval $(thefuck --alias)

[[ -s "/home/to-hutohu/.gvm/scripts/gvm" ]] && source "/home/to-hutohu/.gvm/scripts/gvm"