return {
  {
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("onedark").setup({
        style = "darker",
      })
      require("onedark").load()
    end,
  },
  -- {
  --   "Mofiqul/vscode.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     ---@diagnostic disable-next-line: different-requires
  --     require("vscode").setup({
  --       transparent = true,
  --       italic_comments = false,
  --       underline_links = true,
  --       disable_nvimtree_bg = true,
  --     })
  --     vim.cmd("colorscheme vscode")
  --   end,
  --   enabled = true,
  -- },
}
