local nvim_lsp = require('lspconfig')
local on_attach = require('plugins.nvim-lspconfig.on-attach')

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
  })
end

require('plugins.nvim-lspconfig.null-ls')
nvim_lsp['null-ls'].setup({
  on_attach = on_attach,
  root_dir = nvim_lsp.util.root_pattern({ '.null-ls-root', './git/', '.' }),
})
