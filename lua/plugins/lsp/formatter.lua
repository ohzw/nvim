return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require 'conform'
    local formatter_detector = require 'plugins.lsp.formatter-detector'

    formatter_detector.setup_formatter_detection()

    conform.setup {
      formatters_by_ft = {
        javascript = formatter_detector.get_formatter_for_project,
        typescript = formatter_detector.get_formatter_for_project,
        javascriptreact = formatter_detector.get_formatter_for_project,
        typescriptreact = formatter_detector.get_formatter_for_project,
        svelte = { 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
        json = formatter_detector.get_formatter_for_project,
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
