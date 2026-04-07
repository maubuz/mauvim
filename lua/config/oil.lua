require('oil').setup {
  keymaps = {
    ['<C-u>'] = 'actions.preview_scroll_up',
    ['<C-d>'] = 'actions.preview_scroll_down',
    ['<C-h>'] = false,
    ['<C-l>'] = false,
  },
}

vim.keymap.set('n', '<leader>o', '<cmd>Oil<cr>', { desc = '[O]il file browser' })
vim.keymap.set('n', '<leader>l', function()
  require('oil').toggle_float()
end, { desc = 'Oil float toggle' })
