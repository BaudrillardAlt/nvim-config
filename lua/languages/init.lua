-- Automatically load all language configurations
local M = {}

local function load_language_configs()
  local configs = {}
  local languages_path = vim.fn.stdpath("config") .. "/lua/languages"

  -- Get all .lua files in the languages directory, excluding init.lua
  local files = vim.fn.glob(languages_path .. "/*.lua", false, true)

  for _, file in ipairs(files) do
    local filename = vim.fn.fnamemodify(file, ":t:r")
    if filename ~= "init" then
      local ok, config = pcall(require, "languages." .. filename)
      if ok and config then
        vim.list_extend(configs, config)
      end
    end
  end

  return configs
end

return load_language_configs()