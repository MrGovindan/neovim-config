-- This plugin manages the file explorer. Usually toggled by the <C-n> shortcut
return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {  "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        '<C-n>',
        ':NvimTreeFindFileToggle<CR>',
        desc = 'Toggle nvim-tree',
      }
    },
    opts = {
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
    },
  },
}
