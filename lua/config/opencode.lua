vim.g.opencode_opts = {
  provider = {
    enabled = 'wezterm',
    wezterm = {
      direction = 'right',
      top_level = false,
      percent = 50,
    },
  },
}

vim.opt.autoread = true

vim.keymap.set({ 'n', 'x' }, '<leader>ia', function()
  require('opencode').ask('@this: ', { submit = true })
end, { desc = 'Ask about this' })
vim.keymap.set({ 'n', 'x' }, '<leader>i+', function()
  require('opencode').prompt '@this'
end, { desc = 'Add this' })
vim.keymap.set({ 'n', 'x' }, '<leader>ie', function()
  require('opencode').prompt('Explain @this and its context', { submit = true })
end, { desc = 'Explain this' })
vim.keymap.set({ 'n', 'x' }, '<leader>is', function()
  require('opencode').select()
end, { desc = 'Select prompt' })
vim.keymap.set('n', '<leader>it', function()
  require('opencode').toggle()
end, { desc = 'Toggle embedded' })
vim.keymap.set('n', '<leader>in', function()
  require('opencode').command 'session_new'
end, { desc = 'New session' })
vim.keymap.set('n', '<leader>ii', function()
  require('opencode').command 'session_interrupt'
end, { desc = 'Interrupt session' })
vim.keymap.set('n', '<S-C-u>', function()
  require('opencode').command 'messages_half_page_up'
end, { desc = 'Messages half page up' })
vim.keymap.set('n', '<S-C-d>', function()
  require('opencode').command 'messages_half_page_down'
end, { desc = 'Messages half page down' })
