-- gitsigns
require('gitsigns').setup({
  current_line_blame_formatter = '<abbrev_sha> <author>, <author_time:%R> - <summary>',
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', '[H', function()
      if vim.wo.diff then
        vim.cmd.normal({'[H', bang = true})
      else
        gitsigns.nav_hunk('first')
      end
    end)

    map('n', '[h', function()
      if vim.wo.diff then
        vim.cmd.normal({'[h', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end)

    map('n', ']h', function()
      if vim.wo.diff then
        vim.cmd.normal({']h', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end)

    map('n', ']H', function()
      if vim.wo.diff then
        vim.cmd.normal({']H', bang = true})
      else
        gitsigns.nav_hunk('last')
      end
    end)

    -- Actions
    map('n', 'ghs', gs.stage_hunk)
    map('n', 'ghr', gs.reset_hunk)
    map('v', 'ghs', function()
      gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)
    map('v', 'ghr', function()
      gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)
    map('n', 'ghS', gs.stage_buffer)
    map('n', 'ghR', gs.reset_buffer)
    map('n', 'ghp', gs.preview_hunk_inline)
    map('n', 'ghb', function()
      gs.blame_line({ full = true })
    end)
    map('n', 'gtb', gs.toggle_current_line_blame)
    map('n', 'gtd', gs.diffthis)
    map('n', 'gtD', function()
      gs.diffthis('~')
    end)

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
})
