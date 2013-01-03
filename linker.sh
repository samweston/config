#!/bin/bash

rm ~/.vimrc
ln -s `pwd`/vimrc ~/.vimrc
mkdir -p ~/.vim/syntax
ln -s `pwd`/vim/syntax/* ~/.vim/syntax/ &> /dev/null
mkdir -p ~/.vim/ftdetect
ln -s `pwd`/vim/ftdetect/* ~/.vim/ftdetect/ &> /dev/null

rm ~/.bashrc
ln -s `pwd`/bashrc ~/.bashrc

rm ~/.tmux.conf
ln -s `pwd`/tmux.conf ~/.tmux.conf

