local null_ls = require('null-ls')
local builtins = require('null-ls.builtins')
local utils = require('null-ls.utils')

local function on_attach(client, bufnr)
  require('utils').on_attach_base(client, bufnr)

  client.server_capabilities.documentFormattingProvider = true
  client.server_capabilities.documentRangeFormattingProvider  = true
end

HOME = vim.fn.expand('$HOME')

null_ls.setup({
  on_attach = on_attach,
  root_dir = utils.root_pattern('.null-ls-root', './git/', '.'),
  sources = {
    builtins.formatting.black,
    builtins.formatting.isort,
    builtins.formatting.ruff,
    builtins.formatting.prettier,
    builtins.formatting.eslint_d,
    builtins.formatting.rustfmt,
    builtins.formatting.stylua,

    builtins.diagnostics.eslint_d,
    builtins.diagnostics.shellcheck.with({ filetypes = { 'sh', 'zsh', 'bash' } }),
    builtins.diagnostics.markdownlint.with({
      extra_args = { '--config', HOME .. '/.config/nvim/lua/plugins/null-ls/markdownlint.json' },
    }),

    builtins.code_actions.eslint,
  },
})
