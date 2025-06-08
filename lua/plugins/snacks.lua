local function get_image_dimensions(image_path)
  local handle = io.popen(string.format('identify -format "%%wx%%h" %s', image_path))
  local result = handle:read('*a'):gsub('%s+', '')
  handle:close()

  local width, height = result:match '(%d+)x(%d+)'
  return tonumber(width), tonumber(height)
end

local function get_chafa_config(image_path, max_height_ratio, max_width_ratio)
  local terminal_width = vim.api.nvim_win_get_width(0)
  local terminal_height = vim.api.nvim_win_get_height(0)

  local img_width, img_height = get_image_dimensions(image_path)
  if not img_width or not img_height then
    return { cmd = 'echo "Failed to get image dimensions"', width = 50, height = 10 }
  end

  local max_display_width = math.floor(terminal_width * max_width_ratio)
  local max_display_height = math.floor(terminal_height * max_height_ratio)

  local display_width = max_display_width
  local display_height = max_display_height

  local cmd = string.format(
    'chafa %s --format symbols --symbols vhalf --size %dx%d --align center -w 1',
    image_path,
    display_width,
    display_height
  )

  return {
    cmd = cmd,
    width = display_width,
    height = display_height,
  }
end

local image_path = '~/Desktop/nvim-dashboard-header/GswqwfXbEAATzpi.png'
local max_height_ratio = 0.5
local max_width_ratio = 0.5

local config = get_chafa_config(image_path, max_height_ratio, max_width_ratio)

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    animate = { enabled = true },
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    dashboard = {
      enabled = true,
      width = config.width,
      sections = {
        {
          section = 'terminal',
          padding = 1,
          cmd = config.cmd,
          width = config.width,
          height = config.height,
        },
        { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
        { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
        { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
        { section = 'startup' },
      },
      preset = {
        header = [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡠⠞⢓⡒⢭⣇⣤⠤⡄⡀⠤⠄⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡊⠐⠁⢀⡴⠅⠂⠉⠉⠈⠉⠐⠂⠪⠤⢉⠙⠖⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡐⠝⠁⠀⠊⠀⠀⠀⡀⢄⡂⠠⠀⠀⠀⠀⠀⠀⠈⠱⢜⠣⣄⠀⣀⣀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠊⢠⡆⠀⠀⠀⢠⠊⠊⠀⠀⠀⠀⠀⠀⠐⠈⠐⡄⠀⠀⢩⠐⡇⠉⠐⡍⢲⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⠀⢀⣀⣀⡰⠇⣰⡫⠀⠀⠀⡼⠃⠀⠀⠀⠀⡠⢃⠞⣠⠀⠀⠁⡘⡄⠀⠈⢆⢰⡌⠐⠌⠄⢱⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠳⣌⠹⣷⣾⢩⢍⣘⠳⠁⠀⠀⠌⠀⠀⣀⠠⣐⠨⠀⠁⠸⢀⠀⠀⠀⠐⡰⠀⠀⠈⡜⣙⡄⠈⠴⢺⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠢⣢⡉⠸⡀⣮⡇⠀⠰⡘⠈⠉⠙⠍⣁⠜⠀⠀⠀⠀⣩⡄⠀⠀⠀⢡⠃⠀⠀⢠⡿⢹⡀⠒⡼⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠗⣮⡳⣜⡇⠀⠢⢁⣠⣀⡀⠀⠂⠀⠀⠀⠀⠘⢄⠻⢆⠀⠀⢸⠀⠀⠀⠈⣿⢸⢃⠸⣏⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡞⣚⣼⣘⣦⣴⢀⣿⡀⠀⠈⠉⠛⠋⠀⠀⠀⠀⣠⠒⠩⡀⠁⢀⡘⠀⠀⠀⣀⣼⢻⢺⠀⢸⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⡸⡥⠓⠜⡏⣼⢱⣇⠣⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⠦⣄⠈⠀⢠⠁⡘⠀⠰⢹⡉⠛⢄⡀⣼⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⢇⠋⡄⠱⡘⢰⣻⢮⡿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠲⣠⠊⢀⣰⠡⢃⠠⠙⡇⠠⣙⠒⣀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢘⠎⠀⢡⢀⢡⣜⠟⠸⣷⣣⢤⣀⡀⡀⣀⡀⠀⠀⠀⠀⠀⢀⡴⠶⣋⣤⡞⣯⠆⣘⡤⠲⠃⣔⣋⡲⠝⠒
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠋⠀⠀⠀⡎⢒⢫⠀⢽⠙⠚⠧⢯⣽⡱⣷⣤⡐⠠⠄⠤⠄⣤⣞⣿⠛⣽⠉⣰⡶⢤⠀⠡⢠⡐⢷⡶⠚⠛
⠀⠀⠀⠀⠀⠀⠀⠀⢀⡲⠉⡰⠀⠀⠀⠸⢩⡄⣷⣸⠀⡡⠂⡄⢠⠀⡉⠉⢇⠐⠨⢐⠠⠸⢀⠠⢉⠉⠜⢣⠆⣌⠫⠅⡦⡇⢠⡇⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢠⠝⠀⡰⠁⠀⡀⠀⠀⣟⡇⢸⣿⠠⢁⠒⡈⠄⣢⡴⣥⡎⢀⠃⠔⢂⢱⣀⢒⠠⢈⢐⣼⡓⢽⢻⣃⠓⡇⠸⢂⠀⠀
⠀⠀⠀⠀⠀⠀⣰⠏⢀⠞⠁⠀⠀⠃⠀⠀⢸⢥⠘⢻⡔⠈⠰⠐⡘⠛⡉⢁⠇⠌⠒⡈⢤⣞⡼⠃⡐⢠⢞⣬⣣⡻⢉⠤⣿⡆⠀⣼⠀⠀
⠀⠀⠀⠀⠀⡼⢂⠔⠁⠀⠀⠀⠀⠀⠀⠀⢸⠀⡏⣨⣷⠬⣤⠥⠄⢳⣘⣽⠶⢼⢢⣶⡋⠀⠄⢂⡴⢳⢦⣹⣦⠁⡋⠔⣏⢃⠀⠇⠆⠀
⠀⠀⠀⠀⣨⠇⠁⠀⠀⠀⠀⠀⡄⠃⠀⠀⠌⠀⡇⠙⠛⠁⠀⠁⠀⠀⠀⠀⠉⠂⣕⢮⣭⠷⠸⣘⣎⢎⠯⣵⠋⢠⢋⠰⡯⠼⠀⢸⠃⠀
⠀⠀⠀⡠⡇⠀⠀⠀⠀⠀⠀⢠⢀⠀⠀⡘⠀⠀⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢼⣿⠄⠄⠀⠀⠘⠿⠃⣸⠃⠀⡼⡄⢣⣟⡇⡀⠀⠀⠀
⠀⠀⢰⠎⠀⠀⠀⠀⠀⠀⠀⠈⠸⠀⠰⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡜⠀⠀⠀⠀⢀⠞⠁⠀⢠⣿⣇⢢⠹⠄⡇⠀⠀⠀
⠀⡘⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⡄⠀⡿⡇⠀⠀⠀⢾⡗⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⠀⠀⢀⠀⠀⠁⠀⠀⠀⢦⣟⣧⢸⢽⣻⠇⠸⡆⠀
⠮⠀⠀⠂⠀⠀⠀⠂⠠⠀⠀⢀⠃⡐⠇⠣⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⢿⠛⠤⣀⠉⠀⠀⠀⠀⠀⠀⠘⣾⠘⢧⡏⢶⡟⠇⣳⠁⠀
        ]],
      },
    },
    debug = { enabled = true },
    dim = { enabled = true },
    git = { enabled = true },
    gitbrowse = { enabled = false },
    indent = { enabled = true, animate = { enabled = false } },
    input = { enabled = true },
    notifier = { enabled = true, timeout = 3000 },
    notify = { enabled = true },
    profiler = { enabled = true },
    quickfile = { enabled = true },
    rename = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    ternimal = { enabled = true },
    toggle = { enabled = false },
    win = { enabled = true },
    words = { enabled = true },
    zen = { enabled = true },
  },
  keys = {
    {
      '<leader>z',
      function()
        Snacks.zen()
      end,
      desc = 'Toggle Zen Mode',
    },
    {
      '<leader>Z',
      function()
        Snacks.zen.zoom()
      end,
      desc = 'Toggle Zoom',
    },
    -- {
    --   '<leader>.',
    --   function()
    --     Snacks.scratch()
    --   end,
    --   desc = 'Toggle Scratch Buffer',
    -- },
    -- {
    --   '<leader>S',
    --   function()
    --     Snacks.scratch.select()
    --   end,
    --   desc = 'Select Scratch Buffer',
    -- },
    {
      '<leader>hn',
      function()
        Snacks.notifier.show_history()
      end,
      desc = 'Notification History',
    },
    {
      '<leader>bd',
      function()
        Snacks.bufdelete()
      end,
      desc = 'Delete Buffer',
    },
    -- {
    --   '<leader>cR',
    --   function()
    --     Snacks.rename.rename_file()
    --   end,
    --   desc = 'Rename File',
    -- },
    -- {
    --   '<leader>gb',
    --   function()
    --     Snacks.gitbrowse()
    --   end,
    --   desc = 'Git Browse',
    --   mode = { 'n', 'v' },
    -- },
    -- {
    --   '<leader>gb',
    --   function()
    --     Snacks.git.blame_line()
    --   end,
    --   desc = 'Git Blame Line',
    -- },
    {
      '<leader>gf',
      function()
        Snacks.lazygit.log_file()
      end,
      desc = 'Lazygit Current File History',
    },
    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'Lazygit',
    },
    {
      '<leader>gl',
      function()
        Snacks.lazygit.log()
      end,
      desc = 'Lazygit Log (cwd)',
    },
    {
      '<leader>un',
      function()
        Snacks.notifier.hide()
      end,
      desc = 'Dismiss All Notifications',
    },
    {
      '<c-/>',
      function()
        Snacks.terminal()
      end,
      desc = 'Toggle Terminal',
    },
    {
      '<c-_>',
      function()
        Snacks.terminal()
      end,
      desc = 'which_key_ignore',
    },
    {
      '<leader>ts',
      function()
        vim.cmd 'split | terminal'
      end,
      desc = 'Open Terminal in Horizontal Split',
    },
    {
      '<leader>tv',
      function()
        vim.cmd 'vsplit | terminal'
      end,
      desc = 'Open Terminal in Vertical Split',
    },
    {
      ']]',
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = 'Next Reference',
      mode = { 'n', 't' },
    },
    {
      '[[',
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = 'Prev Reference',
      mode = { 'n', 't' },
    },
    {
      '<leader>N',
      desc = 'Neovim News',
      function()
        Snacks.win {
          file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = 'yes',
            statuscolumn = ' ',
            conceallevel = 3,
          },
        }
      end,
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
        Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
        Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
        -- Snacks.toggle.diagnostics():map '<leader>ud'
        -- Snacks.toggle.line_number():map '<leader>ul'
        -- Snacks.toggle
        --   .option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
        --   :map '<leader>uc'
        -- Snacks.toggle.treesitter():map '<leader>uT'
        Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
        -- Snacks.toggle.inlay_hints():map '<leader>uh'
        Snacks.toggle.indent():map '<leader>ug'
        Snacks.toggle.dim():map '<leader>uD'
      end,
    })
  end,
}
