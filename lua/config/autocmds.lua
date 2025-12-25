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
