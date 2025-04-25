-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Colorscheme
  {
    'sainnhe/sonokai',
    lazy = false,
    config = function()
      vim.g.sonokai_enable_italic = 1
      vim.cmd('colorscheme sonokai')
    end,
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        config = function()
          vim.g.skip_ts_context_commentstring_module = true
          require('ts_context_commentstring').setup()
        end,
      },
    },
    config = function()
      require('plugins.nvim-treesitter')
    end,
  },

  -- LSP + completion
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'dcampos/nvim-snippy',
      'dcampos/cmp-snippy',
    },
    config = function()
      require('plugins.nvim-cmp')
    end,
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('plugins.nvim-lspconfig')
    end,
  },
  -- TODO: find auto foramtter plugin

  -- Navigation
  -- {
  --   'nvim-telescope/telescope.nvim',
  --   tag = '0.1.5',
  --   dependencies = {
  --     { 'nvim-lua/plenary.nvim' },
  --     { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  --   },
  --   config = function()
  --     require('plugins.telescope')
  --   end,
  -- },
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('plugins.fzf-lua')
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_b = { { 'diagnostics', colored = false } },
      },
    },
  },
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup({
        git = {
          enable = false,
        },
        view = {
          width = 35,
        },
      })
      vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeFindFileToggle<CR>', { noremap = true })
    end,
  },
  -- TODO: archived use dropbar
  -- {
  --   'utilyre/barbecue.nvim',
  --   name = 'barbecue',
  --   version = '*',
  --   dependencies = { 'SmiteshP/nvim-navic', 'nvim-tree/nvim-web-devicons' },
  --   opts = {},
  -- },

  -- Quality of life
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },
  {
    'numToStr/Comment.nvim',
    opts = {
      -- ignore empty/blank lines
      ignore = '^%s*$',
    },
  },
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup()
    end,
  },
  { 'tpope/vim-sleuth' },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
      },
    },
  },
  {
    'junegunn/vim-peekaboo',
    config = function()
      vim.g.peekaboo_window = 'vert to 40new'
    end,
  },
  {
    'junegunn/vim-easy-align',
    config = function()
      -- start interactive EasyAlign in visual mode (e.g. vipga)
      vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', {})
      -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
      vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', {})

      vim.api.nvim_set_keymap('v', '<leader><bslash>', ':EasyAlign*<bar><CR>', {})
    end,
  },
  {
    'jinh0/eyeliner.nvim',
    opts = {
      highlight_on_key = true,
      dim = true,
    },
  },
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup()
    end,
  },
  {
    'milkypostman/vim-togglelist',
    config = function()
      require('plugins.vim-togglelist')
    end,
  },
  {
    'qpkorr/vim-bufkill',
    config = function()
      vim.api.nvim_set_keymap('n', '[b', ':bprevious<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', ']b', ':bnext<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[B', ':bfirst<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', ']B', ':blast<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>d', ':BD<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>D', ':bufdo bd<CR>', { noremap = true, silent = true })
    end,
  },
  {
    'anuvyklack/windows.nvim',
    dependencies = { 'anuvyklack/middleclass', 'anuvyklack/animation.nvim' },
    config = function()
      require('windows').setup()
      vim.api.nvim_set_keymap('n', '<leader>z', ':WindowsMaximize<CR>', { noremap = true, silent = true })
    end,
  },

  -- Git
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('plugins.gitsigns')
    end,
  },
  {
    'samoshkin/vim-mergetool',
    config = function()
      vim.g.mergetool_layout = 'rm' -- remote on left, optimistic merge on right
      vim.g.mergetool_prefer_revision = 'local' -- optimistically accept local changes for merge
    end,
  },

  -- File specific
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
      vim.api.nvim_set_keymap('n', '<leader>p', '<Plug>MarkdownPreviewToggle', { silent = true })
    end,
  },
})
