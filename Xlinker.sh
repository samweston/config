#!/bin/bash

rm ~/.xinitrc
ln -s `pwd`/xinitrc ~/.xinitrc

rm ~/.Xmodmap
ln -s `pwd`/Xmodmap ~/.Xmodmap
