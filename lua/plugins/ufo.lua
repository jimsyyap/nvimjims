-- lua/plugins/ufo.lua
return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  opts = {
    -- 1. PREFER TREESITTER PROVIDER
    -- This tells ufo to use treesitter for folding (much smarter than indent),
    -- and fallback to indent if treesitter fails.
    provider_selector = function(bufnr, filetype, buftype)
      return { "treesitter", "indent" }
    end,

    -- 2. IMPROVE VISUALS (FOLD TEXT)
    -- This handler makes the fold line look cleaner:
    -- e.g., "   function name... 󰁂 12 lines "
    fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = (" 󰁂 %d lines "):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0

      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, { chunkText, hlGroup })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          -- str width returned from truncate() may less than 2nd argument, need padding
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end

      table.insert(newVirtText, { suffix, "MoreMsg" })
      return newVirtText
    end,
  },
}
