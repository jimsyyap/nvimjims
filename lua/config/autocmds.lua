-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--- lua/config/autocmds.lua

local view_group = vim.api.nvim_create_augroup("AutoView", { clear = true })

-- Save the view (folds, cursor) when closing a file or leaving a window
vim.api.nvim_create_autocmd({ "BufWinLeave", "BufWritePost", "WinLeave" }, {
  group = view_group,
  pattern = "?*", -- Matches all files with a filename
  callback = function()
    -- Skip special buffers (like NvimTree, Telescope, etc.)
    if vim.bo.buftype == "" then
      vim.cmd("mkview")
    end
  end,
})

-- Load the view when opening a file
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = view_group,
  pattern = "?*",
  callback = function()
    if vim.bo.buftype == "" then
      -- silent! prevents errors if no view file exists yet
      vim.cmd("silent! loadview")
    end
  end,
})

-- gemini pro capitalize for text markdown files
-- Define the Auto-Capitalization Logic
-- lua/config/autocmds.lua

-- 1. DEFINE COMMON TYPOS
-- Add your own pairs here: { "wrong", "right" }
local common_typos = {
  { "teh", "the" },
  { "adn", "and" },
  { "i", "I" }, -- Capitalize standalone 'i'
  { "dont", "don't" },
  { "wont", "won't" },
  { "cant", "can't" },
  { "im", "I'm" },
  { "ive", "I've" },
  { "taht", "that" },
  { "id", "I'd" },
  { "thier", "their" },
  { "wierd", "weird" },
  { "recieve", "receive" },
}

-- 2. SETUP FUNCTION
local function setup_writing_mode()
  -- A. Enable Auto-Correct (Abbreviations)
  for _, pair in ipairs(common_typos) do
    -- <buffer> ensures this only applies to the current file
    vim.cmd(("iabbrev <buffer> %s %s"):format(pair[1], pair[2]))
  end

  -- B. Enable Auto-Capitalization Logic
  -- (Only attach if not already attached)
  if vim.b.autocaps_enabled then
    return
  end
  vim.b.autocaps_enabled = true

  local function map_char(char, replacement)
    vim.keymap.set("i", char, function()
      -- Check punctuation
      if vim.fn.search([[\v[.!?]\s+%#]], "bcnw") ~= 0 then
        return replacement
      end
      -- Check start of line
      local line = vim.fn.getline(".")
      local col = vim.fn.col(".") - 1
      local before = line:sub(1, col)
      if before:match("^%s*$") then
        return replacement
      end
      return char
    end, { expr = true, buffer = true })
  end

  for i = string.byte("a"), string.byte("z") do
    local lower = string.char(i)
    local upper = string.char(i - 32)
    map_char(lower, upper)
  end
end

-- 3. TRIGGER ON FILETYPE
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text", "markdown", "tex" },
  callback = setup_writing_mode,
})
