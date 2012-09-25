#!/bin/bash

rm ~/.vimrc
ln -s `pwd`/vimrc ~/.vimrc

rm ~/.bashrc
ln -s `pwd`/bashrc ~/.bashrc

rm ~/.tmux.conf
ln -s `pwd`/tmux.conf ~/.tmux.conf

#rm ~/.xinitrc
#ln -s `pwd`/xinitrc ~/.xinitrc

#rm ~/.Xmodmap
#ln -s `pwd`/Xmodmap ~/.Xmodmap
