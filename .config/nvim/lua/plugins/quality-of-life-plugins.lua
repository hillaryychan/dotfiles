-- vim-peekaboo
vim.g.peekaboo_window = 'vert to 40new'

-- easy-align
-- * start interactive EasyAlign in visual mode (e.g. vipga)
vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', {})
-- * Start interactive EasyAlign for a motion/text object (e.g. gaip)
vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', {})

vim.api.nvim_set_keymap('v', '<leader><bslash>', ':EasyAlign*<bar><CR>', {})

-- quick-scope
vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }

-- togglelist
-- * quickfix mappings
vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':call ToggleQuickfixList()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[q', ':cprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']q', ':cnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[Q', ':cfirst<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']Q', ':clast<CR>', { noremap = true, silent = true })

-- * location list mappings
vim.api.nvim_set_keymap('n', '<leader>l', ':call ToggleLocationList()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[l', ':lprevious<CR>zmzv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']l', ':lnext<CR>zmzv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[L', ':lfirst<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']L', ':llast<CR>', { noremap = true, silent = true })

-- vim-bufkill
-- * buffer mappings
vim.api.nvim_set_keymap('n', '[b', ':bprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']b', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[B', ':bfirst<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']B', ':blast<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>d', ':BD<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>D', ':bufdo bd<CR>', { noremap = true, silent = true })
