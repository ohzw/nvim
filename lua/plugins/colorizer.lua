return {
  'norcalli/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup {
      'css',
      'javascript',
      yaml = { mode = 'background' },
      html = { mode = 'foreground' },
    }
  end,
}
