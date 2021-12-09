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
if (has("termguicolors"))
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
                            " display white space as chars
set listchars=tab:→\ ,extends:›,precedes:‹,trail:·,nbsp:⎵
set inccommand=nosplit      " show effects of a command incrementally

" Searching
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

" quickfix mappings
nnoremap <silent> <leader>q :cw<CR>
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [Q :cfirst<CR>
nnoremap <silent> ]Q :clast<CR>

" location list mappings
nnoremap <silent> <leader>l :lw<CR>
nnoremap <silent> [l :lprevious<CR>zmzv
nnoremap <silent> ]l :lnext<CR>zmzv
nnoremap <silent> [L :lfirst<CR>
nnoremap <silent> ]L :llast<CR>

" buffer mappings
" <leader>b mapped to :Buffers from fzf
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
nnoremap <silent> <leader>D :bufdo bd<CR>

augroup dynamic_smartcase
  autocmd!
  autocmd CmdLineEnter : set nosmartcase
  autocmd CmdLineLeave : set smartcase
augroup END

" netrw file browser
" Per default, netrw leaves unmodified buffers open. This autocommand
" deletes netrw's buffer once it's hidden (using ':q', for example)
autocmd FileType netrw setl bufhidden=delete

let g:netrw_winsize = -40               " absolute width of netrw window
let g:netrw_banner = 0                  " do not display banner
let g:netrw_sort_sequence = '[\/]$,*'   " sort directories on the top, files below
let g:netrw_altv = 1                    " set vsplit to right
let g:netrw_hide=1                      " don't show hidden file (toggle with gh)
let ghregex='\(^\|\s\s\)\zs\.\S\+,^\.\.'
let g:netrw_list_hide=ghregex

