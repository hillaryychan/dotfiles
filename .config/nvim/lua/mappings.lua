local utils = require('utils')

-- saving buffers
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>e', ':noa w<CR>', { noremap = true })

-- escape mappings
vim.api.nvim_set_keymap('i', 'jk', '<esc>', { noremap = true })
vim.api.nvim_set_keymap('v', 'jk', '<esc>', { noremap = true })

-- clear highlighting
vim.api.nvim_set_keymap('n', '<leader><space>', ':noh<CR>', { noremap = true })

-- center highlighted search results
function _G.center_search()
  local cmdtype = vim.fn.getcmdtype()
  return cmdtype:match('^[/?]$') and utils.t('<CR>zz') or utils.t('<CR>')
end
vim.keymap.set('c', '<CR>', center_search, { expr = true, noremap = true })
vim.api.nvim_set_keymap('n', 'n', 'nzz', { noremap = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzz', { noremap = true })
vim.api.nvim_set_keymap('n', '*', '*zz', { noremap = true })
vim.api.nvim_set_keymap('n', '#', '#zz', { noremap = true })

-- toggle spell check
function _G.toggle_spellcheck()
  vim.opt.spell = not (vim.opt.spell:get())
  local spell_on = vim.opt.spell:get()
  print('Spellcheck ' .. tostring(spell_on and 'ON' or 'OFF'))
end
vim.keymap.set('', '<F12>', toggle_spellcheck, { noremap = true })
vim.keymap.set('i', '<F12>', toggle_spellcheck, { noremap = true })

-- split navigation
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w><C-j>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w><C-k>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w><C-l>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w><C-h>', { noremap = true })

-- copy path names
function _G.copy_path_name(path_type)
  return function()
    -- default to relative path
    local path = vim.fn.expand('%')
    if path_type == 'full' then
      path = vim.fn.expand('%:p')
    elseif path_type == 'filename' then
      path = vim.fn.expand('%:t')
    end

    if path == '' then
      print('No file name to copy')
    else
      vim.fn.setreg('+', path)
      print(string.format('Copied "%s"', path))
    end
  end
end
vim.api.nvim_create_user_command('CopyRelativePath', copy_path_name('relative'), {})
vim.api.nvim_create_user_command('CopyFilePath', copy_path_name('full'), {})
vim.api.nvim_create_user_command('CopyFileName', copy_path_name('filename'), {})
