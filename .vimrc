let mapleader = " "

" General
set nocompatible            " ensure config is not used with Vi
filetype off
set hidden                  " reuse same window and switch from an unsaved buffer 
                            " without saving it first. Also keep undo history for 
                            " multiple files
set modelines=0             " security
set visualbell              " use visual bell instead of beeping when there is an error
set mouse+=a                " enable mouse for all modes
set clipboard^=unnamedplus  " enable copy pasting between clipboard registers

" Encoding
set encoding=utf-8
scriptencoding utf-8

" Colours
syntax enable
if (has("termguicolors"))
    set termguicolors
    " for tmux
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Indentation
set expandtab               " tab expands to spaces
set tabstop     =4          " no. of visual spaces per tab
set softtabstop =4          " no. of spaces per tab in edit
set shiftwidth  =4          " no. of spaces to use per indent
set smarttab                " use shift width for indents instead of tab stop
set smartindent             " indent based on filetype
filetype indent plugin on   " loads filetype specific indentation settings
set autoindent              " keep same indent if no filetype-specific indenting enabled
set backspace=indent,eol,start " backspacing over everything in insert mode

" UI configurations
set showmode                " show working mode
set ruler                   " show file stats
set number                  " show line numbers
set relativenumber          " show relative line numbers
set nowrap                  " don't wrap lines
set path+=**                " provides recursive file path
set wildmenu                " visual autocomplete for command-line
set wildignorecase          " ignore case in commandline filename completion
set showmatch               " highlight matching parenthesis
set showcmd                 " display incomplete commands
set cursorline              " highlight the cursor line
set colorcolumn=80,100,120  " colour the 80th column
set laststatus=2            " always display status line
set list                    " display hidden characters in vim
                            " display white space as chars
set listchars=space:·,tab:→\ ,extends:›,precedes:‹,trail:·,nbsp:⎵

" Searching
set hlsearch                " highlight searches
set incsearch               " show partial matches for a search
set ignorecase              " use case insensitive search except when using capital letters
set smartcase               " an uppercase letter will enable case sensitivity

set scrolloff=3
set sidescrolloff=5
set matchpairs+=<:>         " use % to jump between pairs

" Splitting
set splitright              " puts new vsplit windows to the right of the current
set splitbelow              " puts new split windows to bottom of current

" wrap lines for vimdiff
autocmd VimEnter * if &diff | execute 'windo set wrap' | endif

" Mappings =====================================================================
" saving buffers
nnoremap <leader>w :w<CR>

" escape mappings
inoremap jk <esc>
vnoremap jk <esc>

" clear highlighting
nnoremap <leader><space> :noh<CR>

" make Y consistent with C and D
nnoremap Y y$

" center highlighted search results
cnoremap <expr> <CR> (getcmdtype() == '?' \|\| getcmdtype() == '/') ? '<CR>zz' : '<CR>'
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

" toggle spell check
noremap <F12> :setlocal spell! spelllang=en_au<cr>
inoremap <F12> <c-\><c-o>:setlocal spell! spelllang=en_au<cr>

" split navigation
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

" quickfix mappings
nnoremap <silent> <leader>q :cw<CR>
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [Q :cfirst<CR>
nnoremap <silent> ]Q :clast<CR>

" location list mappings
nnoremap <silent> <leader>l :cw<CR> :lw<CR>
nnoremap <silent> [l :lprevious<CR>zmzv
nnoremap <silent> ]l :lnext<CR>zmzv
nnoremap <silent> [L :lfirst<CR>
nnoremap <silent> ]L :llast<CR>

" buffer mappings
nnoremap <silent> <leader>b :buffers<CR>
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
