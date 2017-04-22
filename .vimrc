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

if dein#load_state(s:dein_cache_dir)
  call dein#begin(s:dein_cache_dir)

	" プラグインマネージャ めっちゃ便利
  call dein#add('Shougo/dein.vim')

  " 暗黒の力
  call dein#add('Shougo/denite.nvim')

	" ファイラーvim上でフォルダ作ったりできるのでアドい
  call dein#add('scrooloose/nerdtree')

	" 補完系
  if has('lua')
    call dein#add('Shougo/neocomplete.vim')
  endif
  if has('nvim')
    call dein#add('Shougo/deoplete.nvim')
  endif
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " preview windowを表示しないように
  call dein#add('Shougo/echodoc')

	" ステータスラインをいい感じに
  call dein#add('itchyny/lightline.vim')

  " インデントをわかりやすくしてくれる
  call dein#add('nathanaelkane/vim-indent-guides')

  " カラースキーム
  call dein#add('tomasr/molokai')
  call dein#add('mhinz/vim-janah')
  call dein#add('jacoborus/tender')

  " 簡単にウィンドウサイズを変更
  call dein#add('simeji/winresizer')

  " vimからgitを利用する
  call dein#add('tpope/vim-fugitive')

  " 行番号のところに変更のマークを付ける
  call dein#add('airblade/vim-gitgutter')

  " gitのコミットログをきれいに表示
  call dein#add('cohama/agit.vim')

  " タブラインに開いているバッファの名前を表示
  call dein#add('ap/vim-buftabline')

  " よりリッチなカーソル移動
  call dein#add('Lokaltog/vim-easymotion')

  " emmet
  call dein#add('mattn/emmet-vim')
  
  " 静的解析用プラグイン
  call dein#add('neomake/neomake')

  " JS用プラグイン
    call dein#add('pangloss/vim-javascript')
    call dein#add('carlitux/deoplete-ternjs')
    " require eslint
    call dein#add('benjie/neomake-local-eslint.vim')
    call dein#add('heavenshell/vim-jsdoc')
    call dein#add('othree/yajs.vim')
    call dein#add('othree/es.next.syntax.vim')
    call dein#add('vim-jp/vimdoc-ja')
    call dein#add('tpope/vim-markdown')
    call dein#add('thinca/vim-quickrun')
    call dein#add('posva/vim-vue')

  " cpp用プラグイン
  call dein#add('zchee/deoplete-clang')

  " python用プラグイン
  call dein#add('zchee/deoplete-jedi')


  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
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
"colorscheme molokai
colorscheme tender

"highlight Normal ctermbg=none

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

" タブでスペースを使う
set expandtab

" 自動でインデントの調整smarttabよりこっちがいいらしい
set cindent

" インデントをshiftwidthの倍数に固定
set shiftround

set smarttab
" コロンでインデントの再調整をしない
set cinkeys-=:

" カッコを入力した時に対応した括弧をハイライトする
set showmatch matchtime=1

" スクロールのオフセットを設定
set sidescrolloff=12
set scrolloff=8
set sidescroll=1

" 検索時設定
set hlsearch
set incsearch
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
set foldmethod=marker
set foldmarker=/*,*/

" True Color用設定
"set termguicolors

" 補完時プレビューウィンドウを表示しない
set completeopt-=preview

"自動的に閉じカッコを入力
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>

" jsファイルを開いた時にeslint
autocmd! BufWritePost,BufRead *.js call JSBufEnter()

" インサートモードから抜けたら保存してeslint
autocmd! InsertLeave *.js :w|Neomake
autocmd! InsertLeave *.py :w|Neomake

" jsファイルを閉じる時にeslintを終了
autocmd! VimLeave *.js :lclose |!eslint_d stop

" 起動時処理
" autocmd! VimEnter * call Init()

" 名前付きバッファがNERDTreeのみになったら終了
autocmd! BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" 終了時にセッションを作って全く同じ状況で再起動できるように
autocmd! VimLeave * NERDTreeClose | mks! ~/.vim/session

" qfというファイルタイプの時にバッファに名前をつける
autocmd! FileType qf :file locationlist

" grepした後に自動で検索結果画面を出す
autocmd! QuickfixCmdPost *grep* cwindow

" インサートモードを抜けたら保存
autocmd! InsertLeave *.md :w
autocmd! InsertLeave *.html :w
autocmd! InsertLeave *.vue :w

" QuickRunの設定
let g:quickrun_config = {
\ "_": {
\   "outputter/buffer/split" : ":botright 8sp",
\   "outputter/buffer/close_on_empty" : 1
\ },
\ "python": {
\   "command" : "python3"
\ }
\}

" <C-c> で実行を強制終了させる
" quickrun.vim が実行していない場合には <C-c> を呼び出す
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

let g:user_emmet_settings = {'variables':{'lang' : 'ja'}}
let g:user_emmet_leader_key = '<C-l>'

let g:neomake_javascript_enabled_makers = ['eslint_d']
let g:neomake_vue_enabled_makers = ['eslint_d']
let g:neomake_python_enabled_makers = ['python', 'flake8', 'mypy']
let g:neomake_c_enabled_makers = ['clang']
let g:neomake_cpp_enabled_makers = ['clang']

let g:neomake_error_sign = {'text': '>>', 'texthl': 'Error'}
let g:neomake_warning_sign = {'text': '>>', 'texthl': 'Todo'}
let g:neomake_list_height = 10

let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_enable_es6 = 1
let g:jsdoc_input_description = 1

let g:winresizer_vert_resize=5

let g:NERDTreeShowHidden = 1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeShowLineNumbers = 0
let g:NERDTreeHighlightCursorline = 1
let g:NERDTreeWinSize = 24
let g:NERDTreeChDirMode = 2

let g:EasyMotion_do_mapping = 0

let g:neocomplete#enable_at_startup = 1
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 1
let g:deoplete#auto_complete_start_length = 1

let g:echodoc_enable_at_startup = 1

let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = '0'

let g:tern#filetypes = ['vue']

let g:indent_guides_enable_on_vim_startup = 1
let g:lightline = {
      \ 'colorscheme': 'tender',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive','po', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'readonly': 'LightlineReadonly',
      \   'modified': 'LightlineModified',
      \   'filename': 'LightlineFilename'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

" 上の関数で:wp :q を置き換える
" ウィンドウ閉じたいときは:x で代用する
ca wq call CloseBuffer()
ca q call CloseBuffer()
ca tw TranslateGoogleCmdReverse
ca qq quit!

" vimiumっぽい使い心地を目指した設定
noremap <silent><S-j> :bprevious<CR>
noremap <silent><S-k> :bnext<CR>
noremap <silent><S-h> :wincmd h<CR>
noremap <silent><S-l> :wincmd l<CR>
nmap <S-f> <Plug>(easymotion-overwin-f2)

noremap <Space>n :NERDTree<CR>
noremap <Space>q :x<CR>
noremap <Space>wq :write<CR>:x<CR>
noremap <Space>o :lopen<CR>
noremap <Space>w :write<CR>
noremap <silent><Esc><Esc> :noh<CR>
noremap <silent>t :terminal<CR>source ~/.bashrc<CR>clear<CR>

" 検索時に検索したワードが画面中央に来るように
noremap n nzzzv
noremap N Nzzzv

" 見た目上でのカーソル移動を行う
noremap j gj
noremap k gk

" vim上でGitを使うキーバインド設定
noremap <Space>gp :Gpush<CR>
noremap <Space>gc :Gcommit<CR>
noremap <Space>ga :write<CR>:Git add -A<CR>
noremap <Space>gv :Agit<CR>
noremap <Space>gs :Gstatus<CR>
noremap <Space>gf :Gitv!<CR>

" jsdocの設定
nmap <silent><C-l> :call jsdoc#insert()<CR>
noremap <Space>jd :call jsdoc#insert()<CR>

" deopleteとneosnippetの連携
inoremap <expr><tab> pumvisible() ? "\<C-n>" :
			\ neosnippet#expandable_or_jumpable() ?
			\    "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"

" neosnippet設定
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
if has('conceal')
	set conceallevel=2 concealcursor=niv
endif

" クリップボード連携
nnoremap <silent> <Space>y :.w !win32yank.exe -i<CR><CR>
vnoremap <silent> <Space>y :w !win32yank.exe -i<CR><CR>
nnoremap <silent> <Space>p :r !win32yank.exe -o<CR>
vnoremap <silent> <Space>p :r !win32yank.exe -o<CR>

" 必要な関数の宣言

" 変更があった場合にファイル名の横に+を表示する
function! LightlineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

" 読み込み専用の場合の表示設定
function! LightlineReadonly()
  if &filetype == "help"
    return "help"
  elseif &readonly
    return "ro"
  else
    return ""
  endif
endfunction

" gitに管理されているファイルの場合ブランチ名を表示
function! LightlineFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

" ファイル名の表示
function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

" 起動時に編集するファイルが指定されている場合はファイル側に指定されていない場合はNERDTreeにカーソルがいくように
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

