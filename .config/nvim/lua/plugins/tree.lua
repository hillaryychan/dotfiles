require('nvim-tree').setup({
  git = {
    enable = false
  },
  view = {
    width = 35,
  },
})

vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeFindFile<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>nr', ':NvimTreeRefresh<CR>', { noremap = true })
