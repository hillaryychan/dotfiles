-- quickfix mappings
vim.api.nvim_set_keymap('n', '<leader>q', ':call ToggleQuickfixList()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[q', ':cprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']q', ':cnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[Q', ':cfirst<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']Q', ':clast<CR>', { noremap = true, silent = true })

-- location list mappings
vim.api.nvim_set_keymap('n', '<leader>l', ':call ToggleLocationList()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[l', ':lprevious<CR>zmzv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']l', ':lnext<CR>zmzv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[L', ':lfirst<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']L', ':llast<CR>', { noremap = true, silent = true })
