
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc
" When started as "evim", evim.vim will already have done these settings.

if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoBundle
" http://qiita.com/himinato/items/caf5a0b19ce893a75363
" neobundle settings {{{
if has('vim_starting')
    set nocompatible
    " neobundle をインストールしていない場合は自動インストール
    if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
        echo "install neobundle..."
        " vim からコマンド呼び出しているだけ neobundle.vim のクローン
        :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
    endif
    " runtimepath の追加は必須
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))
let g:neobundle_default_git_protocol='https'

" neobundle#begin - neobundle#end の間に導入するプラグインを記載します。
NeoBundleFetch 'Shougo/neobundle.vim'

" ------------------------------------
" colorscheme
" ------------------------------------
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'sjl/badwolf'
NeoBundle 'tomasr/molokai'

""""""""""""""""""""" plugin vim-indent-guides """""""""""""""""""""
" インデントに色を付けて見やすくする
NeoBundle 'nathanaelkane/vim-indent-guides'
set tabstop=4
set shiftwidth=4
set expandtab

" vim立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup=1
" ガイドをスタートするインデントの量
let g:indent_guides_start_level=2
" 自動カラーを無効にする
let g:indent_guides_auto_colors=0
" 奇数インデントのカラー
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#262626 ctermbg=gray
" 偶数インデントのカラー
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3c3c3c ctermbg=darkgray
" ハイライト色の変化の幅
let g:indent_guides_color_change_percent = 30
" ガイドの幅
let g:indent_guides_guide_size = 1


""""""""""""""""""""" plugin 行末の半角スペースを可視化 """""""""""""""""""""
NeoBundle 'bronson/vim-trailing-whitespace'


""""""""""""""""""""" plugin Git vim-fugitive """""""""""""""""""""
NeoBundle 'tpope/vim-fugitive'


""""""""""""""""""""" plugin unite.vim """""""""""""""""""""
NeoBundle 'Shougo/unite.vim'

""""""""""""""""""""" plugin neomru.vim """""""""""""""""""""
NeoBundle 'Shougo/neomru.vim', {
  \ 'depends' : 'Shougo/unite.vim'
  \ }

""""""""""""""""""""" plugin neocomplete.vim """""""""""""""""""""
if has('lua')
  NeoBundleLazy 'Shougo/neocomplete.vim', {
    \ 'depends' : 'Shougo/vimproc',
    \ 'autoload' : { 'insert' : 1,}
    \ }
endif


" neocomplete {{{

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" }}}


""""""""""""""""""""" plugin osho-manga/vim-marching """""""""""""""""""""
NeoBundleLazy 'osyo-manga/vim-marching'

if neobundle#tap('vim-marching')
  call neobundle#config({
  \   'autoload': {
  \     'filetypes': ['c', 'cpp']
  \   },
  \   'depends': ['Shougo/vimproc.vim', 'osyo-manga/vim-reunions']
  \ })

  let g:marching_enable_neocomplete = 1

  call neobundle#untap()
endif

""""""""""""""""""""" plugin Lokaltog/vim-powerline """""""""""""""""""""
NeoBundle 'Lokaltog/powerline', {'rtp' : 'powerline/bindings/vim'}
set encoding=utf-8 " Necessary to show Unicode glyphs
let g:Powerline_symbols='fancy'

""""""""""""""""""""" plugin vimproc """""""""""""""""""""
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \     'windows' : 'make -f make_mingw32.mak',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }

""""""""""""""""""""" plugin NERDTree """""""""""""""""""""
NeoBundle 'scrooloose/nerdtree'

""""""""""""""""""""" plugin syntastic syntax check """""""""""""""""""""
NeoBundle 'scrooloose/syntastic'

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_save = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_c_check_header = 0
let g:syntastic_cpp_check_header = 0
let g:syntastic_loc_list_height=6 "エラー表示ウィンドウの高さ
let g:syntastic_javascript_checkers = ['eslint'] "ESLintを使う
let g:syntastic_mode_map = {
      \ 'mode': 'active',
      \ 'active_filetypes': ['javascript'],
      \ 'passive_filetypes': []
      \ }

""""""""""""""""""""" plugin Python Program Slice """""""""""""""""""""
NeoBundle 'romanofski/programslice.vim'
let g:programslice_debug_file = "$HOME/.vimrc/vimrc/programslice_debug_file.txt"

""""""""""""""""""""" plugin vim-latex """""""""""""""""""""
NeoBundle 'vim-latex/vim-latex'

""""""""""""""""""""" plugin vim-scripts/DoxygenToolkit.vim """""""""""""""""""""
NeoBundle 'vim-scripts/DoxygenToolkit.vim'

""""""""""""""""""""" plugin tmux-plugins/vim-tmux  .tmux.conf syntax highlighting """""""""""""""""""""
NeoBundle 'tmux-plugins/vim-tmux'

""""""""""""""""""""" plugin kannokanno/previm markdown preview"""""""""""""""""""""
NeoBundle 'kannokanno/previm'
augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
let g:previm_open_cmd = 'open '

""""""""""""""""""""" plugin kannokanno/previm markdown preview"""""""""""""""""""""
NeoBundle 'editorconfig/editorconfig-vim'

""""""""""""""""""""" plugin pangloss/vim-javascript """""""""""""""""""""
NeoBundle 'pangloss/vim-javascript'

""""""""""""""""""""" plugin Twonk/vim-autoclose """""""""""""""""""""
" ノーマルモードに戻るのが遅くなるから消した
" neocomplete と相性が悪いらしい
" NeoBundle 'Townk/vim-autoclose'

""""""""""""""""""""" plugin Twonk/vim-autoclose """""""""""""""""""""
NeoBundle 'yonchu/accelerated-smooth-scroll'

""""""""""""""""""""" plugin "vim-coffee-script""""""""""""""""""""
NeoBundle 'vim-coffee-script'

""""""""""""""""""""" END of PLUGIN SETTINGS """""""""""""""""""""
" vimrc に記述されたプラグインでインストールされていないものがないかチェックする
NeoBundleCheck
call neobundle#end()

function! s:isLinux()
    if stridx(system("uname"), "Linux") != -1
        return 1
    else
        return 0
    endif
endfunction
function! s:isMac()
    if stridx(system("uname"), "Darwin") != -1
        return 1
    else
        return 0
    endif
endfunction

" ------------------------------------
" colorscheme
" ------------------------------------
colorscheme molokai
highlight Normal ctermbg=none
set t_Co=256
syntax on

" 行番号非表示
set nonumber
"カーソルライン
set cursorline
" 行番号ハイライト
hi CursorLineNr term=bold cterm=NONE ctermfg=228 ctermbg=NONE

" クリップボード共有(Linux, Mac)
if s:isLinux()
    set clipboard=unnamedplus
endif
if s:isMac()
    set clipboard=unnamed,autoselect
endif

""""""""""""""""""""""""""""""
" 全角スペースの表示　
" http://inari.hatenablog.com/entry/2014/05/05/231307
""""""""""""""""""""""""""""""
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif
""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" スペース、タブの表示
set list
set listchars=tab:»-,trail:-,nbsp:%,eol:↲

""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインの色を変更
" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
""""""""""""""""""""""""""""""
" let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'
" 
" if has('syntax')
"   augroup InsertHook
"     autocmd!
"     autocmd InsertEnter * call s:StatusLine('Enter')
"     autocmd InsertLeave * call s:StatusLine('Leave')
"   augroup END
" endif

let s:slhlcmd = ''
let s:isHighlighted = 0
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    if s:isHighlighted == 0
        let s:isHighlighted = 1
        silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
        silent exec g:hi_insert
    endif
  else
    if s:isHighlighted == 1
        let s:isHighlighted = 0
        highlight clear StatusLine
        silent exec s:slhlcmd
    endif
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction
""""""""""""""""""""""""""""""

" 入力中のコマンドを表示する
set showcmd

" 言語スタイルのインデントを自動で入れる
set cindent

" ステータスラインを変更
" file encoding/format type y/length, percent char_hex
 :set statusline=%F%m%r%h%w\ [ENC=%{&fileencoding}/%{&ff}]\ [%Y]\ [%04l/%L,%04v][%p%%]\ [0x%B]
 :set laststatus=2

" syntatic
if exists("*SyntasticStatuslineFlag")
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
endif


" fileencodings
set fileencodings=utf-8,euc-jp

" KEY MAP
" INSERT MODE カーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-b> <Left>
inoremap <C-f> <Right>

" 検索
nnoremap /  /\v

" http://d.hatena.ne.jp/osyo-manga/20131219/1387465034
" Vim で C++ の設定例

" filetype=cpp が設定された時に呼ばれる関数
"Vim で C++ の設定を行う場合はこの関数内で記述する
" ここで設定する項目は各自好きに行って下さい
function! s:cpp()
    " インクルードパスを設定する
    " gf などでヘッダーファイルを開きたい場合に影響する
    setlocal path+=D:/home/cpp/boost,D:/home/cpp/sprout

    " 括弧を構成する設定に <> を追加する
    " template<> を多用するのであれば
    setlocal matchpairs+=<:>

    " 最後に定義された include 箇所へ移動してを挿入モードへ
    nnoremap <buffer><silent> <Space>ii :execute "?".&include<CR> :noh<CR> o

    " BOOST_PP_XXX 等のハイライトを行う
    syntax match boost_pp /BOOST_PP_[A-z0-9_]*/
    highlight link boost_pp cppStatement
endfunction


augroup vimrc-cpp
    autocmd!
    " filetype=cpp が設定された場合に関数を呼ぶ
    autocmd FileType cpp call s:cpp()
augroup END

" insert mode から抜けたときにIMEをオフに
set imdisable

" c++を認識させる
autocmd BufNewFile,BufRead *.{cpp,h,hpp} set filetype=cpp

set tags=./tags;,tags;

" ノーマルモードに戻るのが遅い
"  (http://yukidarake.hateblo.jp/entry/2015/07/10/201356)
" set timeout timeoutlen=50
set timeout timeoutlen=1000 ttimeoutlen=50
