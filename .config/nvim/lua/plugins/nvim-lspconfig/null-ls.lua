-- TODO: update null_ls config for v0.6
local null_ls = require('null-ls')

null_ls.config({
  sources = {
    null_ls.builtins.formatting.stylua.with({ filetypes = { 'lua' } }),
    null_ls.builtins.diagnostics.markdownlint.with({ filetypes = { 'markdown' } }),
    null_ls.builtins.formatting.prettier.with({ filetypes = { 'css', 'html', 'json', 'yaml' } }),
    null_ls.builtins.formatting.black.with({ filetypes = { 'python' } }),
    null_ls.builtins.formatting.isort.with({ filetypes = { 'python' } }),
    null_ls.builtins.diagnostics.shellcheck.with({ filetypes = { 'sh', 'zsh', 'bash' } }),
    null_ls.builtins.diagnostics.eslint.with({ filetypes = { 'javascript', 'typescript' } }),
    null_ls.builtins.code_actions.eslint.with({ filetypes = { 'javascript', 'typescript' } }),
  },
})
