vim.g.mapleader = ' '

-- Load plugins
-- if filereadable(expand('~/.config/nvim/plugins.vim'))
--     source ~/.config/nvim/plugins.vim
-- endif

-- General
vim.opt.hidden = true               -- reuse same window and switch from an unsaved buffer
                                    -- without saving it first. Also keep undo history for
                                    -- multiple files
vim.opt.modelines = 0               -- security
vim.opt.visualbell = true           -- use visual bell instead of beeping when there is an error
vim.opt.mouse = 'a'                 -- enable mouse for all modes
vim.opt.clipboard = 'unnamedplus'   -- enable copy pasting between clipboard registers

-- TODO:Colours
-- if (has("termguicolors"))
--     vim.opt.termguicolors
-- endif
-- let g:sonokai_style = 'default'
-- let g:sonokai_enable_italic = 1
-- colorscheme sonokai

-- Indentation
vim.opt.expandtab = true            -- tab expands to spaces
vim.opt.tabstop = 4                 -- no. of visual spaces per tab
vim.opt.softtabstop = 4             -- no. of spaces per tab in edit
vim.opt.shiftwidth = 4              -- no. of spaces to use per indent
vim.opt.smartindent = true          -- indent based on filetype

-- UI configurations
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
vim.opt.listchars={ tab = '→ ', extends = '›', precedes = '‹', trail = '·', nbsp = '⎵' }
vim.opt.inccommand = 'nosplit'      -- show effects of a command incrementally

-- Searching
vim.opt.ignorecase = true           -- use case insensitive search except when using capital letters
vim.opt.smartcase = true            -- an uppercase letter will enable case sensitivity

vim.opt.scrolloff=3                 -- vertical scroll padding
vim.opt.sidescrolloff=5             -- horizontal scroll padding
vim.opt.matchpairs:append('<:>')    -- match angled brackets

-- Splitting
vim.opt.splitright = true           -- puts new vsplit windows to the right of the current
vim.opt.splitbelow = true           -- puts new split windows to bottom of current

vim.api.nvim_exec([[
" wrap lines for vimdiff
autocmd VimEnter * if &diff | execute 'windo set wrap' | endif

" case-insensitive command line
augroup dynamic_smartcase
  autocmd!
  autocmd CmdLineEnter : set nosmartcase
  autocmd CmdLineLeave : set smartcase
augroup END
]], false)

-- -- Mappings
-- nnoremap <leader>w :w<CR>
-- 
-- -- case-insensitive commands
-- inoremap jk <esc>
-- inoremap JK <esc>
-- vnoremap jk <esc>
-- vnoremap JK <esc>
-- 
-- -- clear highlighting
-- nnoremap <leader><space> :noh<CR>
-- 
-- -- make Y consistent with C and D
-- nnoremap Y y$
-- 
-- -- center highlighted search results
-- cnoremap <expr> <CR> getcmdtype() =~ '[/?]' ? '<CR>zz' : '<CR>'
-- nnoremap n nzz
-- nnoremap N Nzz
-- nnoremap * *zz
-- nnoremap # #zz
-- 
-- -- toggle spell check
-- noremap <F12> :setlocal spell! spelllang=en_au<cr>
-- inoremap <F12> <c-\><c-o>:setlocal spell! spelllang=en_au<cr>
-- 
-- -- split navigation
-- nnoremap <C-j> <C-w><C-j>
-- nnoremap <C-k> <C-w><C-k>
-- nnoremap <C-l> <C-w><C-l>
-- nnoremap <C-h> <C-w><C-h>
-- 

