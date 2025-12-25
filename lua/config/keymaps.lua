-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Must happen before plugins are loaded (otherwise wrong leader will be used)
--vim.g.mapleader = " "
--vim.g.maplocalleader = " "

-- research how to nvim transparent_background,
-- source https://www.reddit.com/r/neovim/comments/1bukmz6/noob_catpuccin_background_not_being_transparent/
-- added 18/05/2024, no joy but didnt cause error
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- tab into  space
vim.opt.expandtab = true

-- disable spellcheck
vim.opt.spell = false

-- number of spaces to use for each step of (auto)indent
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- 14may2024 see video https://youtu.be/N-RFCfs6rxI?si=YMAka6SwAQTucmrq
vim.opt.virtualedit = "block"

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- enable wrap and linebreak
vim.opt.wrap = true
vim.opt.linebreak = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = false

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 999

-- this so i can use sorcerer in nvim/colors 12-may2024
vim.opt.termguicolors = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = false
--vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
--vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
--vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
--vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
--vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- jimmy desu
vim.keymap.set("n", ";", ":", { desc = "CMD enter command mode" })
vim.keymap.set("i", "<C-g>", "<ESC>")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("v", "j", "gj")
vim.keymap.set("v", "k", "gk")
-- jims custom keymaps
vim.keymap.set("n", ";", ":", { desc = "remap semicolon to colon" })
-- jims fold (source grok)
-- vim.api.nvim_create_autocmd({ "BufWinLeave", "BufLeave", "WinLeave" }, {
--   pattern = { "*.*" },
--   callback = function()
--     if vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
--       vim.cmd("mkview")
--     end
--   end,
-- })
-- vim.api.nvim_create_autocmd("BufWinEnter", {
--   pattern = { "*.*" },
--   callback = function()
--     if vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
--       vim.cmd("silent! loadview")
--     end
--   end,
-- })
-- lua/config/keymaps.lua
-- Open all folds
vim.keymap.set("n", "zR", require("ufo").openAllFolds)
-- Close all folds
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
vim.opt.foldmethod = "manual" -- or "indent", "marker", "syntax" based on your preference
vim.opt.foldenable = true -- Enable folding
vim.opt.foldlevelstart = 99 -- Start with all folds open (adjust as needed)
--vim.keymap.set("i", "hh", "<Esc>", { desc = "uu to esc from i" })
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`
--  hh

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
