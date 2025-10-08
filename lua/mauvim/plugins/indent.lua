return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  ---@module "ibl"
  ---@type ibl.config
  opts = {},
  keys = {
    { '<leader>ti', '<cmd>IBLToggle<cr>', mode = 'n', desc = 'Toggle indent blankline', noremap = true, silent = true },
  },
}

-- To toggle, use the built-in comman:
-- :IBLToggle
