local nvim_lsp = require('lspconfig')

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local function on_attach(client, bufnr)
  require('utils').on_attach_base(client, bufnr)

  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'jsonls', 'pyright', 'rust_analyzer', 'ts_ls', 'yamlls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
  })
end

HOME = vim.fn.expand('$HOME')
local lua_ls_root_path = HOME .. '/.config/nvim/servers/lua-language-server'
local lua_ls_binary = HOME .. '/.config/nvim/servers/lua-language-server/bin/lua-language-server'

nvim_lsp.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  cmd = { lua_ls_binary, '-E', lua_ls_root_path .. '/main.lua' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = { [vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true },
        -- Disable workspace configuration prompts
        checkThirdParty = false,
        -- Increase loaded file count/size
        maxPreload = 10000,
        preloadFileSize = 10000,
      },
      telemetry = {
        -- Do not send telemetry data containing a randomized but unique identifier
        enable = false,
      },
    },
  },
})
