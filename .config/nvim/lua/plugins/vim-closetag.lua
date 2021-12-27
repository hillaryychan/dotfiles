vim.g.closetag_filenames = '*.html,*.xhtml,*.phtml,*.xml,*.jsx,*.tsx'
vim.g.closetag_xhtml_filetypes = 'xml,xhtml,phtml,jsx,javascript.jsx,javascript.tsx,typescript.tsx,javascriptreact'
vim.g.closetag_emptyTags_caseSensitive = 1
vim.g.closetag_regions = {
  ['typescript.tsx'] = 'jsxRegion,tsxRegion',
  ['javascript.jsx'] = 'jsxRegion',
  ['typescriptreact'] = 'jsxRegion,tsxRegion',
  ['javascriptreact'] = 'jsxRegion',
}
vim.g.closetag_shortcut = '>'
vim.g.closetag_close_shortcut = '<leader>>'
