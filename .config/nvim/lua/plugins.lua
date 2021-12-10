-- automatically install vim-plug
vim.api.nvim_exec([[
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
]], true)

local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'sainnhe/sonokai'                          -- colourscheme

Plug('nvim-treesitter/nvim-treesitter', {['do'] = vim.fn['TSUpdate']})

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'            -- fuzzy finder
Plug 'nvim-lualine/lualine.nvim'                -- status line
Plug 'preservim/nerdtree'                       -- file explorer

Plug 'cohama/lexima.vim'                        -- pair completion
Plug 'tpope/vim-surround'                       -- easy surrounding of pairs
Plug 'tpope/vim-commentary'                     -- easy commenting
Plug 'lukas-reineke/indent-blankline.nvim'      -- display indentation levels
Plug 'junegunn/vim-peekaboo'                    -- register viewer
Plug 'junegunn/vim-easy-align'                  -- easy alignment
Plug 'unblevable/quick-scope'                   -- easier motions
Plug 'machakann/vim-highlightedyank'            -- highlight yanked text
Plug 'psliwka/vim-smoothie'                     -- smooth scrolling
Plug 'milkypostman/vim-togglelist'              -- toggling lists
Plug 'qpkorr/vim-bufkill'                       -- buffer management

Plug 'airblade/vim-gitgutter'                   -- preview git changes
Plug 'samoshkin/vim-mergetool'                  -- git mergetool
Plug 'APZelos/blamer.nvim'                      -- git blame

vim.call('plug#end')

-- nvim-treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  }
}

vim.api.nvim_set_option('foldmethod', 'expr')
vim.api.nvim_set_option('foldexpr', 'nvim_treesitter#foldexpr()')
vim.api.nvim_set_option('foldlevelstart', 99)

-- telescope
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

vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })

-- lualine
require('lualine').setup {
  options = {
    icons_enabled = false,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  }
}

-- nerdtree
vim.g.NERDTreeShowHidden = true
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>n', ':NERDTreeFind<CR>', { noremap = true })
 
-- vim-peekaboo
vim.g.peekaboo_window = 'vert to 40new'
 
-- easy-align
-- * start interactive EasyAlign in visual mode (e.g. vipga)
vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', {})
-- * Start interactive EasyAlign for a motion/text object (e.g. gaip)
vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', {})

-- vmap <leader><bslash> :EasyAlign*<bar><Enter>
vim.api.nvim_set_keymap('v', '<leader><bslash>', ':EasyAlign*<bar><CR>', {})

-- quick-scope
vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}

-- highlightedyank
vim.g.highlightedyank_highlight_duration = 1000

-- togglelist
-- * quickfix mappings
vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':call ToggleQuickfixList()<CR>', { noremap = true, silent =  true })
vim.api.nvim_set_keymap('n', '[q', ':cprevious<CR>', { noremap = true, silent =  true })
vim.api.nvim_set_keymap('n', ']q', ':cnext<CR>', { noremap = true, silent =  true })
vim.api.nvim_set_keymap('n', '[Q', ':cfirst<CR>', { noremap = true, silent =  true })
vim.api.nvim_set_keymap('n', ']Q', ':clast<CR>', { noremap = true, silent =  true })

-- * location list mappings
vim.api.nvim_set_keymap('n', '<leader>l', ':call ToggleLocationList()<CR>', { noremap = true, silent =  true })
vim.api.nvim_set_keymap('n', '[l', ':lprevious<CR>zmzv', { noremap = true, silent =  true })
vim.api.nvim_set_keymap('n', ']l', ':lnext<CR>zmzv', { noremap = true, silent =  true })
vim.api.nvim_set_keymap('n', '[L', ':lfirst<CR>', { noremap = true, silent =  true })
vim.api.nvim_set_keymap('n', ']L', ':llast<CR>', { noremap = true, silent =  true })

-- vim-bufkill
-- * buffer mappings
vim.api.nvim_set_keymap('n', '[b', ':bprevious<CR>', { noremap = true, silent =  true })
vim.api.nvim_set_keymap('n', ']b', ':bnext<CR>', { noremap = true, silent =  true })
vim.api.nvim_set_keymap('n', '[B', ':bfirst<CR>', { noremap = true, silent =  true })
vim.api.nvim_set_keymap('n', ']B', ':blast<CR>', { noremap = true, silent =  true })
vim.api.nvim_set_keymap('n', '<leader>d', ':BD<CR>', { noremap = true, silent =  true })
vim.api.nvim_set_keymap('n', '<leader>D', ':bufdo bd<CR>', { noremap = true, silent =  true })

-- vim-gitgutter
vim.opt.updatetime = 500
vim.g.gitgutter_sign_added = '│'
vim.g.gitgutter_sign_modified = '│'
vim.g.gitgutter_sign_removed =  '.'
vim.g.gitgutter_sign_removed_first_line =  '˙'
vim.g.gitgutter_sign_modified_removed = '│'
vim.g.gitgutter_preview_win_floating = 0
vim.api.nvim_set_keymap('n', 'ghp', ':call TogglePreviewHunk()<CR>', { silent =  true })
vim.api.nvim_set_keymap('n', 'ghu', '<Plug>(GitGutterUndoHunk)', { silent =  true })
vim.api.nvim_set_keymap('n', 'ghs', '<Plug>(GitGutterStageHunk)', { silent =  true })

vim.api.nvim_exec([[
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
]], false)

-- vim-mergetool
vim.g.mergetool_layout = 'rm'               -- remote on left, optimistic merge on right
vim.g.mergetool_prefer_revision = 'local'   -- optimistically accept local changes for merge

-- blamer
vim.api.nvim_set_keymap('n', 'gb', ':BlamerToggle<CR>', { silent =  true })
