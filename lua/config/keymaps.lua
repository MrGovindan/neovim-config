-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
map("n", "<C-h>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
map("n", "<C-l>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "K", function()
  vim.lsp.buf.hover({ border = "double", max_height = 25, max_width = 120 })
end, { desc = "Hover documentation" })

-- { "K", function() vim.lsp.buf.hover { border = "single", max_height = 25, max_width = 120 } end, desc = "Hover documentation" }
