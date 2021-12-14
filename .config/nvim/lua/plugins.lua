local utils = require('utils')

-- automatically install vim-plug
vim.api.nvim_exec([[
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
]], true)

local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'sainnhe/sonokai'                          -- colourscheme

Plug('nvim-treesitter/nvim-treesitter', {['do'] = vim.fn['TSUpdate']})
Plug 'hrsh7th/nvim-cmp'                         -- autocompletion
Plug 'hrsh7th/cmp-nvim-lsp'                     -- LSP source for nvim-cmp
Plug 'hrsh7th/cmp-buffer'                       -- buffer source for nvim-cmp
Plug 'hrsh7th/cmp-path'                         -- filsystem source for nvim-cmp
Plug 'hrsh7th/cmp-cmdline'                      -- vim cmdline source for nvim-cmp
Plug 'neovim/nvim-lspconfig'                    -- intellisense

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'            -- fuzzy finder
Plug 'nvim-lualine/lualine.nvim'                -- status line
Plug 'preservim/nerdtree'                       -- file explorer

Plug 'cohama/lexima.vim'                        -- pair completion
Plug 'tpope/vim-surround'                       -- easy surrounding of pairs
Plug 'tpope/vim-commentary'                     -- easy commenting
Plug 'tpope/vim-sleuth'                         -- indentation detection
Plug 'lukas-reineke/indent-blankline.nvim'      -- display indentation levels
Plug 'junegunn/vim-peekaboo'                    -- register viewer
Plug 'junegunn/vim-easy-align'                  -- easy alignment
Plug 'unblevable/quick-scope'                   -- easier motions
Plug 'machakann/vim-highlightedyank'            -- highlight yanked text
Plug 'psliwka/vim-smoothie'                     -- smooth scrolling
Plug 'milkypostman/vim-togglelist'              -- toggling lists
Plug 'qpkorr/vim-bufkill'                       -- buffer management

Plug 'airblade/vim-gitgutter'                   -- preview git changes
Plug 'samoshkin/vim-mergetool'                  -- git mergetool
Plug 'APZelos/blamer.nvim'                      -- git blame

Plug 'NoahTheDuke/vim-just'                     -- Justfile syntax
Plug('iamcco/markdown-preview.nvim', {['do'] = vim.fn['mkdp#util#install'], ['for'] = {'markdown', 'vim-plug'}})
Plug 'alvan/vim-closetag'                       -- tag completion

vim.call('plug#end')

-- nvim-treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  }
}

vim.api.nvim_set_option('foldmethod', 'expr')
vim.api.nvim_set_option('foldexpr', 'nvim_treesitter#foldexpr()')
vim.api.nvim_set_option('foldlevelstart', 99)

-- nvim-cmp
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local cmp = require('cmp')

cmp.setup({
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<C-Space>'] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { 'i', 'c' }
    ),
    ['<Tab>'] = function(fallback)
      if not cmp.select_next_item() then
        if vim.bo.buftype ~= 'prompt' and has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if not cmp.select_prev_item() then
        if vim.bo.buftype ~= 'prompt' and has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end
    end,
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  }),
  snippet = {
    -- Don't want to use actual snippet engine.
    -- This snippet expander just inputs selected text and places cursor at the end.
    expand = function(args)
      local line_num, col = unpack(vim.api.nvim_win_get_cursor(0))
      local line_text = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, true)[1]
      local indent = string.match(line_text, '^%s*')
      local replace = vim.split(args.body, '\n', true)
      local surround = string.match(line_text, '%S.*') or ''
      local surround_end = surround:sub(col)

      replace[1] = surround:sub(0, col - 1)..replace[1]
      replace[#replace] = replace[#replace]..(#surround_end > 1 and ' ' or '')..surround_end
      if indent ~= '' then
        for i, line in ipairs(replace) do
          replace[i] = indent..line
        end
      end

      vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, true, replace)
      vim.api.nvim_win_set_cursor(0, {line_num, string.len(replace[1])})
    end,
  },
})

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'cmdline' }
  })
})

-- nvim-lspconfig
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- TODO: fix function names for v0.6
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>tp', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>dl', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

nvim_lsp['efm'].setup {
  on_attach = on_attach,
  init_options = { documentFormatting = true, codeAction = true },
  root_dir = vim.loop.cwd,
  settings = {
    rootMarkers = { '.git/' },
    languages = {
      lua = {
        { formatCommand = 'stylua --indent-type spaces --indent-width 2 --quote-style AutoPreferSingle -', formatStdin = true },
      },
      python = {
        { formatCommand = 'black -', formatStdin = true },
        { formatCommand = 'isort --stdout --profile black -', formatStdin = true },
      },
    },
  },
  filetypes = { "lua", "python" },
}

-- telescope
require('telescope').setup {
  defaults = {
    mappings = {
      n = {
        ['<c-d>'] = require('telescope.actions').delete_buffer,
        ['<c-u>'] = false
      },
      i = {
        ['<c-d>'] = require('telescope.actions').delete_buffer,
        ['<c-u>'] = false
      }
    }
  },
}

vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })

-- lualine
require('lualine').setup {
  options = {
    icons_enabled = false,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  }
}

-- nerdtree
vim.g.NERDTreeShowHidden = true
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>n', ':NERDTreeFind<CR>', { noremap = true })
 
-- vim-peekaboo
vim.g.peekaboo_window = 'vert to 40new'
 
-- easy-align
-- * start interactive EasyAlign in visual mode (e.g. vipga)
vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', {})
-- * Start interactive EasyAlign for a motion/text object (e.g. gaip)
vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', {})

vim.api.nvim_set_keymap('v', '<leader><bslash>', ':EasyAlign*<bar><CR>', {})

-- quick-scope
vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}

-- togglelist
-- * quickfix mappings
vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':call ToggleQuickfixList()<CR>', { noremap = true, silent =  true })
vim.api.nvim_set_keymap('n', '[q', ':cprevious<CR>', { noremap = true, silent =  true })
vim.api.nvim_set_keymap('n', ']q', ':cnext<CR>', { noremap = true, silent =  true })
vim.api.nvim_set_keymap('n', '[Q', ':cfirst<CR>', { noremap = true, silent =  true })
vim.api.nvim_set_keymap('n', ']Q', ':clast<CR>', { noremap = true, silent =  true })

-- * location list mappings
vim.api.nvim_set_keymap('n', '<leader>l', ':call ToggleLocationList()<CR>', { noremap = true, silent =  true })
vim.api.nvim_set_keymap('n', '[l', ':lprevious<CR>zmzv', { noremap = true, silent =  true })
vim.api.nvim_set_keymap('n', ']l', ':lnext<CR>zmzv', { noremap = true, silent =  true })
vim.api.nvim_set_keymap('n', '[L', ':lfirst<CR>', { noremap = true, silent =  true })
vim.api.nvim_set_keymap('n', ']L', ':llast<CR>', { noremap = true, silent =  true })

-- vim-bufkill
-- * buffer mappings
vim.api.nvim_set_keymap('n', '[b', ':bprevious<CR>', { noremap = true, silent =  true })
vim.api.nvim_set_keymap('n', ']b', ':bnext<CR>', { noremap = true, silent =  true })
vim.api.nvim_set_keymap('n', '[B', ':bfirst<CR>', { noremap = true, silent =  true })
vim.api.nvim_set_keymap('n', ']B', ':blast<CR>', { noremap = true, silent =  true })
vim.api.nvim_set_keymap('n', '<leader>d', ':BD<CR>', { noremap = true, silent =  true })
vim.api.nvim_set_keymap('n', '<leader>D', ':bufdo bd<CR>', { noremap = true, silent =  true })

-- vim-gitgutter
function _G.toggle_git_preview_hunk()
  local action = 'preview()'
  if vim.fn['gitgutter#hunk#is_preview_window_open']() == 1 then
    action  = 'close_hunk_preview_window()'
  end
  return ':call gitgutter#hunk#'..action..utils.t'<CR>'
end

vim.opt.updatetime = 500
vim.g.gitgutter_sign_added = '│'
vim.g.gitgutter_sign_modified = '│'
vim.g.gitgutter_sign_removed =  '.'
vim.g.gitgutter_sign_removed_first_line =  '˙'
vim.g.gitgutter_sign_modified_removed = '│'
vim.g.gitgutter_preview_win_floating = 0
vim.g.gitgutter_close_preview_on_escape = 1
vim.api.nvim_set_keymap('n', 'ghp', 'v:lua.toggle_git_preview_hunk()', { expr = true, silent =  true })
vim.api.nvim_set_keymap('n', 'ghu', '<Plug>(GitGutterUndoHunk)', { silent =  true })
vim.api.nvim_set_keymap('n', 'ghs', '<Plug>(GitGutterStageHunk)', { silent =  true })

-- vim-mergetool
vim.g.mergetool_layout = 'rm'               -- remote on left, optimistic merge on right
vim.g.mergetool_prefer_revision = 'local'   -- optimistically accept local changes for merge

-- blamer
vim.api.nvim_set_keymap('n', 'gb', ':BlamerToggle<CR>', { silent =  true })

-- markdown-preview
vim.api.nvim_set_keymap('n', '<leader>mp', '<Plug>MarkdownPreviewToggle', { silent =  true })

-- vim-closetag
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
