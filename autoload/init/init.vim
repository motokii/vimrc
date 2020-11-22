
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



" }}}
""""""""""""""""""""" plugin vim-indent-guides """""""""""""""""""""
" インデントに色を付けて見やすくする
set tabstop=4
set shiftwidth=4
set expandtab

" Enable omni completion.

""""""""""""""""""""" plugin osho-manga/vim-marching """""""""""""""""""""


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

" Mac 日本語入力をOffにする
if has('mac')
    augroup insertLeave
        autocmd!
        autocmd InsertLeave * :call job_start(
                    \ ['osascript', '-e', 'tell application "System Events" to key code {102}'],
                    \ {'in_io': 'null', 'out_io': 'null', 'err_io': 'null'})
    augroup END
endif

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


" インデント
set tabstop=4
set shiftwidth=4
set expandtab

