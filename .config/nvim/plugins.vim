" automatically install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'hillaryychan/oceanic-next'                " colourscheme
" Plug 'glepnir/zephyr-nvim'

Plug 'rbgrouleff/bclose.vim'                    " dependency for ranger
Plug 'francoiscabrol/ranger.vim'                " file exploring
Plug 'itchyny/lightline.vim'                    " status line info
Plug 'itchyny/vim-gitbranch'                    " status line branch info
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'cohama/lexima.vim'                        " pair completion
Plug 'tpope/vim-surround'                       " easy surrounding of pairs
Plug 'tpope/vim-commentary'                     " easy commenting
Plug 'tpope/vim-sleuth'                         " indentation detection
Plug 'Yggdroot/indentLine'                      " display indentation levels
Plug 'lukas-reineke/indent-blankline.nvim'      " indentation for blank lines
Plug 'junegunn/vim-easy-align'                  " easy alignment
Plug 'junegunn/vim-peekaboo'                    " register viewer
Plug 'pseewald/vim-anyfold'                     " generic folding
Plug 'machakann/vim-highlightedyank'            " highlight yanked text
Plug 'psliwka/vim-smoothie'                     " smooth scrolling
Plug 'szw/vim-maximizer'                        " window toggling

Plug 'airblade/vim-gitgutter'                   " preview git changes
Plug 'samoshkin/vim-mergetool'                  " git mergetool
Plug 'APZelos/blamer.nvim'                      " git blame

Plug 'neoclide/coc.nvim', {'branch': 'release'} " intellisense (completion, linting etc)

Plug 'puremourning/vimspector'                  " debugging

Plug 'bfrg/vim-cpp-modern'                      " c/c++ syntax
Plug 'neovimhaskell/haskell-vim'                " haskell syntax
Plug 'vim-python/python-syntax'                 " python syntax
Plug 'alvan/vim-closetag'                       " tag completion

call plug#end()

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

" ranger
let g:NERDTreeHijackNetrw = 0   " add this line if you use NERDTree
let g:ranger_replace_netrw = 1  " open ranger when vim open a directory
let g:ranger_map_keys = 0       " disable <leader>f mapping
map <leader>r :Ranger<CR>


" lightline status
let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ] ],
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ],
    \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'LightlineGitbranch',
    \   'cocstatus': 'coc#status',
    \   'fileformat': 'LightlineFileformat',
    \   'fileencoding': 'LightlineFileencoding',
    \   'filetype': 'LightlineFiletype'
    \ },
    \ }

  " collapse long filenames
let g:lightline.component = { 'filename': '%<%f'}

  " hide/only show 20 chars of git branch name
function! LightlineGitbranch()
  if exists('*gitbranch#name') && winwidth(0) > 70
    let branch = gitbranch#name()
    if len(branch) <= 20
      return branch
    endif
    return branch[:10] . '..' . branch[(len(branch)-7):]
  endif
  return ''
endfunction

  " hide fileformat, fileencoding, filetype
function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

" fzf
let $FZF_DEFAULT_COMMAND = "rg --files --hidden --glob '!.git'"
let g:fzf_command_prefix = 'Fzf'
nnoremap <silent> <leader>f :FzfFiles<CR>
nnoremap <silent> <leader>b :FzfBuffers<CR>
nnoremap <silent> <leader>g :FzfRg<CR>

" indentLine
let g:indentLine_char = '│'
let g:indentLine_setConceal = 2
" default ''.
" n for Normal mode
" v for Visual mode
" i for Insert mode
" c for Command line editing, for 'incsearch'
let g:indentLine_concealcursor = ""
let g:indentLine_fileTypeExclude = ['json', 'haskell']

" easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" vim-peekaboo
let g:peekaboo_window = 'vert to 40new'

" vim-anyfold
autocmd Filetype * AnyFoldActivate
set foldlevel=99

" highlightedyank
let g:highlightedyank_highlight_duration = 500

" vim-maximizer
nnoremap <silent><leader>z :MaximizerToggle<CR>
vnoremap <silent><leader>z :MaximizerToggle<CR>gv
inoremap <silent><leader>z <C-o>:MaximizerToggle<CR>

" vim-gitgutter
set updatetime=500
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed =  '.'
let g:gitgutter_sign_removed_first_line =  '˙'
let g:gitgutter_sign_modified_removed = '│'
let g:gitgutter_preview_win_floating = 0
nmap <silent> cd <Plug>(GitGutterPreviewHunk)
nmap <silent> ce :pclose<CR>

" vim-mergetool
let g:mergetool_layout = 'rm'               " remote on left, optimistic merge on right
let g:mergetool_prefer_revision = 'local'   " optimistically accept local changes for merge
nmap <leader>mt <plug>(MergetoolToggle)

" CoC configurations
" let g:coc_disable_startup_warning=1

set nobackup                " For servers with issues
set nowritebackup           " with backup files, see #649.
set shortmess+=c            " Don't pass messages to |ins-completion-menu|.

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[d` and `]d` to navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)
"
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>ca  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>cd  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>ce  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>cc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>co  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>cs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>cj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>ck  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>cl  :<C-u>CocListResume<CR>

" vimspector
let g:vimspector_enable_mappings = 'HUMAN'
nnoremap <leader>db :call vimspector#Launch()<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>

" cpp-modern
let c_no_curly_error = 1

" python-syntax
let g:python_highlight_all = 1
let g:python_highlight_file_headers_as_comments = 1
let g:python_highlight_space_errors = 0

" vim-closetag
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.xml"
let g:closetag_xhtml_filetypes = 'xml,xhtml,phtml'
let g:closetag_emptyTags_caseSensitive = 1
