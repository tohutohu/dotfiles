"   $$\                       $$\                   $$\               $$\                 
"   $$ |                      $$ |                  $$ |              $$ |                
" $$$$$$\    $$$$$$\          $$$$$$$\  $$\   $$\ $$$$$$\    $$$$$$\  $$$$$$$\  $$\   $$\ 
" \_$$  _|  $$  __$$\ $$$$$$\ $$  __$$\ $$ |  $$ |\_$$  _|  $$  __$$\ $$  __$$\ $$ |  $$ |
"   $$ |    $$ /  $$ |\______|$$ |  $$ |$$ |  $$ |  $$ |    $$ /  $$ |$$ |  $$ |$$ |  $$ |
"   $$ |$$\ $$ |  $$ |        $$ |  $$ |$$ |  $$ |  $$ |$$\ $$ |  $$ |$$ |  $$ |$$ |  $$ |
"   \$$$$  |\$$$$$$  |        $$ |  $$ |\$$$$$$  |  \$$$$  |\$$$$$$  |$$ |  $$ |\$$$$$$  |
"    \____/  \______/         \__|  \__| \______/    \____/  \______/ \__|  \__| \______/ 

" auther: to-hutohu
" e-mail: tohu.soy@gmail.com

" vi(vimの元になったやつ)のとの互換性を切る
" これをしないと上手く動かない機能がある
set nocompatible

" ======================================================================================
" Plugins
" ======================================================================================

" dein自体の自動インストール
" let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.vim') : $XDG_CACHE_HOME
let g:cache_home = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let g:config_home = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME

" dein {{{
let s:dein_cache_dir = g:cache_home . '/dein'

" reset augroup
augroup MyAutoCmd
	autocmd!
augroup END

if &runtimepath !~# '/dein.vim'
	let s:dein_repo_dir = s:dein_cache_dir . '/repos/github.com/Shougo/dein.vim'

	" Auto Download
	if !isdirectory(s:dein_repo_dir)
		call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
	endif

	" dein.vim をプラグインとして読み込む
	execute 'set runtimepath^=' . s:dein_repo_dir
endif

" dein.vim settings
let g:dein#install_max_processes = 16
let g:dein#install_progress_type = 'title'
let g:dein#install_message_type = 'none'
let g:dein#enable_notification = 1

let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_cache_dir)
  call dein#begin(s:dein_cache_dir)

  " dein.toml のロード(ぼちぼち移行していこう)
  call dein#load_toml(s:toml_file)

  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
  call dein#remote_plugins()
endif

" カーソル位置の復元
" 前回終了時のカーソル位置に戻す コピペ
augroup restoreCursorPosition
  autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
augroup END

" 色数の指定 (tmux上でもちゃんとしたカラースキームになるように)
" set t_Co=256

" シンタックスハイライトの設定
syntax on

filetype plugin on
colorscheme tender

highlight Normal ctermbg=none

" 各種操作をした時に無駄にビープ音がならないように
set t_ut=

set cmdheight=2

" エスケープ後にすぐ入力できるように
set timeout timeoutlen=1000 ttimeoutlen=50

" ファイルを開いた時にできる各種意味分からないファイルをできないようにする
set nowritebackup
set nobackup
set noswapfile

" カーソルLINEを表示しない
set nocursorline

" 行数の絶対表示
set number
set norelativenumber

" バックアップファイルの位置
set directory=/tmp

" デフォルトで保存するときの文字エンコード
set encoding=utf-8

" スクロールの高速化
set lazyredraw
set ttyfast

" タブのスペースの数
set tabstop=2
set shiftwidth=2
set shiftround

" タブでスペースを使う
set expandtab

set smarttab

" カッコを入力した時に対応した括弧をハイライトする
set showmatch matchtime=1

" スクロールのオフセットを設定
set sidescrolloff=12
set scrolloff=8
set sidescroll=1

" 検索時設定
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrap

set mouse=a

set backspace=start,eol,indent
set virtualedit+=block
set laststatus=2
set vb t_vb=
set confirm    
set hidden     
set autoread

" アンドゥファイルを使う
set undofile

" ファイルの場所の設定
" set undodir='~/.vim/undodir'

" 折りたたみ設定
" set foldmethod=marker
" set foldmarker=/*,*/

" True Color用設定
"set termguicolors

" 補完時プレビューウィンドウを表示しない
set completeopt-=preview

"自動的に閉じカッコを入力
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>

autocmd! InsertLeave *.tex :call TexCompile()
autocmd! InsertLeave *.md :w
autocmd! InsertLeave *.html :w
autocmd! BufWritePost FileType vim :source %

function TexCompile()
  :write
  :call jobstart('latexmk')
endfunction


" 起動時処理
" autocmd! VimEnter * call Init()

" 名前付きバッファがNERDTreeのみになったら終了
autocmd! BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" 終了時にセッションを作って全く同じ状況で再起動できるように
autocmd! VimLeave * NERDTreeClose | mks! ~/.cache/session

" grepした後に自動で検索結果画面を出す
autocmd! QuickfixCmdPost *grep* cwindow

nnoremap <silent><Space>t :call Template()<CR>

function Template()
  if &filetype == "go"
    write
    let l:file = expand('%:r')
    GoTestCompile
    if filereadable('./' . file . '_test.go')
      GoTest
    endif
    return
  endif
  :execute ":0r ~/dotfiles/templates/". &filetype ."-template.".&filetype
endfunction

nnoremap <silent><Space>r :call Run()<CR>

function Run()
  if &filetype == "go"
    write
    GoRun
    execute ":normal \<C-w>ji"
    return
  endif
  let commands = {
  \ "cpp" : "g++ -std=c++14 % && ./a.out",
  \ "c" : "gcc % && ./a.out",
  \ "python" : "python3 %",
  \ "javascript" : "node %",
  \ "tex" : "latexmk",
  \ "java" : "javac % && java %:r"
  \}
  :write
  :split
  :execute ":normal \<C-w>j"
  :execute ":terminal " . commands[&filetype]
endfunction

" 上の関数で:wp :q を置き換える
" ウィンドウ閉じたいときは:x で代用する
ca wq call CloseBuffer()
ca q call CloseBuffer()
ca qq quit!

" vimiumっぽい使い心地を目指した設定
noremap <silent><S-j> :bprevious<CR>
noremap <silent><S-k> :bnext<CR>
noremap <silent><S-h> :wincmd h<CR>
noremap <silent><S-l> :wincmd l<CR>

noremap <Space>n :NERDTreeToggle<CR>
noremap <Space>q :x<CR>
noremap <Space>wq :write<CR>:bd<CR>
noremap <Space>cp :write<CR>:sp<CR><C-w>j:terminal g++ % && ./a.out<CR>
noremap <Space>o :lopen<CR>
noremap <Space>w :write<CR>
noremap <silent><Esc><Esc> :noh<CR>
noremap <silent>t :terminal<CR>
noremap <silent><Space>e :!explorer.exe `pwd \| sed -e "s@\/mnt\/c\/@C:\\\\\\@" \| sed -e "s@\/@\\\\\\@g"`<CR><CR>
noremap <silent><Space>c :!cmd.exe /c start cmd.exe<CR><CR>

" 検索時に検索したワードが画面中央に来るように
noremap n nzzzv
noremap N Nzzzv

" 見た目上でのカーソル移動を行う
noremap j gj
noremap k gk

" クリップボード連携
nnoremap <silent> <Space>y :.w !win32yank.exe -i<CR><CR>
vnoremap <silent> <Space>y :w !win32yank.exe -i<CR><CR>
nnoremap <silent> <Space>p :r !win32yank.exe -o<CR>
vnoremap <silent> <Space>p :r !win32yank.exe -o<CR>
nnoremap <silent> <Space>a :%w !win32yank.exe -i<CR><CR>

tnoremap <silent><expr> <C-v> Po()

" 必要な関数の宣言
function Po()
  return system('win32yank.exe -o')
endfunction

tnoremap <silent><expr> <RightMouse> Po()
inoremap <silent><expr> <RightMouse> Po()
inoremap <C-l><C-l> <Right>

function! Init()
  NERDTree
  if (bufname(2) != '' && bufname(2) != 'NERD_tree_1') || argc()
    2wincmd w
  endif 
endfunction

" JSのファイルを開いた時に自動でNeomakeを行う
function! JSBufEnter()
  " 一つ前にいたバッファがlocationlistの場合はしない
  " これをしないとlocationlistからジャンプできない
  if(bufname('#') != 'locationlist')
    Neomake
  endif
endfunction

" バッファを閉じる時にそのウィンドウは閉じないでバッファだけ閉じるようにする関数
function! CloseBuffer()
  " NERDTreeとかだったら普通にウィンドウごと閉じるようにする
  if @% == 'NERD_tree_1' || @% == 'locationlist' || @% == 'COMMITMSG_EDITING'
    q
    return
  elseif @% != ''
    w
  endif

  " 閉じるべきバッファ番号を保存してバッファを移動してバッファ番号指定で消す
  let po = bufnr('%')
  bprevious
  execute 'bd! '.po 
endfunction

" neovim用設定
if has('nvim')
  tnoremap <silent> <ESC> <C-\><C-n>

  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

