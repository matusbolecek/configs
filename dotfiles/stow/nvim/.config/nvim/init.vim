"             _           
"  _ ____   _(_)_ __ ___  
" | '_ \ \ / / | '_ ` _ \ 
" | | | \ V /| | | | | | |
" |_| |_|\_/ |_|_| |_| |_|

set t_Co=256
set number relativenumber                         
set hlsearch
set incsearch
set scrolloff=8

call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'ap/vim-css-color'

call plug#end()

let mapleader = " "
let g:lightline = {
	\ 'colorscheme': 'deus',
	\ }
