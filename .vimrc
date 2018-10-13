"Needed for pathogen plugin
"call pathogen#infect()
"call pathogen#helptags()

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

syntax enable
set t_Co=256
set background=dark
colors pablo


" Plugins, done by plug
call plug#begin()

Plug 'wsdjeg/FlyGrep.vim'
Plug 'tpope/vim-sensible'
Plug 'derekwyatt/vim-scala'
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'nvie/vim-flake8'
Plug 'tpope/vim-fugitive'
Plug 'Lokaltog/powerline'
Plug 'vim-scripts/indentpython.vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

call plug#end()

" Plugin configurations
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"Tab settings
set expandtab
set tabstop=2     " a hard TAB displays as 4 columns
set shiftwidth=2  " operation >> indents 4 columns; << unindents 4 columns
set softtabstop=2 " insert/delete 4 spaces when hitting a TAB/BACKSPACE

"Filetype plugin
filetype plugin indent on
autocmd filetype python set list
autocmd filetype python set listchars=tab:>.,trail:.,extends:#,nbsp:.
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

"Custom file extensions
au BufNewFile,BufRead *.jsm set filetype=javascript

"Map keys
nnoremap ; :
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

map N :NERDTreeToggle<CR>
map T :TagbarToggle<CR> 

nnoremap <Space>s/ :FlyGrep<cr>

augroup LargeFile
        let g:large_file = 10485760 " 10MB

        " Set options:
        "   eventignore+=FileType (no syntax highlighting etc
        "   assumes FileType always on)
        "   noswapfile (save copy of file)
        "   bufhidden=unload (save memory when other file is viewed)
        "   buftype=nowritefile (is read-only)
        "   undolevels=-1 (no undo possible)
        au BufReadPre *
                \ let f=expand("<afile>") |
                \ if getfsize(f) > g:large_file |
                        \ set eventignore+=FileType |
                        \ setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 |
                \ else |
                        \ set eventignore-=FileType |
                \ endif
augroup END
