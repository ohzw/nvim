local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require 'options'
require('lazy').setup {
  spec = {
    { import = 'plugins.themes.catppuccin' },
    { import = 'plugins.themes.transparent' },
    { import = 'plugins.lsp' },
    { import = 'plugins.autopairs' },
    -- { import = 'plugins.avante' },
    { import = 'plugins.bufferline' },
    { import = 'plugins.claudecode' },
    { import = 'plugins.colorful-winsep' },
    { import = 'plugins.colorizer' },
    { import = 'plugins.comment' },
    { import = 'plugins.copilot' },
    -- { import = 'plugins.dressing' },
    { import = 'plugins.dropbar' },
    { import = 'plugins.gitlinker' },
    { import = 'plugins.gitsigns' },
    -- { import = 'plugins.indent-blankline' },
    -- { import = 'plugins.lazygit' },
    { import = 'plugins.leap' },
    { import = 'plugins.lspsaga' },
    { import = 'plugins.lualine' },
    { import = 'plugins.neoclip' },
    -- { import = 'plugins.neoscroll' },
    { import = 'plugins.neotree' },
    { import = 'plugins.nvim-cmp' },
    { import = 'plugins.nvim-surround' },
    { import = 'plugins.scrollbar' },
    { import = 'plugins.session' },
    { import = 'plugins.snacks' },
    { import = 'plugins.supermaven' },
    { import = 'plugins.telescope' },
    { import = 'plugins.treesitter' },
    -- { import = 'plugins.vim-maximizer' },
    { import = 'plugins.vim-sleuth' },
    { import = 'plugins.vim-tmux-navigator' },
    { import = 'plugins.multicursors' },
    { import = 'plugins.which-key' },
  },
  install = { colorscheme = { 'habamax' } },
  checker = { enabled = true },
}
