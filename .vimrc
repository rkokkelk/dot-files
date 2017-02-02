"Needed for pathogen plugin
call pathogen#infect()
call pathogen#helptags()

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

"Tab settings
set expandtab
set tabstop=2     " a hard TAB displays as 4 columns
set shiftwidth=2  " operation >> indents 4 columns; << unindents 4 columns
set softtabstop=2 " insert/delete 4 spaces when hitting a TAB/BACKSPACE

"Filetype plugin
filetype plugin indent on
autocmd filetype python set list
autocmd fileType python set tabstop=4|set shiftwidth=4|set expandtab| set autoindent
autocmd filetype python set listchars=tab:>.,trail:.,extends:#,nbsp:.

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
