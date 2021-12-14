local utils = require('utils')

-- automatically install vim-plug
vim.api.nvim_exec(
  [[
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
]],
  true
)

local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

Plug('sainnhe/sonokai')                     -- colourscheme

Plug('nvim-treesitter/nvim-treesitter', { ['do'] = vim.fn['TSUpdate'] })
Plug('hrsh7th/nvim-cmp')                    -- autocompletion
Plug('hrsh7th/cmp-nvim-lsp')                -- LSP source for nvim-cmp
Plug('hrsh7th/cmp-buffer')                  -- buffer source for nvim-cmp
Plug('hrsh7th/cmp-path')                    -- filsystem source for nvim-cmp
Plug('hrsh7th/cmp-cmdline')                 -- vim cmdline source for nvim-cmp
Plug('neovim/nvim-lspconfig')               -- intellisense

Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim')       -- fuzzy finder
Plug('nvim-lualine/lualine.nvim')           -- status line
Plug('preservim/nerdtree')                  -- file explorer

Plug('cohama/lexima.vim')                   -- pair completion
Plug('tpope/vim-surround')                  -- easy surrounding of pairs
Plug('tpope/vim-commentary')                -- easy commenting
Plug('tpope/vim-sleuth')                    -- indentation detection
Plug('lukas-reineke/indent-blankline.nvim') -- display indentation levels
Plug('junegunn/vim-peekaboo')               -- register viewer
Plug('junegunn/vim-easy-align')             -- easy alignment
Plug('unblevable/quick-scope')              -- easier motions
Plug('machakann/vim-highlightedyank')       -- highlight yanked text
Plug('psliwka/vim-smoothie')                -- smooth scrolling
Plug('milkypostman/vim-togglelist')         -- toggling lists
Plug('qpkorr/vim-bufkill')                  -- buffer management

Plug('airblade/vim-gitgutter')              -- preview git changes
Plug('samoshkin/vim-mergetool')             -- git mergetool
Plug('APZelos/blamer.nvim')                 -- git blame

Plug('NoahTheDuke/vim-just')                -- Justfile syntax
Plug('iamcco/markdown-preview.nvim', { ['do'] = vim.fn['mkdp#util#install'], ['for'] = { 'markdown', 'vim-plug' } })
Plug('alvan/vim-closetag')                  -- tag completion

vim.call('plug#end')

require("plugins.treesitter")
require("plugins.cmp")
require("plugins.lsp")
require("plugins.telescope")
require("plugins.lualine")
require("plugins.nerdtree")
require("plugins.quality-of-life")
require("plugins.git")
require("plugins.file-specific")