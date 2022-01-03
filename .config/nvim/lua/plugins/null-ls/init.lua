local null_ls = require('null-ls')
local builtins = require('null-ls.builtins')
local helpers = require('null-ls.helpers')
local methods = require('null-ls.methods')
local utils = require('null-ls.utils')

local on_attach = require('utils').on_attach

local prettier_eslint = {
  name = 'prettier-eslint',
  method = methods.internal.FORMATTING,
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  generator = helpers.formatter_factory({
    command = 'prettier-eslint',
    args = { '$FILENAME' },
    to_stdin = true,
  }),
  factory = helpers.formatter_factory,
}

HOME = vim.fn.expand('$HOME')

null_ls.setup({
  on_attach = on_attach,
  root_dir = utils.root_pattern('.null-ls-root', './git/', '.'),
  sources = {
    builtins.formatting.black,
    builtins.formatting.isort,
    builtins.formatting.prettier.with({
      filetypes = { 'css', 'scss', 'less', 'html', 'json', 'yaml' },
    }),
    builtins.formatting.stylua,
    prettier_eslint,

    builtins.diagnostics.eslint,
    builtins.diagnostics.shellcheck.with({ filetypes = { 'sh', 'zsh', 'bash' } }),
    builtins.diagnostics.markdownlint.with({
      extra_args = { '--config', HOME .. '/.config/nvim/lua/plugins/null-ls/markdownlint.json' },
    }),

    builtins.code_actions.eslint,
  },
})
