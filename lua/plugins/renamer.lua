return {
  {
    'filipdutescu/renamer.nvim',
    opts = {},
    keys = {
      {
        '<C-k><C-r>',
        '<cmd>lua require("renamer").rename()<CR>',
        desc = 'Rename variable under cursor',
      }
    },
  },
}
