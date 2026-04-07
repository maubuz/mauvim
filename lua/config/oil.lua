require('oil').setup {
  -- take over directory buffers (e.g. `nvim .`) instead of netrw/neo-tree
  default_file_explorer = true,
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
