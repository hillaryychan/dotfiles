local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  print('Installing packer close and reopen Neovim...')
  vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Enable profiling
packer.init({ profile = { enable = true } })

return packer.startup(function(use)
  -- Let packer manage itself
  use('wbthomason/packer.nvim')

  -- Colorscheme
  use({
    'sainnhe/sonokai',
    config = function()
      vim.g.sonokai_enable_italic = 1
      vim.cmd('colorscheme sonokai')
    end,
  })

  -- Treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('plugins.nvim-treesitter')
    end,
  })

  -- LSP + completion
  use({
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      require('plugins.nvim-cmp')
    end,
  })
  use({
    'jose-elias-alvarez/null-ls.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('plugins.null-ls')
    end,
  })
  use({
    'neovim/nvim-lspconfig',
    config = function()
      require('plugins.nvim-lspconfig')
    end,
  })

  -- Navigation
  use({
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('plugins.telescope')
    end,
  })
  use({
    'nvim-lualine/lualine.nvim',
    config = function()
      require('plugins.lualine')
    end,
  })
  use({
    'kyazdani42/nvim-tree.lua',
    config = function()
      require('plugins.nvim-tree')
    end,
  })

  -- Quality of life
  use('cohama/lexima.vim')
  use('tpope/vim-surround')
  use('tpope/vim-commentary')
  use('tpope/vim-sleuth')
  use('lukas-reineke/indent-blankline.nvim')
  use({
    'junegunn/vim-peekaboo',
    config = function()
      vim.g.peekaboo_window = 'vert to 40new'
    end,
  })
  use({
    'junegunn/vim-easy-align',
    config = function()
      require('plugins.vim-easy-align')
    end,
  })
  use({
    'unblevable/quick-scope',
    config = function()
      vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
    end,
  })
  use('machakann/vim-highlightedyank')
  use('psliwka/vim-smoothie')
  use({
    'milkypostman/vim-togglelist',
    config = function()
      require('plugins.vim-togglelist')
    end,
  })
  use({
    'qpkorr/vim-bufkill',
    config = function()
      require('plugins.vim-bufkill')
    end,
  })
  use({
    'szw/vim-maximizer',
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>z', ':MaximizerToggle<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('v', '<leader>z', ':MaximizerToggle<CR>gv', { noremap = true, silent = true })
    end,
  })

  -- Git
  use({
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('plugins.gitsigns')
    end,
  })
  use({
    'samoshkin/vim-mergetool',
    config = function()
      vim.g.mergetool_layout = 'rm' -- remote on left, optimistic merge on right
      vim.g.mergetool_prefer_revision = 'local' -- optimistically accept local changes for merge
    end,
  })

  -- File specific
  use('NoahTheDuke/vim-just')
  use({
    'iamcco/markdown-preview.nvim',
    run = function()
      vim.fn['mkdp#util#install']()
    end,
    ft = { 'markdown' },
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>mp', '<Plug>MarkdownPreviewToggle', { silent = true })
    end,
  })
  use({
    'alvan/vim-closetag',
    config = function()
      require('plugins.vim-closetag')
    end,
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
