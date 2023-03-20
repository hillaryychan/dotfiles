local fzf_lua = require('fzf-lua')

local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>p', fzf_lua.builtin, opts)
vim.keymap.set('n', '<leader>f', fzf_lua.files, opts)
vim.keymap.set('n', '<leader>g', fzf_lua.live_grep, opts)
vim.keymap.set('n', '<leader>b', fzf_lua.buffers, opts)
vim.keymap.set('n', '<leader>c', fzf_lua.git_status, opts)

-- LSP Pickers
vim.keymap.set('n', 'gd', fzf_lua.lsp_definitions, opts)
vim.keymap.set('n', 'gr', fzf_lua.lsp_references, opts)
vim.keymap.set('n', '<leader>sd', fzf_lua.lsp_document_symbols, opts)
vim.keymap.set('n', '<leader>sw', fzf_lua.lsp_live_workspace_symbols, opts)
vim.api.nvim_create_user_command('WorkspaceSymbols', fzf_lua.lsp_live_workspace_symbols, {})
vim.api.nvim_create_user_command('DocumentSymbols', fzf_lua.lsp_document_symbols, {})
vim.api.nvim_create_user_command('WorkspaceDiagnostics', fzf_lua.diagnostics_workspace, {})
vim.api.nvim_create_user_command('DocumentDiagnostics', fzf_lua.diagnostics_document, {})
