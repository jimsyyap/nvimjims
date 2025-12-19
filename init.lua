-- bootstrap lazy.nvim, LazyVim and your plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("config.lazy")

for i = string.byte("a"), string.byte("z") do
  local lower = string.char(i)
  local upper = string.char(i - 32)
  vim.keymap.set("i", lower, function()
    return vim.fn.search([[\v[.!?]\s+%#]], "bcnw") ~= 0 and upper or lower
  end, { expr = true })
end

for i = string.byte("A"), string.byte("Z") do
  local upper = string.char(i)
  local lower = string.char(i + 32)
  vim.keymap.set("i", upper, function()
    return vim.fn.search([[\v[.!?]\s+%#]], "bcnw") ~= 0 and lower or upper
  end, { expr = true })
end
