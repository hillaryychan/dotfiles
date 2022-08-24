local actions = require('telescope.actions')
require('telescope').setup({
  defaults = {
    mappings = {
      n = {
        ['<c-d>'] = actions.delete_buffer,
        ['<c-u>'] = false,
      },
      i = {
        ['<esc>'] = actions.close,
        ['<c-d>'] = actions.delete_buffer,
        ['<c-u>'] = false,
      },
    },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--trim',
      '--hidden',
      '--glob',
      '!.git/',
    },
  },
  pickers = {
    find_files = {
      find_command = { 'fd', '--type', 'file', '--hidden', '--follow', '--exclude', '.git' },
    },
  },
})

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>Telescope<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>Telescope find_files<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>Telescope live_grep<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>Telescope buffers<CR>', opts)

-- LSP Pickers
vim.api.nvim_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
vim.api.nvim_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
