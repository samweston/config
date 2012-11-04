#!/bin/bash

rm ~/.vimrc
ln -s `pwd`/vimrc ~/.vimrc
mkdir -p ~/.vim/syntax
ln -s `pwd`/vim/syntax/armasm.vim ~/.vim/syntax/armasm.vim

rm ~/.bashrc
ln -s `pwd`/bashrc ~/.bashrc

rm ~/.tmux.conf
ln -s `pwd`/tmux.conf ~/.tmux.conf

