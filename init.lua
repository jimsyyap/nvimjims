-- bootstrap lazy.nvim, LazyVim and your plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("config.lazy")

for i = string.byte("a"), string.byte("z") do
  local lower = string.char(i)
  local upper = string.char(i - 32)
  vim.keymap.set("i", lower, function()
    -- Check if after sentence-ending punctuation
    if vim.fn.search([[\v[.!?]\s+%#]], "bcnw") ~= 0 then
      return upper
    end
    -- Check if at start of line (after only whitespace)
    local line = vim.fn.getline(".")
    local col = vim.fn.col(".") - 1
    local before = line:sub(1, col)
    if before:match("^%s*$") then
      return upper
    end
    return lower
  end, { expr = true })
end

for i = string.byte("A"), string.byte("Z") do
  local upper = string.char(i)
  local lower = string.char(i + 32)
  vim.keymap.set("i", upper, function()
    -- Check if after sentence-ending punctuation
    if vim.fn.search([[\v[.!?]\s+%#]], "bcnw") ~= 0 then
      return lower
    end
    -- Check if at start of line (after only whitespace)
    local line = vim.fn.getline(".")
    local col = vim.fn.col(".") - 1
    local before = line:sub(1, col)
    if before:match("^%s*$") then
      return lower
    end
    return upper
  end, { expr = true })
end
