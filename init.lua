-- Lazy package manager bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
	"git",
	"clone",
	"--filter=blob:none",
	"https://github.com/folke/lazy.nvim.git",
	"--branch=stable", -- latest stable release
	lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

require("lazy").setup({
	-- File explorer
	"nvim-tree/nvim-tree.lua",
	"nvim-tree/nvim-web-devicons",

	-- Theme
	"navarasu/onedark.nvim",

  -- Status Line
  "nvim-lualine/lualine.nvim",
})

-- nvim-tree setup
require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		width = 30,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
})

vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>')

-- onedark
require('onedark').setup {
	style = 'darker'
}
require('onedark').load()

-- lualine
require('lualine').setup()

-- Indentation and Tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
