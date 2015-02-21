#!/bin/bash

DIR=/mnt/tb2/online.storage/github
HOME=/home/zymos

# scripts
cp /usr/scripts/* $DIR/scripts

cp $HOME/scriptsPersonal/*.* $DIR/scripts_personal


# global configs /etc
cp /etc/vim/vimrc.local $DIR/global_etc_files 
cp /etc/profile.d/*.* $DIR/global_etc_files

# dotfiles
cp $HOME/.Xresources $DIR/dotfiles
cp $HOME/.tmux.conf $DIR/dotfiles
cp $HOME/.Xdefaults $DIR/dotfiles
cp $HOME/.magic_files $DIR/dotfiles
cp $HOME/.magic_files_home $DIR/dotfiles
cp $HOME/.mpv/config $DIR/dotfiles/.mpv/
cp $HOME/.mpv/input.conf $DIR/dotfiles/.mpv/
cp $HOME/Documents/share/jeff_autostart.sh $DIR/dotfiles
# cp $HOME/ $DIR/dotfiles
# cp $HOME/ $DIR/dotfiles
# cp $HOME/ $DIR/dotfiles
# cp $HOME/ $DIR/dotfiles

