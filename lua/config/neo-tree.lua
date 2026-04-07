require('neo-tree').setup {
  filesystem = {
    -- disable netrw hijack so oil.nvim handles directory opens instead
    hijack_netrw_behavior = 'disabled',
  },
}

vim.keymap.set('n', '\\', function()
  require('neo-tree.command').execute { toggle = true, reveal = true }
end, { desc = 'Toggle Neo-tree' })

vim.keymap.set('n', '<leader>e', '<cmd>Neotree filesystem toggle<cr>', { desc = 'NeoTree filesystem toggle' })
