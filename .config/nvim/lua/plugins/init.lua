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

  -- mini.nvim
  {
    'echasnovski/mini.nvim',
    config = function()
      -- text editing
      require('mini.align').setup()
      require('mini.comment').setup({
        options = {
          ignore_blank_line = true,
        }
      })
      require('mini.pairs').setup()
      require('mini.splitjoin').setup()

      -- workflow
      require('mini.bracketed').setup()
      -- * bracket navigation for tabpages (using p since t is for treesitter)
      vim.api.nvim_set_keymap('n', '[p', ':tabprevious<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', ']p', ':tabnext<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[P', ':tabfirst<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', ']P', ':tablast<CR>', { noremap = true, silent = true })
      require('mini.bufremove').setup()
      vim.keymap.set('n', '<leader>d', function() MiniBufremove.delete(0) end, { noremap = true })
      vim.keymap.set('n', '<leader>D', function() MiniBufremove.delete(0, true) end, { noremap = true })

      -- appearance
      require('mini.animate').setup({
        cursor = {
          enable = false,
        },
        open = {
          enable = false,
        },
        close = {
          enable = false,
        }
      })
      require('mini.icons').setup()
      -- in conjuction with lukas-reineke/indent-blankline.nvim
      require('mini.indentscope').setup()
      require('mini.statusline').setup({
        content = {
          active = function()
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
            local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
            local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
            local location      = MiniStatusline.section_location({ trunc_width = 75 })

            return MiniStatusline.combine_groups({
              { hl = mode_hl,                  strings = { mode } },
              { hl = 'MiniStatuslineDevinfo',  strings = { diagnostics } },
              '%<', -- Mark general truncate point
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              '%=', -- End left alignment
              { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
              { hl = mode_hl,                  strings = { location } },
            })
          end
        },
      })
      require('mini.trailspace').setup()
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
      local servers = { 'jsonls', 'pyright', 'ts_ls', 'yamlls' }
      for _, lsp in ipairs(servers) do
        vim.lsp.enable(lsp)
      end
    end,
  },
  -- TODO: find auto formatter plugin

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
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup()
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      -- scope to statically show indent guides
      -- use mini.indentscope for showing active indent levels
      scope = {
        enabled = false,
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
    'jinh0/eyeliner.nvim',
    opts = {
      highlight_on_key = true,
      dim = true,
    },
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
