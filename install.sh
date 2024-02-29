#!/bin/bash

# ln -sf <target> <symlink>
# -f option forces the creation of the link. It removes any existing link or file with the same name before creating a new symlink
#
#   We first create the directories because if the directory does not exist it will reproduce an error message 
#####
#nvim#
#####

mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.config/nvim/undo"
ln -sf "$HOME/dotfiles/nvim/init.vim" "$HOME/.config/nvim"


#####
#X11##
#####

rm -rf "$HOME/.config/X11"
ln -s "$HOME/dotfiles/X11" "$HOME/.config"


#####
# i3#
####"

rm -rf "$HOME/.config/i3"
ln -s "$HOME/dotfiles/i3" "$HOME/.config"
