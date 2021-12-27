-- gitsigns
require('gitsigns').setup({
  keymaps = {
    noremap = true,

    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'" },
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'" },

    ['n ghs'] = '<cmd>Gitsigns stage_hunk<CR>',
    ['v ghs'] = ':Gitsigns stage_hunk<CR>',
    ['n ghu'] = '<cmd>Gitsigns undo_stage_hunk<CR>',
    ['n ghr'] = '<cmd>Gitsigns reset_hunk<CR>',
    ['v ghr'] = ':Gitsigns reset_hunk<CR>',
    ['n ghR'] = '<cmd>Gitsigns reset_buffer<CR>',
    ['n ghp'] = '<cmd>Gitsigns preview_hunk<CR>',
    ['n ghb'] = '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',
    ['n ghS'] = '<cmd>Gitsigns stage_buffer<CR>',
    ['n ghU'] = '<cmd>Gitsigns reset_buffer_index<CR>',
    ['n gb'] = '<cmd>Gitsigns toggle_current_line_blame<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>Gitsigns select_hunk<CR>',
    ['x ih'] = ':<C-U>Gitsigns select_hunk<CR>',
  },
  yadm = {
    enable = true,
  },
})
