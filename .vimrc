" Set leader keys
let mapleader = " "
let maplocalleader = " "

" Enable filetype plugins and syntax highlighting
filetype plugin indent on
syntax on

" Enable modelines
set modeline

" Set shell
set shell=/bin/csh

" Swap files
set swapfile
set updatetime=150
set updatecount=50

" Buffers
set hidden

" Encoding
set fileencoding=utf-8

" Spelling
set nospell
set spelllang=en_gb

" Line numbers
set number
set relativenumber

" Colour column
set colorcolumn=80,100,120


" Line length and wrapping
set textwidth=100
set formatoptions=tcron1jpl

" Enable mouse
set mouse=a

" Enable break indent
set breakindent

" Tab settings
set tabstop=4
set softtabstop=4
set shiftwidth=4

set cindent
set autoindent
set expandtab

" Undo history
set undofile

" Signcolumn
set signcolumn=yes

" Timeout for key sequences
set timeoutlen=300

" Split behavior
set splitright
set splitbelow

" Whitespace characters
"set list
"set listchars=tab:»\ ,trail:·,nbsp:␣

" Cursor line
set cursorline

" Scroll offset
set scrolloff=5

" Basic Keymaps
nnoremap <leader>w :w<CR>
nnoremap <leader>wa :wa<CR>
nnoremap <leader>wq :xa<CR>
inoremap <leader>wq <ESC>:xa<CR>

nnoremap j gj
nnoremap k gk

" Clipboard keymaps
nnoremap <leader>cy "+y
vnoremap <leader>cy "+y
nnoremap <leader>cp "+p
vnoremap <leader>cp "+p
nnoremap <leader>cP "+P
vnoremap <leader>cP "+P

" Move selected blocks
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
vnoremap > >gv
vnoremap < <gv

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" Resize windows
nnoremap + :vertical resize +5<CR>
nnoremap _ :vertical resize -5<CR>
nnoremap = :resize +5<CR>
nnoremap - :resize -5<CR>

" Buffer navigation
nnoremap <leader>bn :bnext<CR>
nnoremap <C-n> :bnext<CR>
nnoremap <leader>bp :bprev<CR>
nnoremap <C-p> :bprev<CR>

" Close window/buffer
nnoremap <leader>cx :close<CR>
nnoremap <leader>bx :bdelete!<CR>

" Dismiss highlights
nnoremap <ESC><ESC> :noh<CR>

" File navigation
nnoremap <leader>e :Ex<CR>
nnoremap <leader>- :Ex<CR>
nnoremap <leader>= :Hexplore<CR>

" Toggle terminal
nnoremap <leader>; :terminal<CR>
nnoremap <C-;> :terminal<CR>
tnoremap <leader>; <ESC><CR>exit<CR>
tnoremap <C-;>; <ESC><CR>exit<CR>

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Highlight on yank
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup END

" vim: ft=vim ts=2 sts=2 sw=2 et ai
