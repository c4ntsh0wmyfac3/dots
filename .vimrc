" General
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set autoindent
set smartindent
set number
set relativenumber
set nocompatible
" set cursorline
set title
set incsearch
set hlsearch
set ignorecase
set smartcase
set nobackup
set nowritebackup
set noswapfile
set undofile
set undodir=~/.vim/undodir
syntax on
filetype on
set mouse=a
set ttyfast          
set autoread
set termguicolors
colorscheme habamax

"  Keymaps
let mapleader = "\<Space>"
map ; :
map <leader>l :nohl<CR>
map <leader>e :Ex<CR>
map ,u :source $MYVIMRC<CR>
map L :bn<CR>
map H :bp<CR>
map <C-H> :wincmd h<CR>
map <C-J> :wincmd j<CR>
map <C-K> :wincmd k<CR>
map <C-L> :wincmd l<CR>
map <leader>tt :terminal<CR>
