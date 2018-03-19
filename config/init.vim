"
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
"
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
let s:lazy_toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein_lazy.toml'
if dein#load_state(s:dein_cache_dir)
  call dein#begin(s:dein_cache_dir)

  " dein.toml のロード(ぼちぼち移行していこう)
  call dein#load_toml(s:lazy_toml_file, {'lazy': 1})
  call dein#load_toml(s:toml_file, {'lazy': 0})


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

filetype plugin on

" 各種操作をした時に無駄にビープ音がならないように
set t_ut=

set cmdheight=2

" エスケープ後にすぐ入力できるように
set timeout timeoutlen=1000 ttimeoutlen=50

" ファイルを開いた時にできる各種意味分からないファイルをできないようにする
set nowritebackup
set nobackup
set noswapfile


set autowrite
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

set autoindent copyindent preserveindent

set autoread
" set smarttab

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

nmap <silent><Space>t :call Template()<CR>

function Template()
  if &filetype == "go"
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

command! ATCSubmit :!atcoder-go submit %

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
noremap <silent><Space>e :!nautilus . &<CR><CR>
noremap <silent><Space>c :!cmd.exe /c start cmd.exe<CR><CR>
inoremap <C-l><C-l> <Right>
inoremap <Leader>po <C-R>=expand('%')<CR>

" 検索時に検索したワードが画面中央に来るように
noremap n nzzzv
noremap N Nzzzv

" 見た目上でのカーソル移動を行う
noremap j gj
noremap k gk

if $HOST_MACHINE == 'tohuWSL' "WSLのときの設定
  " クリップボード連携
  nnoremap <silent> <Space>y :.w !win32yank.exe -i<CR><CR>
  vnoremap <silent> <Space>y :w !win32yank.exe -i<CR><CR>
  nnoremap <silent> <Space>p :r !win32yank.exe -o<CR>
  vnoremap <silent> <Space>p :r !win32yank.exe -o<CR>
  nnoremap <silent> <Space>a :%w !win32yank.exe -i<CR><CR>
  tnoremap <silent><expr> <C-v> Po()
  map <C-n> :cnext<CR>
  map <C-m> :cprevious<CR>
  nnoremap <leader>a :cclose<CR>

  " 必要な関数の宣言
  function Po()
    return system('win32yank.exe -o')
  endfunction

  tnoremap <silent><expr> <RightMouse> Po()
  inoremap <silent><expr> <RightMouse> Po()
  let g:python_host_skip_check = 1
  let g:python_host_prog='/usr/bin/python'
  let g:python3_host_skip_check = 1
  let g:python3_host_prog='/usr/bin/python3'
endif

nnoremap <silent> <Space>y :.w !xsel -bi<CR><CR>
vnoremap <silent> <Space>y :w !xsel -bi<CR><CR>

"function! Init()
"  NERDTree
"  if (bufname(2) != '' && bufname(2) != 'NERD_tree_1') || argc()
"    2wincmd w
"  endif 
"endfunction

" JSのファイルを開いた時に自動でNeomakeを行う
"function! JSBufEnter()
"  " 一つ前にいたバッファがlocationlistの場合はしない
"  " これをしないとlocationlistからジャンプできない
"  if(bufname('#') != 'locationlist')
"    Neomake
"  endif
"endfunction

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
tnoremap <silent> <ESC> <C-\><C-n>

let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
let g:terminal_scrollback_buffer_size = 10000

if has('nvim')
  autocmd! TermOpen * setlocal nonumber
endif

autocmd! InsertEnter,WinEnter * checktime

syntax on
colorscheme tender
highlight Normal ctermbg=none

augroup go
  autocmd!

  " Show by default 4 spaces for a tab
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=2 shiftwidth=2

  " :GoBuild and :GoTestCompile
  autocmd FileType go nmap <Space>b :<C-u>call <SID>build_go_files()<CR>

  " :GoTest
  autocmd FileType go nmap <Space>t  :call TestAllOrFunc()<CR>

  " :GoRun
  "autocmd FileType go nmap <leader>r  <Plug>(go-run)

  " :GoDoc
  autocmd FileType go nmap <Space>d <Plug>(go-doc)

  " :GoCoverageToggle
  autocmd FileType go nmap <Space>c <Plug>(go-coverage-toggle)

  " :GoInfo
  autocmd FileType go nmap <Space>i <Plug>(go-info)

  " :GoMetaLinter
  autocmd FileType go nmap <Space>l <Plug>(go-metalinter)

  " :GoDef but opens in a vertical split
  autocmd FileType go nmap <Space>v <Plug>(go-def-vertical)
  " :GoDef but opens in a horizontal split
  autocmd FileType go nmap <Space>s <Plug>(go-def-split)

  autocmd FileType go nmap <C-m> :GoDeclsDir<CR>

  " :GoAlternate  commands :A, :AV, :AS and :AT
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

function! TestAllOrFunc()
  let l:funcName = cfi#get_func_name()
  if l:funcName =~# '^Test.*'
    :normal [[
    :GoTestFunc
  else
    :GoTest
  endif
endfunction

function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
