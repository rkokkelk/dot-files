"Options
set hidden
set nowrap
set backspace=indent,eol,start
set autoindent
set copyindent
set number
set shiftround
set showmatch
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch
set history=1000
set undolevels=1000
set noerrorbells
set nobackup
set noswapfile
set pastetoggle=<F2>
set ofu=syntaxcomplete#Complete

" Change look and feel
syntax enable
set t_Co=256
set background=dark
set fillchars+=vert:\ 

"" Map leader to ,
let mapleader=','

" Automatically source vimrc on save.
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

" Plugins, done by plug
call plug#begin()

" Power line module inc themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Configure powerline
let g:airline_powerline_fonts = 1
let g:airline_theme='angr'

Plug 'tpope/vim-sensible'
set laststatus=2

" Support for scala
Plug 'derekwyatt/vim-scala'

" Display filestructure
" 1) :Nerdtree
Plug 'scrooloose/nerdtree'

" Asynchrous syntax verification
Plug 'w0rp/ale'
" ALE Airline enabling
let g:airline#extensions#ale#enabled = 1
" Set autocompletion to include ALE
let g:ale_completion_enabled = 1
" Configure lints
let g:ale_python_pylint_options = '-d C0103,C0111,C0301,R0914,W0603'
let g:ale_python_pylint_change_directory=0

" Syntax and style checker for Python
Plug 'nvie/vim-flake8'

" Git support
" 1) :Gdiff master
Plug 'tpope/vim-fugitive'
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gd :Gvdiff<CR>

" Git gutter
Plug 'airblade/vim-gitgutter'

" CtrlP, fuzzy search tags/buffers/etc
" 1) :Files, :Commits, :AG
Plug 'junegunn/fzf.vim'
nnoremap <c-p> :Files<CR>
nnoremap <c-l> :Ag<CR>

" Automatic indentation of Python
Plug 'vim-scripts/indentpython.vim'

" Formatting code
" 1) :Neoformat jsbeautify
" 2) :Neoformat! python
Plug 'sbdchd/neoformat'

" Autocomplete plugin
Plug 'ajh17/VimCompletesMe'

call plug#end()

"Tab settings
set expandtab
set tabstop=2     " a hard TAB displays as 4 columns
set shiftwidth=2  " operation >> indents 4 columns; << unindents 4 columns
set softtabstop=2 " insert/delete 4 spaces when hitting a TAB/BACKSPACE

"Filetype plugin
filetype plugin indent on
autocmd filetype python set list
autocmd filetype python set listchars=tab:>.,trail:.,extends:#,nbsp:.

"Custom file extensions
au BufNewFile,BufRead *.jsm set filetype=javascript

" Map keys
" Disable the requirement of shift
nnoremap ; :
" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" Change default behavior to 'natural' next line jump
nnoremap j gj
nnoremap k gk
" Clear search
nmap <silent> ,/ :nohlsearch<CR>
