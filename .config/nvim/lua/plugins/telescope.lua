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

vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>Telescope<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })
