set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'itchyny/lightline.vim'

call vundle#end()
filetype plugin indent on

set number
set tabstop=2
set shiftwidth=2
set expandtab

" Status line
set laststatus=2
if !has('gui_running')
  set t_Co=256
endif
