require('leap').setup {}

-- Default leap mappings
vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward-to)', { desc = 'Leap forward to' })
vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward-to)', { desc = 'Leap backward to' })
vim.keymap.set({ 'n', 'x', 'o' }, 'gs', '<Plug>(leap-from-window)', { desc = 'Leap from window' })
