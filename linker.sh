#!/bin/bash

source bashrc

# Set up config files

# VIM
rm ~/.vimrc
ln -s `pwd`/vimrc ~/.vimrc
if [ "`pwd`/vim" != "`readlink ~/.vim`" ] || [ "$1" = "-f" ]; then
    rm -r ~/.vim
    ln -s `pwd`/vim ~/.vim
    rm -rf vim/bundle
    mkdir -p vim/bundle
    cd vim/bundle/
    # NERDTree
    git clone https://github.com/scrooloose/nerdtree.git
    cd ../../
fi

# BASH
rm ~/.bashrc
ln -s `pwd`/bashrc ~/.bashrc

# TMUX
rm ~/.tmux.conf
ln -s `pwd`/tmux.conf ~/.tmux.conf

# GIT
rm ~/.gitconfig
ln -s `pwd`/gitconfig ~/.gitconfig
