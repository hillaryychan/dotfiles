local utils = require('utils')

vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true })

-- case-insensitive commands
vim.api.nvim_set_keymap('i', 'jk', '<esc>', { noremap = true })
vim.api.nvim_set_keymap('i', 'JK', '<esc>', { noremap = true })
vim.api.nvim_set_keymap('v', 'jk', '<esc>', { noremap = true })
vim.api.nvim_set_keymap('v', 'JK', '<esc>', { noremap = true })

-- clear highlighting
vim.api.nvim_set_keymap('n', '<leader><space>', ':noh<CR>', { noremap = true })

-- TODO: remove for v0.6
-- make Y consistent with C and D
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

-- center highlighted search results
function _G.center_search()
  local cmdtype = vim.fn.getcmdtype()
  return cmdtype:match('^[/?]$') and utils.t('<CR>zz') or utils.t('<CR>')
end
vim.api.nvim_set_keymap('c', '<CR>', 'v:lua.center_search()', { expr = true, noremap = true })
vim.api.nvim_set_keymap('n', 'n', 'nzz', { noremap = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzz', { noremap = true })
vim.api.nvim_set_keymap('n', '*', '*zz', { noremap = true })
vim.api.nvim_set_keymap('n', '#', '#zz', { noremap = true })

-- toggle spell check
vim.api.nvim_set_keymap('', '<F12>', ':setlocal spell! spelllang=en_au<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', '<F12>', '<C-\\><C-o>:setlocal spell! spelllang=en_au<CR>', { noremap = true })

-- split navigation
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w><C-j>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w><C-k>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w><C-l>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w><C-h>', { noremap = true })
