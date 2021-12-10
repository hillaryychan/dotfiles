" automatically install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'sainnhe/sonokai'                          " colourscheme

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'preservim/nerdtree'                       " file explorer
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'            " fuzzy finder
Plug 'nvim-lualine/lualine.nvim'                " status line

Plug 'cohama/lexima.vim'                        " pair completion
Plug 'tpope/vim-surround'                       " easy surrounding of pairs
Plug 'tpope/vim-commentary'                     " easy commenting
Plug 'lukas-reineke/indent-blankline.nvim'      " display indentation levels
Plug 'junegunn/vim-peekaboo'                    " register viewer
Plug 'junegunn/vim-easy-align'                  " easy alignment
Plug 'unblevable/quick-scope'                   " easier motions
Plug 'machakann/vim-highlightedyank'            " highlight yanked text
Plug 'psliwka/vim-smoothie'                     " smooth scrolling
Plug 'milkypostman/vim-togglelist'              " toggling lists
Plug 'qpkorr/vim-bufkill'                       " buffer management

Plug 'airblade/vim-gitgutter'                   " preview git changes
Plug 'samoshkin/vim-mergetool'                  " git mergetool
Plug 'APZelos/blamer.nvim'                      " git blame

Plug 'neoclide/coc.nvim', {'branch': 'release'} " intellisense (completion, linting etc)

Plug 'NoahTheDuke/vim-just'                     " Justfile syntax
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'alvan/vim-closetag'                       " tag completion

call plug#end()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  }
}
EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99 " open all folds

" lualine
lua <<EOF
require'lualine'.setup {
  options = {
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  }
}
EOF

" nerdtree
let g:NERDTreeShowHidden=1
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTreeFind<CR>

" telescope.nvim
nnoremap <leader>f <cmd>Telescope find_files<CR>
nnoremap <leader>g <cmd>Telescope live_grep<CR>
nnoremap <leader>b <cmd>Telescope buffers<CR>

lua << EOF
require('telescope').setup{
  defaults = {
    mappings = {
      n = {
    	['<c-d>'] = require('telescope.actions').delete_buffer,
        ['<c-u>'] = false
      },
      i = {
        ['<c-d>'] = require('telescope.actions').delete_buffer,
        ['<c-u>'] = false
      }
    }
  },
}
EOF

" vim-peekaboo
let g:peekaboo_window = 'vert to 40new'

" easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

vmap <leader><bslash> :EasyAlign*<bar><Enter>

" quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" highlightedyank
let g:highlightedyank_highlight_duration = 1000

" togglelist
nnoremap <silent> <leader>q :call ToggleQuickfixList()<CR>
nnoremap <silent> <leader>l :call ToggleLocationList()<CR>

" vim-bufkill
nnoremap <leader>d :BD<CR>

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

" markdown-preview.nvim
nmap <leader>mp <Plug>MarkdownPreviewToggle

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
