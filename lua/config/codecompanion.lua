require('codecompanion').setup {
  adapters = {
    copilot = function()
      return require('codecompanion.adapters').extend('copilot', {})
    end,
  },
  strategies = {
    chat = { adapter = 'copilot' },
    inline = { adapter = 'copilot' },
    agent = { adapter = 'copilot' },
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>a', '<cmd>CodeCompanionActions<cr>', { desc = 'CodeCompanion [A]ctions' })
vim.keymap.set({ 'n', 'v' }, '<leader>tc', '<cmd>CodeCompanionChat Toggle<cr>', { desc = '[T]oggle [C]hat' })
vim.keymap.set('v', '<leader>ad', '<cmd>CodeCompanionChat Add<cr>', { desc = '[A][d]d to chat' })
