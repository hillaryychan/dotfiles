require('nvim-treesitter.configs').setup({
  ensure_installed = 'maintained',
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  context_commentstring = {
    enable = true,
  },
})

vim.api.nvim_set_option('foldmethod', 'expr')
vim.api.nvim_set_option('foldexpr', 'nvim_treesitter#foldexpr()')
vim.api.nvim_set_option('foldlevelstart', 99)
