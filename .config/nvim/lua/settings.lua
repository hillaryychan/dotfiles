-- General
vim.opt.hidden = true               -- reuse same window and switch from an unsaved buffer
                                    -- without saving it first. Also keep undo history for
                                    -- multiple files
vim.opt.modelines = 0               -- security
vim.opt.visualbell = true           -- use visual bell instead of beeping when there is an error
vim.opt.mouse = 'a'                 -- enable mouse for all modes
vim.opt.clipboard = 'unnamedplus'   -- enable copy pasting between clipboard registers

-- Indentation
vim.opt.expandtab = true            -- tab expands to spaces
vim.opt.tabstop = 4                 -- no. of visual spaces per tab
vim.opt.softtabstop = 4             -- no. of spaces per tab in edit
vim.opt.shiftwidth = 4              -- no. of spaces to use per indent
vim.opt.smartindent = true          -- indent based on filetype

-- UI configurations
if vim.fn.has('termguicolors') then
  vim.opt.termguicolors = true
end
vim.opt.showmode = false            -- don't show working mode
vim.opt.number = true               -- show line numbers
vim.opt.relativenumber = true       -- show relative line numbers
vim.opt.wrap = false                -- don't wrap lines
vim.opt.path:append('**')           -- provides recursive file path
vim.opt.wildignorecase = true       -- ignore case in commandline filename completion
vim.opt.showmatch = true            -- highlight matching parenthesis
vim.opt.cursorline = true           -- highlight the cursor line
vim.opt.colorcolumn = '80,100,120'  -- colour the 80th, 100th, 120th column
vim.opt.list = true                 -- display hidden characters in vim
vim.opt.listchars = { space =  '·', tab = '→ ', extends = '›', precedes = '‹', trail = '·', nbsp = '⎵' }
vim.opt.inccommand = 'nosplit'      -- show effects of a command incrementally
vim.opt.laststatus = 3              -- global statusline

-- Searching
vim.opt.ignorecase = true           -- use case insensitive search except when using capital letters
vim.opt.smartcase = true            -- an uppercase letter will enable case sensitivity

vim.opt.scrolloff = 3               -- vertical scroll padding
vim.opt.sidescrolloff = 5           -- horizontal scroll padding
vim.opt.matchpairs:append('<:>')    -- match angled brackets

-- Splitting
vim.opt.splitright = true           -- puts new vsplit windows to the right of the current
vim.opt.splitbelow = true           -- puts new split windows to bottom of current

-- Spelling (see mappings.lua to toggle spellcheck)
vim.opt.spell = true
vim.opt.spelllang = { 'en_us', 'en_au' }
vim.opt.spelloptions = { 'camel' }
vim.opt.spellsuggest = { 'best', 9 }

-- Wrap lines for diff mode
vim.api.nvim_create_autocmd('VimEnter', { pattern = '*', command = 'windo set wrap' })

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ timeout = 1000 })
  end,
})
