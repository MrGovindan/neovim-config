return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep' },
    opts = {
      defaults = {
        path_display = {"smart"},
      },
    },
    keys = {
      { '<C-p>', '<cmd>Telescope find_files<cr>' },
      { '<C-A-p>', '<cmd>Telescope live_grep<cr>' },
      { '<C-f>', '<cmd>Telescope grep_string<cr>' },
      { 
        '<C-t><C-f>',
        function()
          require("telescope.builtin").grep_string({
            additional_args = function()
              return {
                "--glob=!**/*spec.*",
                "--glob=!**/*test.*",
              }
            end,
          })
        end,
      },
    },
  },
}
