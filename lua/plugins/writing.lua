-- lua/plugins/writing.lua
return {
  -- Zen Mode: Centers the text and hides UI elements for focus
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        width = 0.85, -- width will be 85% of the editor width
        options = {
          number = false, -- hide line numbers in Zen Mode
          relativenumber = false,
        },
      },
      plugins = {
        gitsigns = { enabled = true }, -- Keep git signs if you want
        tmux = { enabled = true }, -- Fixes tmux status bar integration
      },
    },
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
  },

  -- Twilight: Dims the text you aren't currently working on
  {
    "folke/twilight.nvim",
    opts = {
      context = 10, -- amount of lines we will try to show around the current line
    },
  },
}
