" Load plugins
if filereadable(expand('~/.vim/plugins.vim'))
    source ~/.vim/plugins.vim
endif

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
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
if (has("termguicolors"))
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
set t_Co=256
colorscheme OceanicNext

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
set noshowmode              " don't show working mode
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
set colorcolumn=80          " colour the 80th column
set laststatus=2            " always display status line
set list                    " display hidden characters in vim
                            " display white space as chars
set listchars=tab:→\ ,extends:›,precedes:‹,trail:·,nbsp:⎵

" Searching
set hlsearch                " highlight searches
set incsearch               " show partial matches for a search
set ignorecase              " use case insensitive search except when using capital letters
set smartcase               " an uppercase letter will enable case sensitivity

set scrolloff=3
set matchpairs+=<:>         " use % to jump between pairs

" Splitting
set splitright              " puts new vsplit windows to the right of the current
set splitbelow              " puts new split windows to bottom of current

" Folding
set foldmethod=syntax       " fold based on syntax highlighting
set foldcolumn=0            " disable visual representation of fold levels
autocmd BufWinEnter * silent! :%foldopen!   " have all folds open by default
let g:markdown_folding=1    " enable folding for markdown filetype

autocmd VimEnter * if &diff | execute 'windo set wrap' | endif
autocmd InsertEnter * set norelativenumber
autocmd InsertLeave * set relativenumber

" Mappings
" case-insensitive commands
inoremap jk <esc>
inoremap JK <esc>
vnoremap jk <esc>
vnoremap JK <esc>

nnoremap <space><space> :noh<return>

" toggle spell check
noremap <F12> :setlocal spell! spelllang=en_au<cr>
inoremap <F12> <c-\><c-o>:setlocal spell! spelllang=en_au<cr>

" split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

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
nnoremap <silent> <leader>b :ls<CR>
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
