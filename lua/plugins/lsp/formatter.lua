return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require 'conform'
    local notified = false

    local function file_exists(name)
      local f = io.open(name, 'r')
      if f ~= nil then
        io.close(f)
        return true
      else
        return false
      end
    end

    local function detect_and_notify_formatter()
      if notified then
        return
      end

      -- Biome config files
      if
        file_exists 'biome.json'
        or file_exists 'biome.jsonc'
        or file_exists '.biome.json'
        or file_exists '.biome.jsonc'
      then
        vim.notify('Using Biome formatter', vim.log.levels.INFO, { title = 'Formatter' })
        notified = true
      -- Prettier config files
      elseif
        file_exists '.prettierrc'
        or file_exists '.prettierrc.json'
        or file_exists '.prettierrc.yaml'
        or file_exists '.prettierrc.yml'
        or file_exists '.prettierrc.js'
        or file_exists '.prettierrc.mjs'
        or file_exists '.prettierrc.cjs'
        or file_exists '.prettierrc.toml'
        or file_exists 'prettier.config.js'
        or file_exists 'prettier.config.mjs'
        or file_exists 'prettier.config.cjs'
      then
        vim.notify('Using Prettier formatter', vim.log.levels.INFO, { title = 'Formatter' })
        notified = true
      else
        vim.notify('Using fallback formatters (Biome → Prettier)', vim.log.levels.INFO, { title = 'Formatter' })
        notified = true
      end
    end

    local function get_formatter_for_project()
      -- Biome config files
      if
        file_exists 'biome.json'
        or file_exists 'biome.jsonc'
        or file_exists '.biome.json'
        or file_exists '.biome.jsonc'
      then
        return { 'biome' }
      -- Prettier config files
      elseif
        file_exists '.prettierrc'
        or file_exists '.prettierrc.json'
        or file_exists '.prettierrc.yaml'
        or file_exists '.prettierrc.yml'
        or file_exists '.prettierrc.js'
        or file_exists '.prettierrc.mjs'
        or file_exists '.prettierrc.cjs'
        or file_exists '.prettierrc.toml'
        or file_exists 'prettier.config.js'
        or file_exists 'prettier.config.mjs'
        or file_exists 'prettier.config.cjs'
      then
        return { 'prettier' }
      else
        return { 'biome', 'prettier' }
      end
    end

    -- 何のフォーマッターを使うかを検出して通知する
    vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
      callback = function()
        vim.schedule(detect_and_notify_formatter)
      end,
      once = true,
    })

    conform.setup {
      formatters_by_ft = {
        javascript = get_formatter_for_project,
        typescript = get_formatter_for_project,
        javascriptreact = get_formatter_for_project,
        typescriptreact = get_formatter_for_project,
        svelte = { 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
        json = get_formatter_for_project,
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        graphql = { 'prettier' },
        liquid = { 'prettier' },
        lua = { 'stylua' },
        python = { 'isort', 'black' },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    }
  end,
  keys = {
    {
      '<leader>mp',
      function()
        require('conform').format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        }
      end,
      mode = 'n',
      desc = 'Format file',
    },
    {
      '<leader>mp',
      function()
        require('conform').format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        }
      end,
      mode = 'v',
      desc = 'Format range',
    },
    {
      '<leader>ff',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = 'n',
      desc = 'Format buffer',
    },
    {
      '<leader>fs',
      ':noa w<CR>',
      mode = 'n',
      desc = 'Save without format',
    },
    {
      '<leader>fd',
      function()
        vim.g.disable_autoformat = true
      end,
      mode = 'n',
      desc = 'autoformat-on-save - Disable',
    },
    {
      '<leader>fe',
      function()
        vim.g.disable_autoformat = false
      end,
      mode = 'n',
      desc = 'autoformat-on-save - Enable',
    },
  },
}
