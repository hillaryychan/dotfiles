-- gitsigns
require('gitsigns').setup({
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        return ']c'
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return '<Ignore>'
    end, { expr = true })

    map('n', '[c', function()
      if vim.wo.diff then
        return '[c'
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return '<Ignore>'
    end, { expr = true })

    -- Actions
    map({ 'n', 'v' }, 'ghs', ':Gitsigns stage_hunk<CR>')
    map({ 'n', 'v' }, 'ghr', ':Gitsigns reset_hunk<CR>')
    map('n', 'ghS', gs.stage_buffer)
    map('n', 'ghu', gs.undo_stage_hunk)
    map('n', 'ghR', gs.reset_buffer)
    map('n', 'ghp', gs.preview_hunk)
    map('n', 'ghb', function()
      gs.blame_line({ full = true })
    end)
    map('n', 'gtb', gs.toggle_current_line_blame)
    map('n', 'gtd', gs.toggle_deleted)

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
  yadm = {
    enable = true,
  },
})
