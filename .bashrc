
alias la="ls -a"
alias ll="ls -l"

alias vim="nvim"
alias im="nvim"
alias vi="nvim"

alias pip="pip3"
alias python="python3"

alias showcase="ssh -p 22 showcase@showcase.trap.show"

declare -A shortDirs
shortDirs=(\
  ["desktop"]="/mnt/c/Users/ok/Desktop"\
  ["gacha"]="/mnt/c/Users/ok/Documents/SourceTree/Server"\
  ["work"]="/mnt/c/Users/ok/Documents/SourceTree"\
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

# あらかじめ `nvm default vX.Y.Z` してエイリアス "default" を作っておく

PATH=${NVM_DIR:-$HOME/.nvm}/versions/node/v7.8.0/bin:$PATH
MANPATH=${NVM_DIR:-$HOME/.nvm}/versions/node/v7.8.0/share/man:$MANPATH
export NODE_PATH=${NVM_DIR:-$HOME/.nvm}/versions/node/v7.8.0/lib/node_modules

#source ~/.nvm/nvm.sh
