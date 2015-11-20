#!/bin/sh
check_file() {
    if [ -e "$1" ]; then
        echo "Error, $1 already exists."
        exit
    else
        echo "$1 not exists"
    fi
}
check_file "$HOME/.vimrc"
check_file "$HOME/.vim/vimrc"
git clone https://github.com/motokii/vimrc.git $HOME/.vim/vimrc
ln -s $HOME/.vim/vimrc/.vimrc $HOME/.vimrc
