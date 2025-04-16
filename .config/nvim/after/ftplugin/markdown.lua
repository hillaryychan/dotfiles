vim.opt_local.tabstop = 4           -- no. of visual spaces per tab
vim.opt_local.softtabstop = 4       -- no. of spaces per tab in edit
vim.opt_local.shiftwidth = 4        -- no. of spaces per indent

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

vim.g.markdown_fenced_languages = {
  'bash=sh',
  'c',
  'cmake',
  'cpp',
  'cs',
  'csharp=cs',
  'css',
  'diff',
  'django',
  'go',
  'html',
  'haskell',
  'hs=haskell',
  'java',
  'javascript',
  'js=javascript',
  'json',
  'less',
  'make',
  'php',
  'python',
  'ruby',
  'rust',
  'scss',
  'sh',
  'shell=sh',
  'sql',
  'vim',
  'xml',
  'yaml',
  'zsh'
}

vim.b.sleuth_automatic = 0
