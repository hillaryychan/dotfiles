-- vim-gitgutter
function _G.toggle_git_preview_hunk()
  local action = 'preview()'
  if vim.fn['gitgutter#hunk#is_preview_window_open']() == 1 then
    action = 'close_hunk_preview_window()'
  end
  return ':call gitgutter#hunk#' .. action .. utils.t('<CR>')
end

vim.opt.updatetime = 500
vim.g.gitgutter_sign_added = '│'
vim.g.gitgutter_sign_modified = '│'
vim.g.gitgutter_sign_removed = '.'
vim.g.gitgutter_sign_removed_first_line = '˙'
vim.g.gitgutter_sign_modified_removed = '│'
vim.g.gitgutter_preview_win_floating = 0
vim.g.gitgutter_close_preview_on_escape = 1
vim.api.nvim_set_keymap('n', 'ghp', 'v:lua.toggle_git_preview_hunk()', { expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'ghu', '<Plug>(GitGutterUndoHunk)', { silent = true })
vim.api.nvim_set_keymap('n', 'ghs', '<Plug>(GitGutterStageHunk)', { silent = true })

-- vim-mergetool
vim.g.mergetool_layout = 'rm'               -- remote on left, optimistic merge on right
vim.g.mergetool_prefer_revision = 'local'   -- optimistically accept local changes for merge

-- blamer
vim.api.nvim_set_keymap('n', 'gb', ':BlamerToggle<CR>', { silent = true })
