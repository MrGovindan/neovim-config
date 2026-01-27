-- Lazy package manager bootstrap
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Disable default file explorer plugin
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.backupcopy = "yes"

vim.opt.termguicolors = true
vim.opt.clipboard = 'unnamedplus'

-- Indentation and Tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Misc
vim.opt.number = true
vim.opt.colorcolumn = '121'

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

--
-- Key Maps
-- ========
-- Tabs
vim.keymap.set('n', '<C-h>', '<Cmd>BufferPrevious<CR>')
vim.keymap.set('n', '<C-l>', '<Cmd>BufferNext<CR>')
vim.keymap.set('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>')
vim.keymap.set('n', '<A->>', '<Cmd>BufferMoveNext<CR>')
vim.keymap.set('n', '<A->>', '<Cmd>BufferMoveNext<CR>')

vim.keymap.set('n', '<C-F4>', '<Cmd>BufferClose<CR>')
vim.keymap.set('n', '<A-b><A-o>', '<Cmd>BufferCloseAllButCurrent<CR>')

-- Save
vim.keymap.set('n', '<C-s>', ':w<CR>')
--
--
-- -- LSP
-- vim.lsp.enable('tsgo')
vim.keymap.set('n', '[q', ':cprev<CR>')
vim.keymap.set('n', ']q', ':cnext<CR>')
vim.keymap.set('n', ']a', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', '[a', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', '<C-k><C-i>', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<C-k><C-u>', '<cmd>lua vim.lsp.buf.references()<CR>')
-- vim.keymap.set('n', '<C-k><C-r>', '<cmd>lua require("renamer").rename()<CR>')
vim.keymap.set('n', '<C-k><C-f>', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', '<F5>', ':LspRestart tsgo<CR>')
vim.keymap.set('n', '<F9>', ':LspEslintFixAll<CR>')
--
-- SETTINGS
-- ========
