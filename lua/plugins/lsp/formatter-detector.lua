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

local function has_biome_config()
  return file_exists 'biome.json'
    or file_exists 'biome.jsonc'
    or file_exists '.biome.json'
    or file_exists '.biome.jsonc'
end

local function has_prettier_config()
  return file_exists '.prettierrc'
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
end

local function detect_and_notify_formatter()
  if notified then
    return
  end

  -- Biome config files
  if has_biome_config() then
    vim.notify('Using Biome formatter', vim.log.levels.INFO, { title = 'Formatter' })
    notified = true
  -- Prettier config files
  elseif has_prettier_config() then
    vim.notify('Using Prettier formatter', vim.log.levels.INFO, { title = 'Formatter' })
    notified = true
  else
    vim.notify('Using fallback formatters (Biome → Prettier)', vim.log.levels.INFO, { title = 'Formatter' })
    notified = true
  end
end

local function get_formatter_for_project()
  -- Biome config files
  if has_biome_config() then
    return { 'biome' }
  -- Prettier config files
  elseif has_prettier_config() then
    return { 'prettier' }
  else
    return { 'biome', 'prettier' }
  end
end

local function setup_formatter_detection()
  vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
    callback = function()
      vim.schedule(detect_and_notify_formatter)
    end,
    once = true,
  })
end

return {
  detect_and_notify_formatter = detect_and_notify_formatter,
  get_formatter_for_project = get_formatter_for_project,
  setup_formatter_detection = setup_formatter_detection,
}