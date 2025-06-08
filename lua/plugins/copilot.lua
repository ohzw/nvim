-- return {
--   'zbirenbaum/copilot.lua',
--   cmd = 'Copilot',
--   event = 'InsertEnter',
--   config = function()
--     cmp.event:on('menu_opened', function()
--       vim.b.copilot_suggestion_hidden = true
--     end)
--
--     cmp.event:on('menu_closed', function()
--       vim.b.copilot_suggestion_hidden = false
--     end)
--     require('copilot').setup {
--       panel = {
--         enabled = true,
--         auto_refresh = false,
--         keymap = {
--           jump_prev = '[[',
--           jump_next = ']]',
--           accept = '<CR>',
--           refresh = 'gr',
--           open = '<M-CR>',
--         },
--         layout = {
--           position = 'bottom', -- | top | left | right | horizontal | vertical
--           ratio = 0.4,
--         },
--       },
--       suggestion = {
--         enabled = true,
--         auto_trigger = false,
--         hide_during_completion = true,
--         debounce = 75,
--         keymap = {
--           accept = '<M-l>',
--           accept_word = false,
--           accept_line = false,
--           next = '<M-]>',
--           prev = '<M-[>',
--           dismiss = '<C-]>',
--         },
--       },
--       filetypes = {
--         yaml = false,
--         markdown = false,
--         help = false,
--         gitcommit = false,
--         gitrebase = false,
--         hgcommit = false,
--         svn = false,
--         cvs = false,
--         ['.'] = false,
--       },
--       copilot_node_command = 'node', -- Node.js version must be > 18.x
--       server_opts_overrides = {},
--     }
--   end,
-- }

return {
  { 'github/copilot.vim' },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    opts = {
      debug = true, -- Enable debugging
    },
  },
}
