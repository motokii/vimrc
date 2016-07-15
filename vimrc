
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
NeoBundle 'nanotech/jellybeans.vim'


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
let g:neocomplete#enable_at_startup               = 1
let g:neocomplete#auto_completion_start_length    = 3
let g:neocomplete#enable_ignore_case              = 1
let g:neocomplete#enable_smart_case               = 1
let g:neocomplete#enable_camel_case               = 1
let g:neocomplete#use_vimproc                     = 1
let g:neocomplete#sources#buffer#cache_limit_size = 1000000
let g:neocomplete#sources#tags#cache_limit_size   = 30000000
let g:neocomplete#enable_fuzzy_completion         = 1
let g:neocomplete#lock_buffer_name_pattern        = '\*ku\*'
" }}}

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

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_save = 1
let g:syntastic_check_on_wq = 0

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
"color scheme

colorscheme jellybeans
set t_Co=256
syntax on

" 行番号表示
set number
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

