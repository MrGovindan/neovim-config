return {
  { "mason-org/mason.nvim", opts = {} },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "tsgo",
        "ts_ls",
        -- "llm-ls",
        "cssls",
      },
      -- automatic_installation = true,
      automatic_enabled = false,
    },
  },
}
