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
-- TODO: remove commit pin for v6.0
Plug('jose-elias-alvarez/null-ls.nvim', { commit = '8828af7' })     -- hook LSP features

Plug('nvim-lua/plenary.nvim')
-- TODO: remove commit pin for v6.0
Plug('nvim-telescope/telescope.nvim', { commit = '80cdb00' })       -- fuzzy finder
Plug('nvim-lualine/lualine.nvim')           -- status line
Plug('kyazdani42/nvim-tree.lua')            -- file explorer

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
Plug('szw/vim-maximizer')                   -- toggling windows

Plug('lewis6991/gitsigns.nvim')             -- preview git changes and blames
Plug('samoshkin/vim-mergetool')             -- git mergetool

Plug('NoahTheDuke/vim-just')                -- Justfile syntax
Plug('iamcco/markdown-preview.nvim', { ['do'] = vim.fn['mkdp#util#install'], ['for'] = { 'markdown', 'vim-plug' } })
Plug('alvan/vim-closetag')                  -- tag completion

vim.call('plug#end')

require('plugins.nvim-treesitter')
require('plugins.nvim-cmp')
require('plugins.nvim-lspconfig')
require('plugins.nvim-telescope')
require('plugins.lualine')
require('plugins.nvim-tree')
require('plugins.quality-of-life-plugins')
require('plugins.git-plugins')
require('plugins.file-specific-plugins')
