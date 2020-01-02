" General
set nocompatible    " ensure config is not used with Vi
filetype off
set hidden          " reuse same window and switch from an unsaved buffer 
                    " without saving it first. Also keep undo history for 
                    " multiple files
set modelines=0     " security
set visualbell      " use visual bell instead of beeping when there is an error
set mouse+=a         " enable mouse for all modes
set clipboard^=unnamedplus " enable copy pasting between clipboard registers

" Encoding
set encoding=utf-8
scriptencoding utf-8

" Colours
syntax enable
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
if (has("termguicolors"))
    set termguicolors
endif
set t_Co=256
colorscheme OceanicNext

" Enable undercurl
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"

" Indentation
set expandtab       " tab expands to spaces
set tabstop     =4  " no. of visual spaces per tab
set softtabstop =4  " no. of spaces per tab in edit
set shiftwidth  =4  " no. of spaces to use per indent
set smarttab        " use shift width for indents instead of tab stop
set smartindent     " indent based on filetype
filetype indent plugin on       " loads filetype specific indentation settings
set autoindent      " keep same indent if no filetype-specific indenting enabled
set backspace=indent,eol,start " backspacing over everything in insert mode

" UI configurations
set noshowmode      " don't show working mode
set ruler           " show file stats
set number          " show line numbers
set relativenumber  " show relative line numbers
set path+=**        " provides recursive file path
set wildmenu        " visual autocomplete for command-line
set showmatch       " highlight matching parenthesis
set showcmd         " display incomplete commands
set cursorline      " highlight the cursor line
set colorcolumn=80  " colour the 80th column
set laststatus=2    " always display status line
set list            " display hidden characters in vim
set listchars=tab:│\ ,trail:·,nbsp:⎵    " display white space as chars

" Searching
set hlsearch        " highlight searches
set incsearch       " show partial matches for a search
set ignorecase      " use case insensitive search except when using capital letters
set smartcase       " an uppercase letter will enable case sensitivity

set scrolloff=3
set matchpairs+=<:> " use % to jump between pairs

" Splitting
set splitright      " puts new vsplit windows to the right of the current
set splitbelow      " puts new split windows to bottom of current

" Mappings
inoremap jk <esc>
inoremap JK <esc>
vnoremap jk <esc>
vnoremap JK <esc>

nnoremap <space><space> :noh<return>

:command WQ wq
:command Wq wq
:command W w
:command Q q

" File Browsing with netrw
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_liststyle=3     " tree view

" PLUGIN CONFIGURATIONS
" spell-underlining
let g:spell_under='OceanicNext'

" lightline status
let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'gitbranch#name'
    \ },
    \ }

" indentLine 
let g:indentLine_char = '│'

