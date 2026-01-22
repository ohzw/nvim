vim.cmd 'set expandtab'
vim.cmd 'set tabstop=2'
vim.cmd 'set softtabstop=2'
vim.cmd 'set shiftwidth=2'

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.cursorline = true

vim.opt.mouse = 'a'

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 20

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

vim.diagnostic.config { 
  virtual_text = { 
    enable = true 
  }, 
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.HINT] = '󰠠 ',
      [vim.diagnostic.severity.INFO] = ' ',
    }
  }
}

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<C-.>', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })

-- Exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--- Tabs
vim.keymap.set('n', 'tn', '<cmd>tabnext<CR>', { desc = 'go to next tab' })
vim.keymap.set('n', 'tp', '<cmd>tabprevious<CR>', { desc = 'go to previous tab' })

-- Copy file path with line numbers
vim.keymap.set('v', '<leader>l', function()
  local start_line = vim.fn.line 'v'
  local end_line = vim.fn.line '.'
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  local file_path = vim.fn.expand '%:.'
  local path_with_lines

  if start_line == end_line then
    path_with_lines = string.format('@%s:%d', file_path, start_line)
  else
    path_with_lines = string.format('@%s:%d-%d', file_path, start_line, end_line)
  end

  vim.fn.setreg('+', path_with_lines)
  vim.notify(string.format('Copied: %s', path_with_lines), vim.log.levels.INFO)
end, { desc = 'Copy file path with line numbers' })

vim.keymap.set('n', '<leader>l', function()
  local file_path = vim.fn.expand '%:.'
  local line = vim.fn.line '.'
  local path_with_line = string.format('@%s:%d', file_path, line)
  vim.fn.setreg('+', path_with_line)
  vim.notify(string.format('Copied: %s', path_with_line), vim.log.levels.INFO)
end, { desc = 'Copy file path with current line' })
