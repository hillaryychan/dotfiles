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
"set nowrap          " don't wrap lines
set path+=**        " provides recursive file path
set wildmenu        " visual autocomplete for command-line
set showmatch       " highlight matching parenthesis
set showcmd         " display incomplete commands
set cursorline      " highlight the cursor line
set colorcolumn=80  " colour the 80th column
set laststatus=2    " always display status line
set list            " display hidden characters in vim
                    " display white space as chars
set listchars=tab:→\ ,space:·,extends:›,precedes:‹,trail:·,nbsp:⎵

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

noremap <F12> :setlocal spell! spelllang=en_au<cr>
inoremap <F12> <c-\><c-o>:setlocal spell! spelllang=en_au<cr>

:command WQ wq
:command Wq wq
:command W w
:command Q q

" PLUGIN CONFIGURATIONS
" File Browsing with netrw
" Per default, netrw leaves unmodified buffers open. This autocommand
" deletes netrw's buffer once it's hidden (using ':q', for example)
autocmd FileType netrw setl bufhidden=delete

let g:netrw_liststyle=3     " tree view
let g:netrw_preview=1       " preview in vertical split
let g:netrw_hide=1          " don't show hidden file (toggle with gh)
let ghregex='\(^\|\s\s\)\zs\.\S\+,^\.\.'
let g:netrw_list_hide=ghregex

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

