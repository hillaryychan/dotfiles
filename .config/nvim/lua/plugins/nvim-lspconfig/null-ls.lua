-- TODO: update null_ls config for v0.6
local null_ls = require('null-ls')

null_ls.config({
  sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.prettier.with({
      filetypes = { 'css', 'scss', 'less', 'html', 'json', 'yaml' },
    }),
    null_ls.builtins.formatting.stylua,

    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.diagnostics.shellcheck.with({ filetypes = { 'sh', 'zsh', 'bash' } }),
    null_ls.builtins.diagnostics.markdownlint,

    null_ls.builtins.code_actions.eslint,
  },
})
