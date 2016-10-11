
" Remove all autocommands, so that they are not compounded
" but defined anew:
autocmd!

" Basic options ----------------------------------------------------------- {{{
colorscheme morning
syntax on
set filetype=on
set tabstop=3
set shiftwidth=3
set expandtab
set laststatus=2
set nojoinspaces
set noinsertmode
set nocompatible
set nostartofline
set nomodeline modelines=0
set autoindent
set showmode
set showcmd
set hidden
set noerrorbells
set visualbell
set t_vb="
set ttyfast
set ruler
set backspace=2
set history=1000
set undofile
set undoreload=10000
set list
set listchars=tab:>\ 
"set listchars+=eol:
"set listchars+=extends:^
"set listchars+=precedes:¨
set lazyredraw
set matchtime=2
set showbreak=+
set splitbelow
set splitright
set autowrite
set autoread
set shiftround
set title
set linebreak
set notimeout
set ttimeout
set ttimeoutlen=10
set complete=.,w,b,u,t
set completeopt=preview
set formatoptions=qrn1
set wrapmargin=0
set wrapscan " ?
set nowrap


" Save when losing focus
au FocusLost * :silent! wall

" Resize splits when the window is resized
au VimResized * :wincmd =

let mapleader = ","
let maplocalleader = "\\"

" Show cursorline in normal mode.
set cursorline
augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

" Show trailing ws in insertmode
augroup trailing 
    au!
    au InsertEnter * :set listchars-=trail:´
    au InsertLeave * :set listchars+=trail:´
augroup END

set backup
set noswapfile
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

set guicursor=n-c:block-Cursor-blinkon0
set guicursor+=v:block-vCursor-blinkon0
set guicursor+=i-ci:ver20-iCursor
set guifont=Courier\ 16
set encoding=utf-8
set t_Co=256

highlight ColorColumn term= ctermbg=224 guibg=Red
hi CursorLine guibg=DarkGrey gui=underline,italic
set textwidth=75
call matchadd('ColorColumn', '\%76v', 100)


