let mapleader = " "

" Load plugins
if filereadable(expand('~/.config/nvim/plugins.vim'))
    source ~/.config/nvim/plugins.vim
endif

" General
set hidden                  " reuse same window and switch from an unsaved buffer
                            " without saving it first. Also keep undo history for
                            " multiple files
set modelines=0             " security
set visualbell              " use visual bell instead of beeping when there is an error
set mouse+=a                " enable mouse for all modes
set clipboard^=unnamedplus  " enable copy pasting between clipboard registers

" Colours
if (has('termguicolors'))
    set termguicolors
endif
let g:sonokai_style = 'default'
let g:sonokai_enable_italic = 1
colorscheme sonokai

" Indentation
set expandtab               " tab expands to spaces
set tabstop     =4          " no. of visual spaces per tab
set softtabstop =4          " no. of spaces per tab in edit
set shiftwidth  =4          " no. of spaces to use per indent
set smartindent             " indent based on filetype

" UI configurations
set noshowmode              " don't show working mode
set number                  " show line numbers
set relativenumber          " show relative line numbers
set nowrap                  " don't wrap lines
set path+=**                " provides recursive file path
set wildignorecase          " ignore case in commandline filename completion
set showmatch               " highlight matching parenthesis
set cursorline              " highlight the cursor line
set colorcolumn=80,100,120  " colour the 80th, 100th, 120th column
set list                    " display hidden characters in vim
set listchars=tab:→\ ,extends:›,precedes:‹,trail:·,nbsp:⎵
set inccommand=nosplit      " show effects of a command incrementally

" Searching
set ignorecase              " use case insensitive search except when using capital letters
set smartcase               " an uppercase letter will enable case sensitivity

set scrolloff=3             " vertical scroll padding
set sidescrolloff=5         " horizontal scroll padding
set matchpairs+=<:>         " use % to jump between pairs

" Splitting
set splitright              " puts new vsplit windows to the right of the current
set splitbelow              " puts new split windows to bottom of current

" wrap lines for vimdiff
autocmd VimEnter * if &diff | execute 'windo set wrap' | endif

" case-insensitive command line
augroup dynamic_smartcase
  autocmd!
  autocmd CmdLineEnter : set nosmartcase
  autocmd CmdLineLeave : set smartcase
augroup END

" Mappings
nnoremap <leader>w :w<CR>

" case-insensitive commands
inoremap jk <esc>
inoremap JK <esc>
vnoremap jk <esc>
vnoremap JK <esc>

" clear highlighting
nnoremap <leader><space> :noh<CR>

" make Y consistent with C and D
nnoremap Y y$

" center highlighted search results
cnoremap <expr> <CR> getcmdtype() =~ '[/?]' ? '<CR>zz' : '<CR>'
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
