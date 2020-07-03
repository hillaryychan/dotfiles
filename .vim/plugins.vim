" Automatically install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'hillaryychan/oceanic-next'                " colourscheme

Plug 'itchyny/lightline.vim'                    " status line info
Plug 'itchyny/vim-gitbranch'                    " status line branch info
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'cohama/lexima.vim'                        " pair completion
Plug 'tpope/vim-surround'                       " easy surrounding of pairs
Plug 'tpope/vim-commentary'                     " easy commenting
Plug 'Yggdroot/indentLine'                      " display indentation levels
Plug 'airblade/vim-gitgutter'                   " preview git changes
Plug 'psliwka/vim-smoothie'                     " smooth scrolling

call plug#end()

" netrw file browser
" Per default, netrw leaves unmodified buffers open. This autocommand
" deletes netrw's buffer once it's hidden (using ':q', for example)
autocmd FileType netrw setl bufhidden=delete

let g:netrw_winsize = -28               " absolute width of netrw window
let g:netrw_banner = 0                  " do not display banner
let g:netrw_sort_sequence = '[\/]$,*'   " sort directories on the top, files below
let g:netrw_altv = 1                    " set vsplit to right
let g:netrw_hide=1                      " don't show hidden file (toggle with gh)
let ghregex='\(^\|\s\s\)\zs\.\S\+,^\.\.'
let g:netrw_list_hide=ghregex

nnoremap <silent> <leader>\ :call ToggleNetrw()<CR>
let g:NetrwIsOpen=0
function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction

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

" fzf
let g:fzf_command_prefix = 'Fzf'

" indentLine
let g:indentLine_char = '│'
let g:indentLine_setConceal = 2
" default ''.
" n for Normal mode
" v for Visual mode
" i for Insert mode
" c for Command line editing, for 'incsearch'
let g:indentLine_concealcursor = ""
let g:indentLine_fileTypeExclude = ['json']

" vim-gitgutter
set updatetime=250
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed =  '.'
let g:gitgutter_sign_removed_first_line =  '˙'
let g:gitgutter_sign_modified_removed = '│'
nmap <leader>cd <Plug>(GitGutterPreviewHunk)
nmap <leader>ce :pclose<CR>
