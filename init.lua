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

vim.o.backupcopy = "yes"

vim.opt.termguicolors = true
vim.opt.clipboard = 'unnamedplus'

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
  -- 'neovim/nvim-lspconfig',
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp' },

    -- example using `opts` for defining servers
    opts = {
      servers = {
        lua_ls = {},
        ts_ls = {},
        ccsls = {},
      }
    },
    config = function(_, opts)
      local lspconfig = require('lspconfig')
      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end
  },

  -- renamer.nvim
  'filipdutescu/renamer.nvim',

  -- Comment.nvim
  'numToStr/Comment.nvim',

  -- nvim-surround
  'kylechui/nvim-surround',

  -- git-blame.nvim
  'f-person/git-blame.nvim',

  -- mason.nvim
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  -- nvim-cmp
  -- 'hrsh7th/nvim-cmp',
  -- 'hrsh7th/cmp-nvim-lsp',
  -- 'hrsh7th/cmp-nvim-lsp-signature-help',

  -- blink-cmp
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = 'default' },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = false } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },

  -- nvim-treesitter
  { "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = { "c", "cpp", "lua", "rust", "bash", "javascript", "typescript", "tsx", "toml" },
                highlight = { 
                  enable = true, 
                },
            }
        end },

  -- rust-tools
  'simrat39/rust-tools.nvim',
  -- Github Copilot

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
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
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "ts_ls", "cssls" },
  automatic_installation = true,
})

local lspconfig = require('lspconfig')
-- local cmp = require'cmp'
-- cmp.setup({
--   window = {
--     completion = cmp.config.window.bordered(),
--   },
--   sources = cmp.config.sources({
--     { name = 'nvim_lsp' },
--     { name = 'buffer' },
--     { name = 'nvim_lsp_signature_help' },
--   }),
--   mapping = cmp.mapping.preset.insert({
--     ['<C-n>'] = cmp.mapping.select_next_item(),
--     ['<C-p>'] = cmp.mapping.select_prev_item(),
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<C-k><C-k>'] = cmp.mapping.confirm({ select = true }),
--   }),
-- })

-- local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
-- lspconfig.ts_ls.setup {
--   capabilities = cmp_capabilities,
-- }
-- lspconfig.cssls.setup {
--   capabilities = cmp_capabilities,
-- }
-- lspconfig.csharp_ls.setup {
--   capabilities = cmp_capabilities,
-- }

require("rust-tools").setup()

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
    vim.lsp.buf.format()
  end,
})

lspconfig.eslint.setup({
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
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
require('telescope').setup({
  defaults = {
    path_display = {"smart"},
  },
})
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', telescope.find_files)
vim.keymap.set('n', '<C-A-p>', telescope.live_grep)
vim.keymap.set('n', '<C-f>', telescope.grep_string)
vim.keymap.set('n', '<C-t><C-p>', "<cmd>:Telescope live_grep find_command=rg,-g,'!*spec*'<CR>")

-- Nvim Tree
vim.keymap.set('n', '<C-n>', ':NvimTreeFindFileToggle<CR>')

-- LSP
vim.keymap.set('n', '[q', ':cprev<CR>')
vim.keymap.set('n', ']q', ':cnext<CR>')
vim.keymap.set('n', ']a', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', '[a', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', '<C-k><C-i>', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<C-k><C-u>', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', '<C-k><C-r>', '<cmd>lua require("renamer").rename()<CR>')
vim.keymap.set('n', '<C-k><C-f>', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', '<F5>', ':LspRestart<CR>')

-- SETTINGS
-- ========
-- Indentation and Tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Misc
vim.opt.number = true
vim.opt.colorcolumn = '121'
