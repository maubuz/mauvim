require('neo-tree').setup {}

vim.keymap.set('n', '\\', function()
  require('neo-tree.command').execute { toggle = true, reveal = true }
end, { desc = 'Toggle Neo-tree' })

vim.keymap.set('n', '<leader>e', '<cmd>Neotree filesystem toggle<cr>', { desc = 'NeoTree filesystem toggle' })
