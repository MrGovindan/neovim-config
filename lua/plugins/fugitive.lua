return {
  "tpope/vim-fugitive",
  config = function()
    vim.keymap.set("n", "<leader>ms", ":Git<CR>", { desc = "Git status" })
    vim.keymap.set("n", "<leader>mc", ":Git commit<CR>", { desc = "Git commit" })
    vim.keymap.set("n", "<leader>mp", ":Git push<CR>", { desc = "Git push" })
    vim.keymap.set("n", "<leader>ml", ":Git pull<CR>", { desc = "Git pull" })
  end,
}
