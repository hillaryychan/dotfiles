require('nvim-tree').setup({
  git = {
    enable = false,
  },
  view = {
    width = 35,
  },
})

vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeFindFileToggle<CR>', { noremap = true })
