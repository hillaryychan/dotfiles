vim.opt_local.spellang = "en_au"
vim.opt_local.wrap = true

-- bold
vim.api.nvim_set_keymap('i', '<c-b>', '****<esc>hi', { noremap = true })
-- italics
vim.api.nvim_set_keymap('i', '<c-e>', '**<esc>i', { noremap = true })
-- equations
vim.api.nvim_set_keymap('i', '<c-q>', '$$<esc>i', { noremap = true })
-- code blocks
vim.api.nvim_set_keymap('i', '<c-c><c-b>', '```<enter>```<esc>ka', { noremap = true })
-- unordered list
vim.api.nvim_set_keymap('i', '<c-u><c-l>', '* ', { noremap = true })
-- ordered list
vim.api.nvim_set_keymap('i', '<c-o><c-l>', '1. ', { noremap = true })
-- quote block
vim.api.nvim_set_keymap('i', '<c-q><c-b>', '> ', { noremap = true })
-- link
vim.api.nvim_set_keymap('i', '<c-l><c-k>', '[]()<esc>hhi', { noremap = true })
-- image link
vim.api.nvim_set_keymap('i', '<c-i><c-l>', '[]()hhi', { noremap = true })

vim.api.nvim_set_keymap('v', '<leader><bslash>', ':EasyAlign*<bar><enter>', { noremap = true })
