require('telescope').setup({
  defaults = {
    mappings = {
      n = {
        ['<c-d>'] = require('telescope.actions').delete_buffer,
        ['<c-u>'] = false,
      },
      i = {
        ['<c-d>'] = require('telescope.actions').delete_buffer,
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
      '--hidden',
      '--glob',
      '!.git/'
    },
  },
  pickers = {
    find_files = {
      find_command = { 'fd', '--type', 'file', '--hidden', '--follow', '--exclude', '.git' },
    },
  },
})

vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })
