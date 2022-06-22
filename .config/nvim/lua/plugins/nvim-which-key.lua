local whichkey = require('which-key')

whichkey.setup({
  plugins = {
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
    },
  },
})

-- To disable surround objects for operators
-- See: https://github.com/folke/which-key.nvim/issues/14
whichkey.register({ ['c'] = 'which_key_ignore', ['d'] = 'which_key_ignore', ['y'] = 'which_key_ignore' })
