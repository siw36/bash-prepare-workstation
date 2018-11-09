#!/bin/bash

# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Replace .vimrc
cp -r ./.vimrc  ~/.vimrc

# Install plugins
vim +PluginInstall +qall

# Install compiler
sudo dnf install cmake gcc-c++ make python3-devel

# Compile YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe
python3 install.py --clang-completer
