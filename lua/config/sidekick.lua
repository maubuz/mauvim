require('sidekick').setup {
  nes = {
    enabled = true,
  },
  cli = {
    watch = true,
    ---@class sidekick.win.Opts
    win = {
      ---@type vim.api.keyset.win_config
      split = {
        width = 0, --80, -- set to 0 for default split width
        height = 0, --20, -- set to 0 for default split height
      },
    },
  },
}

-- NES (Next Edit Suggestions) keymaps
vim.keymap.set('n', ']e', function()
  require('sidekick.nes').jump()
end, { desc = 'Jump to edit suggestion' })

vim.keymap.set('n', '<leader>ea', function()
  require('sidekick.nes').apply()
end, { desc = '[E]dit suggestion [A]pply' })

vim.keymap.set('n', '<leader>ee', function()
  require('sidekick').nes_jump_or_apply()
end, { desc = '[E]dit suggestion jump/apply' })

vim.keymap.set('n', '<leader>ec', function()
  require('sidekick').clear()
end, { desc = '[E]dit suggestion [C]lear' })

vim.keymap.set('n', '<leader>et', function()
  require('sidekick.nes').toggle()
end, { desc = '[E]dit suggestion [T]oggle' })

-- CLI keymaps
vim.keymap.set({ 'n', 'v' }, '<leader>aa', function()
  require('sidekick.cli').toggle { focus = true }
end, { desc = 'Sidekick toggle CLI' })

vim.keymap.set('n', '<leader>as', function()
  require('sidekick.cli').select()
end, { desc = 'Sidekick select CLI tool' })

vim.keymap.set('v', '<leader>as', function()
  require('sidekick.cli').send { selection = true }
end, { desc = 'Sidekick send selection' })

vim.keymap.set({ 'n', 'v' }, '<leader>ap', function()
  require('sidekick.cli').prompt()
end, { desc = 'Sidekick select prompt' })

vim.keymap.set({ 'n', 'x', 'i', 't' }, '<c-.>', function()
  require('sidekick.cli').focus()
end, { desc = 'Sidekick switch focus' })

vim.keymap.set({ 'n', 'v' }, '<leader>ag', function()
  require('sidekick.cli').toggle { name = 'copilot', focus = true }
end, { desc = 'Sidekick Copilot toggle' })

vim.keymap.set({ 'n', 'x' }, '<leader>at', function()
  require("sidekick.cli").send({ msg = "{this}" })
end, { desc = "Send This" })

-- How to use it
-- To use copilot NES do the following:
