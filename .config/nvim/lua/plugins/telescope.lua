local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup({
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
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
})

telescope.load_extension('fzf')

local builtin = require('telescope.builtin')
local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>t', builtin.builtin, opts)
vim.keymap.set('n', '<leader>f', builtin.find_files, opts)
vim.keymap.set('n', '<leader>g', builtin.live_grep, opts)
vim.keymap.set('n', '<leader>b', builtin.buffers, opts)
vim.keymap.set('n', '<leader>c', builtin.git_status, opts)

-- LSP Pickers
vim.keymap.set('n', 'gd', builtin.lsp_definitions, opts)
vim.keymap.set('n', 'gr', builtin.lsp_references, opts)
vim.keymap.set('n', '<leader>sd', builtin.lsp_document_symbols, opts)
vim.keymap.set('n', '<leader>sw', builtin.lsp_dynamic_workspace_symbols, opts)
vim.api.nvim_create_user_command('WorkspaceSymbols', builtin.lsp_dynamic_workspace_symbols, {})
vim.api.nvim_create_user_command('DocumentSymbols', builtin.lsp_document_symbols, {})
vim.api.nvim_create_user_command('WorkspaceDiagnostics', builtin.diagnostics, {})
vim.api.nvim_create_user_command('DocumentDiagnostics', function()
  builtin.diagnostics({ bufnr = 0 })
end, {})
