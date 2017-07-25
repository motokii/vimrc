""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" dein.vim のインストールと、プラグインのインストール
" http://qiita.com/himinato/items/caf5a0b19ce893a75363
" http://wakame.hatenablog.jp/entry/2016/10/09/174035
if has('vim_starting')
    set nocompatible
    let s:dein_path = expand('~/.vim/dein')
    let s:dein_repo_path = s:dein_path . '/repos/github.com/Shougo/dein.vim'
    " dein.vim をインストールしていない場合は自動インストール
    if !isdirectory(expand("~/.vim/dein/repos/github.com/Shougo/dein.vim"))
        echo "install dein.vim..."
        " dein.vim のクローン
        call system("mkdir -p ~/.vim/dein/repos/github.com/Shougo/dein.vim")
        call system("git clone https://github.com/Shougo/dein.vim.git  ~/.vim/dein/repos/github.com/Shougo/dein.vim")
    endif
    " runtimepath の追加
    set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
endif
let g:dein#enable_notification = 1

call dein#begin(s:dein_path)
call dein#load_toml(g:vimrc_path . '/autoload/dein/plugins.toml', {'lazy': 0})
call dein#load_toml(g:vimrc_path . '/autoload/dein/plugins-lazy.toml', {'lazy': 1})
call dein#end()

if dein#check_install()
  call dein#install()
endif

