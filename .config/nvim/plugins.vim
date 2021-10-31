" automatically install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'sainnhe/sonokai'                          " colourscheme

Plug 'itchyny/lightline.vim'                    " status line info
Plug 'itchyny/vim-gitbranch'                    " status line branch info
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'                         " fuzzy finder

Plug 'cohama/lexima.vim'                        " pair completion
Plug 'tpope/vim-surround'                       " easy surrounding of pairs
Plug 'tpope/vim-commentary'                     " easy commenting
Plug 'tpope/vim-sleuth'                         " indentation detection
Plug 'Yggdroot/indentLine'                      " display indentation levels
Plug 'mbbill/undotree'                          " undo history management
Plug 'junegunn/vim-peekaboo'                    " register viewer
Plug 'junegunn/vim-easy-align'                  " easy alignment
Plug 'pseewald/vim-anyfold'                     " generic folding
Plug 'unblevable/quick-scope'                   " easier motions
Plug 'machakann/vim-highlightedyank'            " highlight yanked text
Plug 'psliwka/vim-smoothie'                     " smooth scrolling
Plug 'szw/vim-maximizer'                        " windod toggling

Plug 'airblade/vim-gitgutter'                   " preview git changes
Plug 'samoshkin/vim-mergetool'                  " git mergetool
Plug 'APZelos/blamer.nvim'                      " git blame

Plug 'neoclide/coc.nvim', {'branch': 'release'} " intellisense (completion, linting etc)

Plug 'NoahTheDuke/vim-just'                     " Justfile syntax
Plug 'vim-python/python-syntax'                 " python syntax
Plug 'alvan/vim-closetag'                       " tag completion
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
" Plug 'bfrg/vim-cpp-modern'                      " c/c++ syntax
" Plug 'fatih/vim-go'                             " golang

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
let g:lightline.colorscheme = 'sonokai'

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
let $FZF_DEFAULT_COMMAND = "fd --type file --hidden --follow --exclude .git"
let $FZF_DEFAULT_OPTS = '--bind alt-a:select-all,alt-d:deselect-all'
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>g :Rg<CR>

  " don't search filenames with ripgrep
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

  " select and add results to quickfix list
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" indentLine
let g:indentLine_char = '│'
let g:indentLine_setConceal = 2
" default ''.
" n for Normal mode
" v for Visual mode
" i for Insert mode
" c for Command line editing, for 'incsearch'
let g:indentLine_concealcursor = ""
let g:indentLine_fileTypeExclude = ['json', 'haskell', 'markdown']

" undotree
nnoremap <silent> <leader>u :UndotreeToggle<CR>

" vim-peekaboo
let g:peekaboo_window = 'vert to 40new'

" easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

vmap <leader><bslash> :EasyAlign*<bar><Enter>

" vim-anyfold
autocmd Filetype * AnyFoldActivate
set foldlevel=99

" quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" highlightedyank
let g:highlightedyank_highlight_duration = 1000

" vim-maximizer
nnoremap <silent><leader>z :MaximizerToggle<CR>
vnoremap <silent><leader>z :MaximizerToggle<CR>gv

" vim-gitgutter
set updatetime=500
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed =  '.'
let g:gitgutter_sign_removed_first_line =  '˙'
let g:gitgutter_sign_modified_removed = '│'
let g:gitgutter_preview_win_floating = 0
nmap <silent> ghp :call TogglePreviewHunk()<CR>
nmap <silent> ghu <Plug>(GitGutterUndoHunk)
nmap <silent> ghs <Plug>(GitGutterStageHunk)

let g:lineNo=0
function! TogglePreviewHunk()
  if PreviewWindowOpened() && g:lineNo == line('.')
    pclose
  else
    silent exe "GitGutterPreviewHunk"
    let g:lineNo=line('.')
  endif
endfunction

function! PreviewWindowOpened()
  for nr in range(1, winnr('$'))
    if getwinvar(nr, "&pvw") == 1
      return 1
    endif
  endfor
  return 0
endfunction

" vim-mergetool
let g:mergetool_layout = 'rm'               " remote on left, optimistic merge on right
let g:mergetool_prefer_revision = 'local'   " optimistically accept local changes for merge
nmap <leader>mt <plug>(MergetoolToggle)

" blamer
nmap <silent> gb :BlamerToggle<CR>

" CoC configurations
" let g:coc_disable_startup_warning=1

set nobackup                " For servers with issues
set nowritebackup           " with backup files, see #649.
set shortmess+=c            " Don't pass messages to |ins-completion-menu|.

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
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
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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
command! -nargs=0 OImports :call CocAction('runCommand', 'editor.action.organizeImport')

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

" python-syntax
let g:python_highlight_all = 1
let g:python_highlight_file_headers_as_comments = 1
let g:python_highlight_space_errors = 0

" vim-closetag
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.xml,*.jsx,*.tsx"
let g:closetag_xhtml_filetypes = 'xml,xhtml,phtml,jsx,javascript.jsx,javascript.tsx,typescript.tsx,javascriptreact'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

" vim-jsx-pretty
let g:vim_jsx_pretty_highlight_close_tag = 1

" cpp-modern
let c_no_curly_error = 1

" vim-go
let g:go_def_mapping_enabled = 0
