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

  -- Tab Line
  { 'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      animation = true,
    },
  },

  -- Fugitive
  'tpope/vim-fugitive',

  -- Telescope
  { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep' } },

  -- nvim-lspconfig
  'neovim/nvim-lspconfig',

  -- renamer.nvim
  'filipdutescu/renamer.nvim',

  -- Comment.nvim
  'numToStr/Comment.nvim',

  -- nvim-surround
  'kylechui/nvim-surround',

  -- git-blame.nvim
  'f-person/git-blame.nvim',

  -- nvim-cmp
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',

  -- lsp_signature.nvim
  'ray-x/lsp_signature.nvim',
})

-- PLUGIN SETUP
-- ============
-- nvim-tree setup
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = {
      min = 30,
      max = -1,
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})


-- onedark
require('onedark').setup {
  style = 'darker'
}
require('onedark').load()

-- lualine
require('lualine').setup({
  sections = { 
    lualine_c = {
      { 'filename', path = 1, }
    }
  }
})

-- renamer
require('renamer').setup()


-- Comment
require('Comment').setup()

-- nvim-surround
require('nvim-surround').setup()

-- nvim-cmp
local lspconfig = require('lspconfig')
local cmp = require'cmp'
cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  }),
  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
})

local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.tsserver.setup {
  capabilities = cmp_capabilities,
}
lspconfig.cssls.setup {
  capabilities = cmp_capabilities,
}

lspconfig.eslint.setup({
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

-- lsp_signature
require 'lsp_signature'.setup({
  transparency = true,
})

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

-- Telescope
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', telescope.find_files)
vim.keymap.set('n', '<C-A-p>', telescope.live_grep)

-- Nvim Tree
vim.keymap.set('n', '<C-n>', ':NvimTreeFindFileToggle<CR>')

-- LSP
vim.keymap.set('n', ']a', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', '[a', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', '<C-k><C-i>', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<C-k><C-u>', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', '<C-k><C-r>', '<cmd>lua require("renamer").rename()<CR>')
vim.keymap.set('n', '<C-k><C-f>', '<cmd>lua vim.lsp.buf.code_action()<CR>')

-- SETTINGS
-- ========
-- Indentation and Tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Misc
vim.opt.number = true
